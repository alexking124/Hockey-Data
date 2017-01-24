//
//  HDTeamSeasonFetcher.m
//  Hockey Data
//
//  Created by Alex King on 1/23/17.
//  Copyright © 2017 Alex King. All rights reserved.
//

#import "HDTeamSeasonFetcher.h"

static NSString * const kSeasonFetcherBaseURL = @"https://hockey-data.firebaseapp.com/seasons/regular/%@.json";

@interface HDTeamSeasonFetcher ()

@property (strong, nonatomic) NSString *teamAbbreviation;

@end

@implementation HDTeamSeasonFetcher

- (instancetype)initWithTeamAbbreviation:(NSString *)teamAbbreviation {
    if (self = [super init]) {
        _teamAbbreviation = teamAbbreviation;
    }
    return self;
}

- (void)fetchSeasonsWithCompletion:(void (^)(void))completionHandler {
    NSString *requestString = [NSString stringWithFormat:kSeasonFetcherBaseURL, self.teamAbbreviation];
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:requestString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching %@ seasons: %@", self.teamAbbreviation, error);
            if (completionHandler) {
                completionHandler();
            }
        }
        if (data) {
            [self parseResponseData:data];
            if (completionHandler) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionHandler();
                });
            }
        }
    }] resume];
}

- (void)parseResponseData:(NSData *)responseData {
    NSArray *seasonsResponse = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:NULL];
    if (!seasonsResponse) {
        return;
    }
    
    for (NSDictionary *season in seasonsResponse) {
        [self addSeasonToRealm:season];
    }
    
}

- (void)addSeasonToRealm:(NSDictionary *)seasonDictionary {
    NSMutableDictionary *realmDictionary = [NSMutableDictionary dictionary];
    
    NSString *season = seasonDictionary[@"Season"];
    if (!season) {
        NSLog(@"Critical: no season provided: %@", seasonDictionary);
        return;
    }
    realmDictionary[@"season"] = season;
    realmDictionary[@"key"] = [NSString stringWithFormat:@"%@%@", self.teamAbbreviation, season];
    realmDictionary[@"teamID"] = self.teamAbbreviation;
    realmDictionary[@"teamName"] = seasonDictionary[@"Team"];
    
    NSNumber *gamesPlayed = seasonDictionary[@"GP"];
    realmDictionary[@"gamesPlayed"] = [gamesPlayed integerValue] ? gamesPlayed : @(0);
    
    NSNumber *wins = seasonDictionary[@"W"];
    realmDictionary[@"wins"] = [wins integerValue] ? wins : @(0);
    
    NSNumber *losses = seasonDictionary[@"L"];
    realmDictionary[@"losses"] = [losses integerValue] ? losses : @(0);
    
    NSNumber *ties = seasonDictionary[@"T"];
    realmDictionary[@"ties"] = [ties integerValue] ? ties : @(0);
    
    NSNumber *overtimeLosses = seasonDictionary[@"OL"];
    realmDictionary[@"overtimeLosses"] = [overtimeLosses integerValue] ? overtimeLosses : @(0);
    
    NSNumber *points = seasonDictionary[@"PTS"];
    realmDictionary[@"points"] = [points integerValue] ? points : @(0);
    
    NSNumber *pointsPercentage = seasonDictionary[@"PTS%"];
    realmDictionary[@"pointsPercentage"] = [pointsPercentage floatValue] ? pointsPercentage : @(0);
    
    NSNumber *simpleRatingSystem = seasonDictionary[@"SRS"];
    realmDictionary[@"simpleRatingSystem"] = [simpleRatingSystem floatValue] ? simpleRatingSystem : @(0);
    
    NSNumber *strengthOfSchedule = seasonDictionary[@"SOS%"];
    realmDictionary[@"strengthOfSchedule"] = [strengthOfSchedule floatValue] ? strengthOfSchedule : @(0);
    
    realmDictionary[@"finish"] = seasonDictionary[@"Finish"];
    realmDictionary[@"playoffs"] = seasonDictionary[@"Playoffs"];
    realmDictionary[@"coaches"] = seasonDictionary[@"Coaches"];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [HDTeamSeason createOrUpdateInRealm:realm withValue:realmDictionary];
    }];
}

@end

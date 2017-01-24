//
//  HDTeamSeason.h
//  Hockey Data
//
//  Created by Alex King on 1/23/17.
//  Copyright © 2017 Alex King. All rights reserved.
//

#import <Realm/Realm.h>

@interface HDTeamSeason : RLMObject

@property NSString *key;
@property NSString *teamID;
@property NSString *teamName;
@property NSString *season;

@property NSInteger gamesPlayed;
@property NSInteger wins;
@property NSInteger losses;
@property NSInteger ties;
@property NSInteger overtimeLosses;
@property NSInteger points;

@property NSNumber<RLMFloat> *pointsPercentage;
@property NSNumber<RLMFloat> *simpleRatingSystem;
@property NSNumber<RLMFloat> *strengthOfSchedule;

@property NSString *finish;
@property NSString *playoffs;
@property NSString *coaches;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<HDTeamSeason *><HDTeamSeason>
RLM_ARRAY_TYPE(HDTeamSeason)

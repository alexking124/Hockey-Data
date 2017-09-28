//
//  HDTeamSeasonFetcher.h
//  Hockey Data
//
//  Created by Alex King on 1/23/17.
//  Copyright © 2017 Alex King. All rights reserved.
//

//#import "HDTeamSeason.h"

#import <Foundation/Foundation.h>

@interface HDTeamSeasonFetcher : NSObject

- (instancetype)initWithTeamAbbreviation:(NSString *)teamAbbreviation;
- (void)fetchSeasonsWithCompletion:(void (^)(void))completionHandler;

@end

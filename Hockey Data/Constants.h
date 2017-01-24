//
//  Constants.h
//  Hockey Data
//
//  Created by Alex King on 5/4/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

+ (NSArray *)NHLTeamAbbreviations;
+ (NSDictionary *)NHLImageLookupDictionary;
+ (NSDictionary *)NHLTeamNameLookupDictionary;
+ (NSString *)NHLTeamID:(NSString *)teamAbbreviation;

@end

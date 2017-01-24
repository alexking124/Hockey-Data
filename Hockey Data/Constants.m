//
//  Constants.m
//  Hockey Data
//
//  Created by Alex King on 5/4/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import "Constants.h"

@implementation Constants

+ (NSArray *)NHLTeamAbbreviations {
    static NSArray *teamAbbreviations;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        teamAbbreviations = @[@"ANA",
                              @"ARI",
                              @"BOS",
                              @"BUF",
                              @"CGY",
                              @"CAR",
                              @"CHI",
                              @"COL",
                              @"CBJ",
                              @"DAL",
                              @"DET",
                              @"EDM",
                              @"FLA",
                              @"LAK",
                              @"MIN",
                              @"MTL",
                              @"NSH",
                              @"NJD",
                              @"NYI",
                              @"NYR",
                              @"OTT",
                              @"PHI",
                              @"PIT",
                              @"SJS",
                              @"STL",
                              @"TBL",
                              @"TOR",
                              @"VAN",
                              @"WSH",
                              @"WPG"];
    });
    return teamAbbreviations;
}

+ (NSDictionary *)NHLImageLookupDictionary {
    static NSDictionary *imageDictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageDictionary = @{@"ANA": @"ducks",
                            @"ARI": @"coyotes",
                            @"BOS": @"bruins",
                            @"BUF": @"sabres",
                            @"CGY": @"flames",
                            @"CAR": @"hurricanes",
                            @"CHI": @"blackhawks",
                            @"COL": @"avalanche",
                            @"CBJ": @"blue_jackets",
                            @"DAL": @"stars",
                            @"DET": @"red_wings",
                            @"EDM": @"oilers",
                            @"FLA": @"panthers",
                            @"LAK": @"kings",
                            @"MIN": @"wild",
                            @"MTL": @"canadiens",
                            @"NSH": @"predators",
                            @"NJD": @"devils",
                            @"NYI": @"islanders",
                            @"NYR": @"rangers",
                            @"OTT": @"senators",
                            @"PHI": @"flyers",
                            @"PIT": @"penguins",
                            @"SJS": @"sharks",
                            @"STL": @"blues",
                            @"TBL": @"lightning",
                            @"TOR": @"maple_leafs",
                            @"VAN": @"canucks",
                            @"WSH": @"capitals",
                            @"WPG": @"jets"};
    });
    return imageDictionary;
}

+ (NSDictionary *)NHLTeamNameLookupDictionary {
    static NSDictionary *imageDictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageDictionary = @{@"ANA": @"Anaheim Ducks",
                            @"ARI": @"Arizona Coyotes",
                            @"BOS": @"Boston Bruins",
                            @"BUF": @"Buffalo Sabres",
                            @"CGY": @"Calgary Flames",
                            @"CAR": @"Carolina Hurricanes",
                            @"CHI": @"Chicago Blackhawks",
                            @"COL": @"Colorado Avalanche",
                            @"CBJ": @"Columbus Blue Jackets",
                            @"DAL": @"Dallas Stars",
                            @"DET": @"Detroit Red Wings",
                            @"EDM": @"Edmonton Oilers",
                            @"FLA": @"Florida Panthers",
                            @"LAK": @"Los Angeles Kings",
                            @"MIN": @"Minnesota Wild",
                            @"MTL": @"Montreal Canadiens",
                            @"NSH": @"Nashville Predators",
                            @"NJD": @"New Jersey Devils",
                            @"NYI": @"New York Islanders",
                            @"NYR": @"New York Rangers",
                            @"OTT": @"Ottawa Senators",
                            @"PHI": @"Philadelphia Flyers",
                            @"PIT": @"Pittsburgh Penguins",
                            @"SJS": @"San Jose Sharks",
                            @"STL": @"St Louis Blues",
                            @"TBL": @"Tampa Bay Lightning",
                            @"TOR": @"Toronto Maple Leafs",
                            @"VAN": @"Vancouver Canucks",
                            @"WSH": @"Washington Capitals",
                            @"WPG": @"Winnipeg Jets"};
    });
    return imageDictionary;
}

+ (NSDictionary *)NHLTeamFoundedYearLookupDictionary {
    static NSDictionary *foundedDictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        foundedDictionary = @{@"ANA": @"1993",
                            @"ARI": @"1972",
                            @"BOS": @"1924",
                            @"BUF": @"1970",
                            @"CGY": @"1972",
                            @"CAR": @"1972",
                            @"CHI": @"1926",
                            @"COL": @"1972",
                            @"CBJ": @"2000",
                            @"DAL": @"1967",
                            @"DET": @"1926",
                            @"EDM": @"1972",
                            @"FLA": @"1993",
                            @"LAK": @"1967",
                            @"MIN": @"2000",
                            @"MTL": @"1909",
                            @"NSH": @"1998",
                            @"NJD": @"1974",
                            @"NYI": @"1972",
                            @"NYR": @"1926",
                            @"OTT": @"1992",
                            @"PHI": @"1967",
                            @"PIT": @"1967",
                            @"SJS": @"1991",
                            @"STL": @"1967",
                            @"TBL": @"1992",
                            @"TOR": @"1917",
                            @"VAN": @"1945",
                            @"WSH": @"1974",
                            @"WPG": @"1999"};
    });
    return foundedDictionary;
}

+ (NSString *)NHLTeamID:(NSString *)teamAbbreviation {
    static NSDictionary *idDictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        idDictionary = @{@"ANA": @"0",
                              @"ARI": @"1",
                              @"BOS": @"2",
                              @"BUF": @"3",
                              @"CGY": @"4",
                              @"CAR": @"5",
                              @"CHI": @"6",
                              @"COL": @"7",
                              @"CBJ": @"8",
                              @"DAL": @"9",
                              @"DET": @"10",
                              @"EDM": @"11",
                              @"FLA": @"12",
                              @"LAK": @"13",
                              @"MIN": @"14",
                              @"MTL": @"15",
                              @"NSH": @"16",
                              @"NJD": @"17",
                              @"NYI": @"18",
                              @"NYR": @"19",
                              @"OTT": @"20",
                              @"PHI": @"21",
                              @"PIT": @"22",
                              @"SJS": @"23",
                              @"STL": @"24",
                              @"TBL": @"25",
                              @"TOR": @"26",
                              @"VAN": @"27",
                              @"WSH": @"28",
                              @"WPG": @"29"};
    });
    return idDictionary[teamAbbreviation];
}

@end

//
//  AKTeamTableViewController.m
//  Hockey Data
//
//  Created by Alex King on 11/17/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import "AKRosterTableViewController.h"
#import "AKTeamColorsTableViewCell.h"
#import "AKTeamCupsTableViewCell.h"
#import "AKTeamGeneralInfoTableViewCell.h"
#import "AKTeamVenueTableViewCell.h"
#import "HDRegularSeasonHistoryTableViewController.h"

#import "AKTeamTableViewController.h"

typedef NS_ENUM(NSInteger, AKTeamLinksCell) {
    AKTeamLinksCellReddit,
    AKTeamLinksCellCapfriendly,
    AKTeamLinksCellSportsClubStats
};

typedef NS_ENUM(NSInteger, AKTeamSection) {
    AKTeamSectionGeneral = 0,
    AKTeamSectionVenue,
    AKTeamSectionCups,
    AKTeamSectionColors,
//    AKTeamSectionRoster,
    AKTeamSectionPastSeasons,
    AKTeamSectionLinks
};

NSUInteger AKTeamSectionCount() {
    return 6;
}

@interface AKTeamTableViewController ()

@property (copy, nonatomic) NSString *teamAbbreviation;
@property (strong, nonatomic) NSDictionary *teamInfoDictionary;

@end

@implementation AKTeamTableViewController

- (instancetype)initWithTeam:(NSString *)teamAbbreviation {
    if (self = [self initWithNibName:@"AKTeamTableViewController" bundle:nil]) {
        _teamAbbreviation = teamAbbreviation;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AKTeamGeneralInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"GeneralCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"GenericCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AKTeamVenueTableViewCell" bundle:nil] forCellReuseIdentifier:@"VenueCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AKTeamCupsTableViewCell" bundle:nil] forCellReuseIdentifier:@"CupsCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AKTeamColorsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ColorsCell"];
    
    [self fetchTeamInfo];
}

- (void)fetchTeamInfo {
    NSURL *dataURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://hockey-data.firebaseapp.com/data/%@.json", self.teamAbbreviation]];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:dataURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) return;
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        if (!dataDictionary) return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.teamInfoDictionary = dataDictionary;
            [self.tableView reloadData];
        });
    }];
    [task resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.teamInfoDictionary) {
        return 0;
    }
    return AKTeamSectionCount();
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == AKTeamSectionLinks) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case AKTeamSectionGeneral: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"GeneralCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[AKTeamGeneralInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GeneralCell"];
            }
            break;
        }
        case AKTeamSectionPastSeasons: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GenericCell"];
            }
            cell.textLabel.text = @"Regular Season History";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;

        }
//        case AKTeamSectionRoster: {
//            cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
//            if (!cell) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GenericCell"];
//            }
//            cell.textLabel.text = @"Roster";
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            break;
//        }
        case AKTeamSectionVenue: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[AKTeamVenueTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VenueCell"];
            }
            break;
        }
        case AKTeamSectionCups: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CupsCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[AKTeamCupsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CupsCell"];
            }
            break;
        }
        case AKTeamSectionColors: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ColorsCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[AKTeamColorsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ColorsCell"];
            }
            break;
        }
        case AKTeamSectionLinks: {
            switch (indexPath.row) {
                case AKTeamLinksCellReddit: {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GenericCell"];
                    }
                    cell.textLabel.text = @"Team Subreddit";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                }
                case AKTeamLinksCellCapfriendly: {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GenericCell"];
                    }
                    cell.textLabel.text = @"CapFriendly Salary Cap Info";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                }
                case AKTeamLinksCellSportsClubStats: {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GenericCell"];
                    }
                    cell.textLabel.text = @"SportsClubStats Playoff Chances";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                }
            }
        }
    }
    
    // Configure the cell...
    if ([cell isKindOfClass:[AKTeamTableViewCell class]]) {
        AKTeamTableViewCell *teamCell = (AKTeamTableViewCell *)cell;
        teamCell.teamAbbreviation = self.teamAbbreviation;
        [teamCell populateWithTeamInfo:self.teamInfoDictionary];
    }
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    return 44;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (indexPath.section) {
//        case AKTeamSectionGeneral:
//            return 120;
//        case AKTeamSectionVenue:
//            return 165;
//        default:
//            break;
//    }
//    return 44;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 0;
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case AKTeamSectionGeneral:
            return @"";
        case AKTeamSectionVenue:
            return @"Venue";
        case AKTeamSectionCups:
            return @"Playoffs";
        case AKTeamSectionColors:
            return @"Colors";
        case AKTeamSectionPastSeasons:
            return @"Past Seasons";
//        case AKTeamSectionRoster:
//            return @"Roster";
        case AKTeamSectionLinks:
            return @"Links";
        default:
            return 0;
    }
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == AKTeamSectionLinks) {
        switch (indexPath.row) {
            case AKTeamLinksCellReddit: {
                [self openLinkURL:@"subreddit"];
                break;
            }
            case AKTeamLinksCellCapfriendly: {
                [self openLinkURL:@"capfriendly"];
                break;
            }
            case AKTeamLinksCellSportsClubStats: {
                [self openLinkURL:@"sportsclubstats"];
                break;
            }
            default:
                break;
        }
    }
//    if (indexPath.section == AKTeamSectionRoster) {
//        AKRosterTableViewController *rosterController = [[AKRosterTableViewController alloc] initWithTeam:self.teamAbbreviation];
//        [self.navigationController pushViewController:rosterController animated:YES];
//    }
    if (indexPath.section == AKTeamSectionPastSeasons) {
        HDRegularSeasonHistoryTableViewController *seasonController = [[HDRegularSeasonHistoryTableViewController alloc] initWithTeam:self.teamAbbreviation];
        [self.navigationController pushViewController:seasonController animated:YES];
    }
}

- (void)openLinkURL:(NSString *)linkType {
    NSDictionary *linksDictionary = self.teamInfoDictionary[@"links"];
    if (!linksDictionary) return;
    NSString *redditLinkString = linksDictionary[linkType];
    if (!redditLinkString) return;
    NSURL *redditURL = [NSURL URLWithString:redditLinkString];
    [[UIApplication sharedApplication] openURL:redditURL];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    headerView.textLabel.font = [UIFont boldSystemFontOfSize:14];
}

@end

//
//  AKTeamTableViewController.m
//  Hockey Data
//
//  Created by Alex King on 11/17/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import "AKRosterTableViewController.h"
#import "AKTeamGeneralInfoTableViewCell.h"
#import "AKTeamVenueTableViewCell.h"

#import "AKTeamTableViewController.h"

typedef NS_ENUM(NSInteger, AKTeamCell) {
    AKTeamCellGeneralInfo = 0,
    AKTeamCellVenue,
    AKTeamCellRoster,
    AKTeamCellReddit,
    AKTeamCellCapfriendly,
    AKTeamCellSportsClubStats
};

NSUInteger AKTeamCellCount() {
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AKTeamGeneralInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"GeneralCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"GenericCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AKTeamVenueTableViewCell" bundle:nil] forCellReuseIdentifier:@"VenueCell"];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return AKTeamCellCount();
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    switch (indexPath.row) {
        case AKTeamCellGeneralInfo: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"GeneralCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[AKTeamGeneralInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GeneralCell"];
            }
            break;
        }
        case AKTeamCellRoster: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GenericCell"];
            }
            cell.textLabel.text = @"Roster";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case AKTeamCellVenue: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[AKTeamVenueTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VenueCell"];
            }
            break;
        }
        case AKTeamCellReddit: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GenericCell"];
            }
            cell.textLabel.text = @"Team Subreddit";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case AKTeamCellCapfriendly: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GenericCell"];
            }
            cell.textLabel.text = @"CapFriendly Salary Cap Info";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case AKTeamCellSportsClubStats: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GenericCell"];
            }
            cell.textLabel.text = @"SportsClubStats Playoff Chances";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case AKTeamCellGeneralInfo:
            return 120;
        case AKTeamCellRoster:
            return 44;
        case AKTeamCellVenue:
            return 165;
            
        default:
            return 44;
            break;
    }
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == AKTeamCellRoster) {
        AKRosterTableViewController *rosterController = [[AKRosterTableViewController alloc] initWithTeam:self.teamAbbreviation];
        [self.navigationController pushViewController:rosterController animated:YES];
    }
}


@end

//
//  HDRegularSeasonHistoryTableViewController.m
//  Hockey Data
//
//  Created by Alex King on 1/23/17.
//  Copyright © 2017 Alex King. All rights reserved.
//

#import "HDRegularSeasonTableViewCell.h"
#import "HDTeamSeasonFetcher.h"

#import "HDRegularSeasonHistoryTableViewController.h"

@interface HDRegularSeasonHistoryTableViewController ()

@property (strong, nonatomic) NSString *teamAbbreviation;
@property (strong, nonatomic) HDTeamSeasonFetcher *seasonFetcher;

@end

@implementation HDRegularSeasonHistoryTableViewController

- (instancetype)initWithTeam:(NSString *)teamAbbreviation {
    if (self = [self initWithNibName:@"HDRegularSeasonHistoryTableViewController" bundle:nil]) {
        _teamAbbreviation = teamAbbreviation;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.seasonFetcher = [[HDTeamSeasonFetcher alloc] initWithTeamAbbreviation:self.teamAbbreviation];
    [self.seasonFetcher fetchSeasonsWithCompletion:^{
        [self.tableView reloadData];
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HDRegularSeasonTableViewCell" bundle:nil] forCellReuseIdentifier:@"RegularSeasonCell"];
}

#pragma mark - Realm

- (RLMResults *)fetchLocalSeasons {
    return [HDTeamSeason objectsWhere:@"teamID = %@", self.teamAbbreviation];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self fetchLocalSeasons].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HDRegularSeasonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegularSeasonCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[HDRegularSeasonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RegularSeasonCell"];
    }
    
    // Configure the cell...
    
    HDTeamSeason *season = [[self fetchLocalSeasons] objectAtIndex:indexPath.row];
    [cell presentTeamSeason:season];
    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[[NSBundle mainBundle] loadNibNamed:@"HDRegularSeasonSectionHeaderView" owner:self options:nil] objectAtIndex:0];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

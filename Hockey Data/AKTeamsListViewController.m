//
//  AKTeamsListViewController.m
//  Hockey Data
//
//  Created by Alex King on 5/4/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import "AKTeamsListTableViewCell.h"
#import "AKTeamTableViewController.h"
#import "Constants.h"

#import "AKTeamsListViewController.h"

@interface AKTeamsListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AKTeamsListViewController

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"Teams";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AKTeamsListTableViewCell" bundle:nil] forCellReuseIdentifier:@"TeamCell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Constants NHLTeamAbbreviations].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTeamsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeamCell"];
    if (!cell) {
        cell = [[AKTeamsListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TeamCell"];
    }
    NSString *teamAbbreviation = [[Constants NHLTeamAbbreviations] objectAtIndex:indexPath.row];
    cell.teamNameLabel.text = [[Constants NHLTeamNameLookupDictionary] objectForKey:teamAbbreviation];
    
    NSString *imageName = [[Constants NHLImageLookupDictionary] objectForKey:teamAbbreviation];
    cell.logoImageView.image = [UIImage imageNamed:imageName];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *team = [[Constants NHLTeamAbbreviations] objectAtIndex:indexPath.row];
    AKTeamTableViewController *teamView = [[AKTeamTableViewController alloc] initWithTeam:team];
    [self.navigationController pushViewController:teamView animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end

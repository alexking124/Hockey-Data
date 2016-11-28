//
//  AKRosterTableViewController.m
//  Hockey Data
//
//  Created by Alex King on 11/17/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import "AKRosterTableViewCell.h"

#import "AKRosterTableViewController.h"

typedef NS_ENUM(NSInteger, RosterType) {
    RosterTypeGoalies = 0,
    RosterTypeDefensemen,
    RosterTypeForwards
};

NSUInteger RosterTypeCount() {
    return 3;
}

@interface AKRosterTableViewController ()

@property (copy, nonatomic) NSString *teamAbbreviation;

@property (copy, nonatomic) NSArray *goalies;
@property (copy, nonatomic) NSArray *defensemen;
@property (copy, nonatomic) NSArray *forwards;

@end

@implementation AKRosterTableViewController

- (instancetype)initWithTeam:(NSString *)teamAbbreviation {
    if (self = [self initWithNibName:@"AKRosterTableViewController" bundle:nil]) {
        _teamAbbreviation = teamAbbreviation;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.goalies = [NSArray array];
    self.defensemen = [NSArray array];
    self.forwards = [NSArray array];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AKRosterTableViewCell" bundle:nil] forCellReuseIdentifier:@"RosterCell"];
    
    [self loadRoster];
}

- (void)loadRoster {
    NSURL *dataURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://nhlwc.cdnak.neulion.com/fs1/nhl/league/teamroster/%@/iphone/clubroster.json", self.teamAbbreviation]];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:dataURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!data) return;
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        if (!dataDictionary) return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSArray *goalies = [dataDictionary objectForKey:@"goalie"];
            if (goalies) {
                self.goalies = goalies;
            }
            NSArray *defensemen = [dataDictionary objectForKey:@"defensemen"];
            if (defensemen) {
                self.defensemen = defensemen;
            }
            NSArray *forwards = [dataDictionary objectForKey:@"forwards"];
            if (forwards) {
                self.forwards = forwards;
            }
            
            [self.tableView reloadData];
        });
    }];
    [task resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.goalies.count && !self.defensemen.count && !self.forwards.count) {
        return 0;
    }
    return RosterTypeCount();
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case RosterTypeGoalies:
            return self.goalies.count;
        case RosterTypeDefensemen:
            return self.defensemen.count;
        case RosterTypeForwards:
            return self.forwards.count;
            
        default:
            return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     AKRosterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RosterCell" forIndexPath:indexPath];
     if (!cell) {
         cell = [[AKRosterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RosterCell"];
     }
    
    NSDictionary *playerInfo;
    switch (indexPath.section) {
        case RosterTypeGoalies:
            playerInfo = self.goalies[indexPath.row];
            break;
        case RosterTypeDefensemen:
            playerInfo = self.defensemen[indexPath.row];
            break;
        case RosterTypeForwards:
            playerInfo = self.forwards[indexPath.row];
            break;
        default:
            break;
    }
    
    cell.playerNameLabel.text = playerInfo[@"name"];
    cell.playerNumberLabel.text = [NSString stringWithFormat:@"#%@", playerInfo[@"number"]];
    
    cell.playerPhotoImageView.image = [UIImage imageNamed:@"default_player_image"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://3.cdn.nhle.com/photos/mugs/thumb/%@.jpg", playerInfo[@"id"]]];
    //TODO: Cache these images
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    AKRosterTableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.playerPhotoImageView.image = image;
                });
            }
        }
    }];
    [task resume];
 
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case RosterTypeGoalies:
            return @"Goalies";
        case RosterTypeDefensemen:
            return @"Defensemen";
        case RosterTypeForwards:
            return @"Forwards";
            
        default:
            return 0;
    }
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end

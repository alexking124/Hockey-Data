//
//  HDRegularSeasonTableViewCell.h
//  Hockey Data
//
//  Created by Alex King on 1/23/17.
//  Copyright © 2017 Alex King. All rights reserved.
//

#import "HDTeamSeason.h"

#import <UIKit/UIKit.h>

@interface HDRegularSeasonTableViewCell : UITableViewCell

- (void)presentTeamSeason:(HDTeamSeason *)season;

@end

//
//  AKTeamTableViewCell.h
//  Hockey Data
//
//  Created by Alex King on 11/17/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKTeamTableViewCell : UITableViewCell

@property (copy, nonatomic) NSString *teamAbbreviation;

- (void)populateWithTeamInfo:(NSDictionary *)teamInfo;

@end

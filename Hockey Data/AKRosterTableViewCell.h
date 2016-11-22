//
//  AKRosterTableViewCell.h
//  Hockey Data
//
//  Created by Alex King on 11/17/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKRosterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *playerPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerNumberLabel;

@end

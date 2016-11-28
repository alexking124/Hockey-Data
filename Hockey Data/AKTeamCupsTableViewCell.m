//
//  AKTeamCupsTableViewCell.m
//  Hockey Data
//
//  Created by Alex King on 11/22/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import "AKTeamCupsTableViewCell.h"

@interface AKTeamCupsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *numberOfCupsLabel;
@property (weak, nonatomic) IBOutlet UILabel *cupYearsLabel;

@end

@implementation AKTeamCupsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)populateWithTeamInfo:(NSDictionary *)teamInfo {
    NSDictionary *playoffDictionary = teamInfo[@"playoffs"];
    if (playoffDictionary) {
        NSArray *championsArray = playoffDictionary[@"stanley_cup_champions"];
        self.numberOfCupsLabel.text = [@(championsArray.count) stringValue];
        self.cupYearsLabel.text = [championsArray componentsJoinedByString:@", "];
    }
}

@end

//
//  AKTeamGeneralInfoTableViewCell.m
//  Hockey Data
//
//  Created by Alex King on 11/17/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import "Constants.h"

#import "AKTeamGeneralInfoTableViewCell.h"

@interface AKTeamGeneralInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *teamLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *foundedLabel;
@property (weak, nonatomic) IBOutlet UILabel *divisionLabel;
@property (weak, nonatomic) IBOutlet UILabel *conferenceLabel;

@end

@implementation AKTeamGeneralInfoTableViewCell

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
    self.teamNameLabel.text = teamInfo[@"team_name"];
    self.divisionLabel.text = teamInfo[@"division"];
    self.conferenceLabel.text = teamInfo[@"conference"];
    self.foundedLabel.text = [NSString stringWithFormat:@"Founded %@", teamInfo[@"founded_year"]];
    
    NSString *imageName = [[Constants NHLImageLookupDictionary] objectForKey:self.teamAbbreviation];
    self.teamLogoImageView.image = [UIImage imageNamed:imageName];
}

@end

//
//  HDRegularSeasonTableViewCell.m
//  Hockey Data
//
//  Created by Alex King on 1/23/17.
//  Copyright © 2017 Alex King. All rights reserved.
//

#import "HDRegularSeasonTableViewCell.h"

@interface HDRegularSeasonTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *seasonLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gamesPlayedLabel;
@property (weak, nonatomic) IBOutlet UILabel *winsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lossesLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiesLabel;
@property (weak, nonatomic) IBOutlet UILabel *otlLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsPercentageLabel;

@end

@implementation HDRegularSeasonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)presentTeamSeason:(HDTeamSeason *)season {
    self.seasonLabel.text = season.season;
    self.teamNameLabel.text = [season.teamName stringByReplacingOccurrencesOfString:@"*" withString:@""];
    self.gamesPlayedLabel.text = [NSString stringWithFormat:@"%ld", (long)season.gamesPlayed];
    self.winsLabel.text = [NSString stringWithFormat:@"%ld", (long)season.wins];
    self.lossesLabel.text = [NSString stringWithFormat:@"%ld", (long)season.losses];
    self.tiesLabel.text = [NSString stringWithFormat:@"%ld", (long)season.ties];
    self.otlLabel.text = [NSString stringWithFormat:@"%ld", (long)season.overtimeLosses];
    self.pointsLabel.text = [NSString stringWithFormat:@"%ld", (long)season.points];
    self.pointsPercentageLabel.text = [NSString stringWithFormat:@"%@", season.pointsPercentage];
}

@end

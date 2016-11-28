//
//  AKTeamColorsTableViewCell.m
//  Hockey Data
//
//  Created by Alex King on 11/22/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import "UIColor+Hex.h"

#import "AKTeamColorsTableViewCell.h"

@interface AKTeamColorsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation AKTeamColorsTableViewCell

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
    NSArray *colors = teamInfo[@"colors"];
    if (!colors) return;
    
    for (NSString *colorString in colors) {
        UIView *colorView = [[UIView alloc] init];
        colorView.backgroundColor = [UIColor colorFromHexString:colorString];
        [self.stackView addArrangedSubview:colorView];
    }
}

@end

//
//  AKTeamVenueTableViewCell.m
//  Hockey Data
//
//  Created by Alex King on 11/17/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import "UIImageView+Remote.h"

#import "AKTeamVenueTableViewCell.h"

@interface AKTeamVenueTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *venueLogo;
@property (weak, nonatomic) IBOutlet UILabel *venueNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *seatingCapacityLabel;

@property (strong, nonatomic) NSString *venueAddress;

@end

@implementation AKTeamVenueTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.venueLogo.image = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)populateWithTeamInfo:(NSDictionary *)teamInfo {
    NSDictionary *stadiumDictionary = teamInfo[@"stadium"];
    if (stadiumDictionary) {
        self.venueNameLabel.text = stadiumDictionary[@"name"];
        self.seatingCapacityLabel.text = [NSString stringWithFormat:@"Seating Capacity: %@", stadiumDictionary[@"capacity"]];
        self.venueAddress = stadiumDictionary[@"address"];
    }
    
    [self.venueLogo downloadImageFromURL:[NSString stringWithFormat:@"https://hockey-data.firebaseapp.com/arena_logos/%@.png", self.teamAbbreviation]];
}

- (IBAction)mapButtonPressed:(id)sender {
    if (!self.venueAddress) return;
    
    NSString *mapURLString = [NSString stringWithFormat:@"http://maps.apple.com/?q=%@", self.venueAddress];
    NSURL *mapURL = [NSURL URLWithString:[mapURLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [[UIApplication sharedApplication] openURL:mapURL];
}

@end

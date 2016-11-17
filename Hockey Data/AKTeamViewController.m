//
//  AKTeamViewController.m
//  Hockey Data
//
//  Created by Alex King on 11/2/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import "Constants.h"
#import "UIImageView+Remote.h"

#import "AKTeamViewController.h"

@interface AKTeamViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *primaryLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *foundedYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *divisionLabel;
@property (weak, nonatomic) IBOutlet UILabel *conferenceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stadiumLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *venueNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueCapacityLabel;

@property (copy, nonatomic) NSString *teamAbbreviation;
@property (copy, nonatomic) NSString *venueAddress;

@end

@implementation AKTeamViewController

- (instancetype)initWithTeam:(NSString *)teamAbbreviation {
    if (self = [self initWithNibName:@"AKTeamViewController" bundle:nil]) {
        _teamAbbreviation = teamAbbreviation;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSString *imageName = [[Constants NHLImageLookupDictionary] objectForKey:self.teamAbbreviation];
    self.primaryLogoImageView.image = [UIImage imageNamed:imageName];
    
    self.teamNameLabel.text = [[Constants NHLTeamNameLookupDictionary] objectForKey:self.teamAbbreviation];
    
    NSURL *dataURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://hockey-data.firebaseapp.com/data/%@.json", self.teamAbbreviation]];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:dataURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) return;
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        if (!dataDictionary) return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.divisionLabel.text = dataDictionary[@"division"];
            self.conferenceLabel.text = dataDictionary[@"conference"];
            self.foundedYearLabel.text = [NSString stringWithFormat:@"Founded %@", dataDictionary[@"founded_year"]];
            
            NSDictionary *stadiumDictionary = dataDictionary[@"stadium"];
            if (stadiumDictionary) {
                self.venueNameLabel.text = stadiumDictionary[@"name"];
                self.venueCapacityLabel.text = [NSString stringWithFormat:@"Seating Capacity: %@", stadiumDictionary[@"capacity"]];
                self.venueAddress = stadiumDictionary[@"address"];
            }
        });
    }];
    [task resume];
    
    self.stadiumLogoImageView.image = nil;
    [self.stadiumLogoImageView downloadImageFromURL:[NSString stringWithFormat:@"https://hockey-data.firebaseapp.com/arena_logos/%@.png", self.teamAbbreviation]];
}

- (IBAction)venueMapButtonPressed:(id)sender {
    if (!self.venueAddress) return;
    
    NSString *mapURLString = [NSString stringWithFormat:@"http://maps.apple.com/?q=%@", self.venueAddress];
    NSURL *mapURL = [NSURL URLWithString:[mapURLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [[UIApplication sharedApplication] openURL:mapURL];
}

@end

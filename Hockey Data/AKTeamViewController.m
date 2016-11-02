//
//  AKTeamViewController.m
//  Hockey Data
//
//  Created by Alex King on 11/2/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import "Constants.h"

#import "AKTeamViewController.h"

@interface AKTeamViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *primaryLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *foundedYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *divisionLabel;
@property (weak, nonatomic) IBOutlet UILabel *conferenceLabel;

@property (copy, nonatomic) NSString *teamAbbreviation;

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
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        if (!dataDictionary) return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.divisionLabel.text = dataDictionary[@"division"];
            self.conferenceLabel.text = dataDictionary[@"conference"];
        });
    }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  UpcomingWeatherViewController.m
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-8.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "UpcomingWeatherViewController.h"

@interface UpcomingWeatherViewController ()

@end

@implementation UpcomingWeatherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setWeatherImage];
    [self setWeekLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate forward

- (void)setWeatherImage
{
    [self.delegate setupWeatherImage];
}

- (void)setWeekLabel
{
    _firstWeekLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:9];
    _firstWeekLabel.textColor = [UIColor colorWithRed:126.0/255.0 green:144.0/255.0 blue:158.0/255.0 alpha:1.0];
    _secondWeekLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:9];
    _secondWeekLabel.textColor = [UIColor colorWithRed:126.0/255.0 green:144.0/255.0 blue:158.0/255.0 alpha:1.0];
    _thirdWeekLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:9];
    _thirdWeekLabel.textColor = [UIColor colorWithRed:126.0/255.0 green:144.0/255.0 blue:158.0/255.0 alpha:1.0];
    _fourthWeekLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:9];
    _fourthWeekLabel.textColor = [UIColor colorWithRed:126.0/255.0 green:144.0/255.0 blue:158.0/255.0 alpha:1.0];
    _fifthWeekLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:9];
    _fifthWeekLabel.textColor = [UIColor colorWithRed:126.0/255.0 green:144.0/255.0 blue:158.0/255.0 alpha:1.0];
    [self.delegate setupWeekLabel];
}

@end

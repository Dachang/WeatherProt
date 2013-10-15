//
//  UpcomingWeatherViewController.m
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-8.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "UpcomingWeatherViewController.h"
#import "UILabel+Font.h"

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
    [self setBackgroundView];
    [self setWeatherImage];
    [self setWeekLabel];
    [self setHighLowTempLabel];
    [self setConditionImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBackgroundView
{
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - delegate forward

- (void)setWeatherImage
{
    [self.delegate setupWeatherImage];
}

- (void)setWeekLabel
{
    [_firstWeekLabel useRobotoBoldFontWithSize:9 Color:[UIColor colorWithRed:126.0/255.0 green:144.0/255.0 blue:158.0/255.0 alpha:1.0]];
    [_secondWeekLabel useRobotoBoldFontWithSize:9 Color:[UIColor colorWithRed:126.0/255.0 green:144.0/255.0 blue:158.0/255.0 alpha:1.0]];
    [_thirdWeekLabel useRobotoBoldFontWithSize:9 Color:[UIColor colorWithRed:126.0/255.0 green:144.0/255.0 blue:158.0/255.0 alpha:1.0]];
    [_fourthWeekLabel useRobotoBoldFontWithSize:9 Color:[UIColor colorWithRed:126.0/255.0 green:144.0/255.0 blue:158.0/255.0 alpha:1.0]];
    [_fifthWeekLabel useRobotoBoldFontWithSize:9 Color:[UIColor colorWithRed:126.0/255.0 green:144.0/255.0 blue:158.0/255.0 alpha:1.0]];
    [self.delegate setupWeekLabel];
}

- (void)setHighLowTempLabel
{
    [_firstHighLowLabel useRobotoBoldCondensedFontWithSize:9 Color:[UIColor colorWithRed:209.0/255.0 green:192.0/255.0 blue:165.0/255.0 alpha:1.0]];
    [_secondHighLowLabel useRobotoBoldCondensedFontWithSize:9 Color:[UIColor colorWithRed:209.0/255.0 green:192.0/255.0 blue:165.0/255.0 alpha:1.0]];
    [_thirdHighLowLabel useRobotoBoldCondensedFontWithSize:9 Color:[UIColor colorWithRed:209.0/255.0 green:192.0/255.0 blue:165.0/255.0 alpha:1.0]];
    [_fourthHighLowLabel useRobotoBoldCondensedFontWithSize:9 Color:[UIColor colorWithRed:209.0/255.0 green:192.0/255.0 blue:165.0/255.0 alpha:1.0]];
    [_fifthHighLowLabel useRobotoBoldCondensedFontWithSize:9 Color:[UIColor colorWithRed:209.0/255.0 green:192.0/255.0 blue:165.0/255.0 alpha:1.0]];
    [self.delegate setupHighLowTempLabel];
}

- (void)setConditionImage
{
    [self.delegate setupConditionImage];
}

@end

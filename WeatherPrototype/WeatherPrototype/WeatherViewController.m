//
//  WeatherViewController.m
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-7.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherModel.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.weather = [WeatherModel sharedWeatherWithCurrentTemp:27 highTemp:33 lowTemp:21 location:@"Shanghai, CH" week:@"TUE" date:@"2013-10-8" condition:@"CLEAR" percip:@"65%" weather:@"sunny"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupBackgroundImage];
}

- (void)setupBackgroundImage
{
    self.backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:self.backgroundImage];
    self.dashboardBackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dashboardBG"]];
    self.dashboardBackgroundImage.frame = CGRectMake(0, self.view.bounds.size.height - self.dashboardBackgroundImage.bounds.size.height, self.dashboardBackgroundImage.bounds.size.width, self.dashboardBackgroundImage.bounds.size.height);
    [self.view addSubview:self.dashboardBackgroundImage];
    self.gardientBackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gardientBG"]];
    self.gardientBackgroundImage.frame = CGRectMake(0, self.view.bounds.size.height - self.dashboardBackgroundImage.bounds.size.height - self.gardientBackgroundImage.bounds.size.height + 1, self.gardientBackgroundImage.bounds.size.width, self.gardientBackgroundImage.bounds.size.height);
    [self.view addSubview:self.gardientBackgroundImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

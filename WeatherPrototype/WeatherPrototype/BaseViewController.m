//
//  BaseViewController.m
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-13.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "BaseViewController.h"

#define WEATHER_VIEW_TAG 1
#define SETTINGS_VIEW_TAG 2
#define SLIDE_TIMING .25

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - init with WeatherViewController

- (void)setupView
{
    self.weatherVC = [[WeatherViewController alloc] init];
    [self.view addSubview:self.weatherVC.view];
    [self addChildViewController:self.weatherVC];
    [self.weatherVC didMoveToParentViewController:self];
}

#pragma mark - reset main view

- (void)resetMainView
{
    if(_settingsVC != nil)
    {
        [self.settingsVC.view removeFromSuperview];
        self.settingsVC = nil;
        
        //handle button
        self.showingSettingsVC = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

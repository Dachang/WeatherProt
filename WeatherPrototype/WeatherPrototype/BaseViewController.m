//
//  BaseViewController.m
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-13.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "BaseViewController.h"

#define WEATHER_VIEW_TAG 1
#define LEFT_PANEL_VIEW_TAG 2
#define SLIDE_TIMING .25
#define PANEL_WIDTH 60

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
    self.weatherVC.view.tag = WEATHER_VIEW_TAG;
    self.weatherVC.delegate = self;
    [self.view addSubview:self.weatherVC.view];
    [self addChildViewController:self.weatherVC];
    [self.weatherVC didMoveToParentViewController:self];
}

#pragma mark - reset main view

- (void)resetMainView
{
    if(_leftPanelVC != nil)
    {
        [self.leftPanelVC.view removeFromSuperview];
        self.leftPanelVC = nil;
        _weatherVC.leftPanelButton.tag = 0;
        self.showingLeftPanelVC = NO;
    }
}

#pragma mark - init left panel view

- (UIView*)getLeftPanelView
{
    if(self.leftPanelVC == nil)
    {
        self.leftPanelVC = [[LeftPanelViewController alloc] init];
        self.leftPanelVC.view.tag = LEFT_PANEL_VIEW_TAG;
        self.leftPanelVC.delegate = _weatherVC;
        
        [self.view addSubview:self.leftPanelVC.view];
        [self addChildViewController:_leftPanelVC];
        [_leftPanelVC didMoveToParentViewController:self];
        
        _leftPanelVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    self.showingLeftPanelVC = YES;
    
    UIView *view = self.leftPanelVC.view;
    return view;
}

#pragma mark - Weather View Controller Delegate

- (void)moveViewRight
{
    NSLog(@"right");
    UIView *childView = [self getLeftPanelView];
    [self.view sendSubviewToBack:childView];
    
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        _weatherVC.view.frame = CGRectMake(self.view.frame.size.width - PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion:^(BOOL finished){
        if(finished)
        {
            _weatherVC.leftPanelButton.tag = 1;
        }
    }];
}

- (void)moveViewToOriginalPosition
{
    NSLog(@"reset");
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        _weatherVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
    } completion:^(BOOL finished){
        if(finished)
        {
            [self resetMainView];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

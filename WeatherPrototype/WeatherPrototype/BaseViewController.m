//
//  BaseViewController.m
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-13.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

#define WEATHER_VIEW_TAG 1
#define LEFT_PANEL_VIEW_TAG 2
#define SLIDE_TIMING .25
#define PANEL_WIDTH 60
#define MINIMUM_STOP_OFFSET 5

@interface BaseViewController ()

//whether left panel view was already appeared
@property (nonatomic, assign) BOOL showingLeftPanelVC;
//whether the view should move right (show left panel) or move back to original position
@property (nonatomic ,assign) BOOL showPanel;
@property (nonatomic ,assign) CGPoint preVelocity;

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
    [self setUpGestures];
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
        [self showWeatherViewWithShadow:NO withOffset:0];
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
    
    [self showWeatherViewWithShadow:YES withOffset:-2];
    UIView *view = self.leftPanelVC.view;
    return view;
}

#pragma mark - Weather View Controller Delegate

- (void)moveViewRight
{
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
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        _weatherVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion:^(BOOL finished){
        if(finished)
        {
            [self resetMainView];
        }
    }];
}

#pragma mark - gesture handler

- (void)setUpGestures
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveView:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setMaximumNumberOfTouches:1];
    [panGesture setDelegate:self];
    
    [_weatherVC.view addGestureRecognizer:panGesture];
}

- (void)moveView: (id)sender
{
    [[[(UIPanGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    CGPoint translatePoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    //STATE_BEGIN
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan)
    {
        UIView *childView = nil;
        if(velocity.x > 0)
        {
            childView = [self getLeftPanelView];
        }
        
        [self.view sendSubviewToBack:childView];
        [[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*) sender view]];
    }
    //STATE_END
    if ([(UIPanGestureRecognizer*) sender state] == UIGestureRecognizerStateEnded)
    {
        if(!_showPanel)
        {
            [self moveViewToOriginalPosition];
        }
        else
        {
            if(_showingLeftPanelVC)
            {
                [self moveViewRight];
            }
        }
    }
    //STATE_CHANGE
    if ([(UIPanGestureRecognizer*) sender state] == UIGestureRecognizerStateChanged)
    {
        if(velocity.x > 0)
        {
            _showPanel = abs([sender view].center.x - _weatherVC.view.frame.size.width/2) > _weatherVC.view.frame.size.width/2;
            
            [sender view].center = CGPointMake([sender view].center.x + translatePoint.x, [sender view].center.y);
            [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0, 0) inView:self.view];
            
            _preVelocity = velocity;
        }
        else
        {
            if(_showingLeftPanelVC && self.weatherVC.view.frame.origin.x > MINIMUM_STOP_OFFSET)
            {
                _showPanel = abs([sender view].center.x - _weatherVC.view.frame.size.width/2) > _weatherVC.view.frame.size.width/2;
                
                [sender view].center = CGPointMake([sender view].center.x + translatePoint.x, [sender view].center.y);
                [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0, 0) inView:self.view];
                
                _preVelocity = velocity;
            }
        }
    }
}

#pragma mark - status bar

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - weather VC shadow

- (void)showWeatherViewWithShadow:(BOOL)value withOffset:(double)offset
{
    if(value)
    {
        [_weatherVC.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [_weatherVC.view.layer setShadowOpacity:0.25];
        [_weatherVC.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
    else
    {
        [_weatherVC.view.layer setCornerRadius:0.0f];
        [_weatherVC.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

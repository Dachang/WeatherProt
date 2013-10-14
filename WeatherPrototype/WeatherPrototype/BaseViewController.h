//
//  BaseViewController.h
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-13.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewController.h"
#import "LeftPanelViewController.h"

@interface BaseViewController : UIViewController <UIGestureRecognizerDelegate, WeatherViewControllerDelegate>

@property (nonatomic, strong) WeatherViewController *weatherVC;
@property (nonatomic, strong) LeftPanelViewController *leftPanelVC;

@end

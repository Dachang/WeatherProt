//
//  WeatherViewController.h
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-7.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherModel;

@interface WeatherViewController : UIViewController

@property (strong, nonatomic) WeatherModel *weather;
@property (strong, nonatomic) UIImageView *backgroundImage;
@property (strong, nonatomic) UIImageView *dashboardBackgroundImage;
@property (strong, nonatomic) UIImageView *gardientBackgroundImage;

@property (strong, nonatomic) UILabel *currentTemperature;
@property (strong, nonatomic) UILabel *highTemperature;
@property (strong, nonatomic) UILabel *lowTemperature;
@property (strong, nonatomic) UILabel *location;
@property (strong, nonatomic) UILabel *week;
@property (strong, nonatomic) UILabel *date;
@property (strong, nonatomic) UILabel *condition;
@property (strong, nonatomic) UILabel *percip;

@property (strong, nonatomic) UIImageView *weatherImage;
@property (strong, nonatomic) UIImageView *LocationIndicator;

@end

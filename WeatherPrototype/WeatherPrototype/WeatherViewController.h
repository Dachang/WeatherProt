//
//  WeatherViewController.h
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-7.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpcomingWeatherViewController.h"
#import "WeatherModelList.h"

@class WeatherModel;

@interface WeatherViewController : UIViewController<UpcomingWeatherDelegate>

@property (strong, nonatomic) WeatherModel *weather;
@property (strong, nonatomic) UIImageView *backgroundImage;
@property (strong, nonatomic) UIImageView *dashboardBackgroundImage;
@property (strong, nonatomic) UIImageView *gardientBackgroundImage;

@property (strong, nonatomic) UILabel *currentTemperature;
@property (strong, nonatomic) UILabel *highLowTemperature;
@property (strong, nonatomic) UILabel *location;
@property (strong, nonatomic) UILabel *week;
@property (strong, nonatomic) UILabel *date;
@property (strong, nonatomic) UILabel *condition;
@property (strong, nonatomic) UILabel *percip;

@property (strong, nonatomic) UIImageView *weatherImage;
@property (strong, nonatomic) UIImageView *LocationIndicator;
@property (strong, nonatomic) UIImageView *tempUnitImage;
@property (strong, nonatomic) UIImageView *highLowImage;
@property (strong, nonatomic) UIImageView *conditionImage;
@property (strong, nonatomic) UIImageView *percipImage;

@property (strong, nonatomic) WeatherModelList *weatherList;
@property (strong, nonatomic) UpcomingWeatherViewController *upcomingWeatherVC;

@property (strong, nonatomic) NSMutableArray *weatherArray;

@end

//
//  WeatherViewController.h
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-7.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpcomingWeatherViewController.h"
#import "LeftPanelViewController.h"
#import "WeatherModelList.h"

@class WeatherModel;

@protocol WeatherViewControllerDelegate <NSObject>

- (void)moveViewRight;
- (void)moveViewToOriginalPosition;

@end

@interface WeatherViewController : UIViewController<UpcomingWeatherDelegate, SettingsViewControllerDelegate,WeatherInfoDelegate>{
    BOOL detailInfoFinished;
    BOOL currentInfoFinished;
}
//Back ground images
@property (strong, nonatomic) UIImageView *backgroundImage;
@property (strong, nonatomic) UIImageView *dashboardBackgroundImage;
@property (strong, nonatomic) UIImageView *gardientBackgroundImage;
//today's weather info label
@property (strong, nonatomic) UILabel *currentTemperature;
@property (strong, nonatomic) UILabel *highLowTemperature;
@property (strong, nonatomic) UILabel *location;
@property (strong, nonatomic) UILabel *week;
@property (strong, nonatomic) UILabel *date;
@property (strong, nonatomic) UILabel *condition;
@property (strong, nonatomic) UILabel *percip;
//today's weather info image
@property (strong, nonatomic) UIImageView *weatherImage;
@property (strong, nonatomic) UIImageView *LocationIndicator;
@property (strong, nonatomic) UIImageView *tempUnitImage;
@property (strong, nonatomic) UIImageView *highLowImage;
@property (strong, nonatomic) UIImageView *conditionImage;
@property (strong, nonatomic) UIImageView *percipImage;
//left panel view
@property (strong, nonatomic) UIButton *leftPanelButton;
@property (nonatomic, assign) id<WeatherViewControllerDelegate> delegate;
//data model
@property (strong, nonatomic) WeatherModelList *weatherList;
//upcoming weather view
@property (strong, nonatomic) UpcomingWeatherViewController *upcomingWeatherVC;
//original data model
@property (strong, nonatomic) NSMutableArray *weatherArray;

@end

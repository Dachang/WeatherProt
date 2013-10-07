//
//  WeatherModel.m
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-7.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel

- (id)initWithCurrentTemp:(NSInteger)currentTemp highTemp:(NSInteger)highTemp lowTemp:(NSInteger)lowTemp location:(NSString *)location week:(NSString *)week date:(NSString *)date condition:(NSString *)condition percip:(NSString *)percip
{
    if(self = [super init])
    {
        _currentTemperature = currentTemp;
        _highTemperature = highTemp;
        _lowTemperature = lowTemp;
        _location = location;
        _week = week;
        _date = date;
        _condition = condition;
        _percip = percip;
    }
    return self;
}

+ (id)sharedWeatherWithCurrentTemp:(NSInteger)currentTemp highTemp:(NSInteger)highTemp lowTemp:(NSInteger)lowTemp location:(NSString *)location week:(NSString *)week date:(NSString *)date condition:(NSString *)condition percip:(NSString *)percip
{
    return [[WeatherModel alloc] initWithCurrentTemp:currentTemp highTemp:highTemp lowTemp:lowTemp location:location week:week date:date condition:condition percip:percip];
}

- (NSInteger)getCurrentTemp { return _currentTemperature; }

- (NSInteger)getHighTemp { return _highTemperature; }

- (NSInteger)getLowTemp { return _lowTemperature; }

- (NSString*)getLocation { return _location; }

- (NSString*)getWeek { return _week; }

- (NSString*)getDate { return _date; }

- (NSString*)getCondition { return _condition; }

- (NSString*)getPercip { return _percip; }

@end

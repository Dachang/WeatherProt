//
//  WeatherModel.m
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-7.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel
@synthesize _week,_location,_date,_condition,_currentTemperature,_highTemperature,_lowTemperature,_percip;

- (id)initWithCurrentTemp:(NSString *)currentTemp highTemp:(NSString *)highTemp lowTemp:(NSString *)lowTemp location:(NSString *)location week:(NSString *)week date:(NSString *)date condition:(NSString *)condition percip:(NSString *)percip weather:(WeatherType)weather
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
        _weather = weather;
    }
    return self;
}

+ (id)sharedWeatherWithCurrentTemp:(NSString *)currentTemp highTemp:(NSString *)highTemp lowTemp:(NSString *)lowTemp location:(NSString *)location week:(NSString *)week date:(NSString *)date condition:(NSString *)condition percip:(NSString *)percip weather:(WeatherType)weather
{
    return [[WeatherModel alloc] initWithCurrentTemp:currentTemp highTemp:highTemp lowTemp:lowTemp location:location week:week date:date condition:condition percip:percip weather:weather];
}

- (NSString *)getCurrentTemp { return _currentTemperature; }

- (NSString *)getHighTemp { return _highTemperature; }

- (NSString *)getLowTemp { return _lowTemperature; }

- (NSString *)getLocation { return _location; }

- (NSString *)getWeek { return _week; }

- (NSString *)getDate { return _date; }

- (NSString *)getCondition { return _condition; }

- (NSString *)getPercip { return _percip; }

- (WeatherType)getWeather { return _weather; }

@end

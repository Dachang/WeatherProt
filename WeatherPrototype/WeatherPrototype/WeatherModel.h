//
//  WeatherModel.h
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-7.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum WeaponType
{
    Clear = 0,
    Cloudy,
    Overcast,
    LightRain,
    MidRain,
    HeavyRain,
    LightSnowy,
    MidSnowy,
    HeavySnowy,
    Windy,
}WeatherType;

@interface WeatherModel : NSObject
{
    NSInteger _currentTemperature;
    NSInteger _highTemperature;
    NSInteger _lowTemperature;
    NSString *_location;
    NSString *_week;
    NSString *_date;
    NSString *_condition;
    NSString *_percip;
    WeatherType _weather;
}

- (id)initWithCurrentTemp:(NSInteger)currentTemp highTemp:(NSInteger)highTemp lowTemp:(NSInteger)lowTemp location:(NSString*)location week:(NSString*)week date:(NSString*)date condition:(NSString*)condition percip:(NSString*)percip weather:(WeatherType)weather;

+ (id)sharedWeatherWithCurrentTemp:(NSInteger)currentTemp highTemp:(NSInteger)highTemp lowTemp:(NSInteger)lowTemp location:(NSString*)location week:(NSString*)week date:(NSString*)date condition:(NSString*)condition percip:(NSString*)percip weather:(WeatherType)weather;

- (NSInteger)getCurrentTemp;
- (NSInteger)getHighTemp;
- (NSInteger)getLowTemp;
- (NSString*)getLocation;
- (NSString*)getWeek;
- (NSString*)getDate;
- (NSString*)getCondition;
- (NSString*)getPercip;
- (WeatherType)getWeather;

@end

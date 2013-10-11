//
//  WeatherModel.h
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-7.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum WeatherType
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
    Thunder,
}WeatherType;

@interface WeatherModel : NSObject
{
    NSInteger _currentTemperature;
    NSInteger _highTemperature;
    NSInteger _lowTemperature;
    NSString *_date;
    NSString *_condition;
    NSString *_percip;
    WeatherType _weather;
}

@property (nonatomic) NSString *_location;
@property (nonatomic) NSString *_week;

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

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
    WeatherType _weather;
}

@property (nonatomic) NSInteger _currentTemperature;
@property (nonatomic) NSInteger _highTemperature;
@property (nonatomic) NSInteger _lowTemperature;
@property (nonatomic) NSString *_location;
@property (nonatomic) NSString *_week;
@property (nonatomic) NSString *_date;
@property (nonatomic) NSString *_condition;
@property (nonatomic) NSString *_percip;

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

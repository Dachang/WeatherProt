//
//  WeatherModelList.h
//  WeatherPrototype
//
//  Created by Fan's Mac on 13-10-11.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherModel.h"

@interface WeatherModelList : NSObject{
    NSString *_intString;
}

@property (nonatomic, weak) WeatherModel *day1;
@property (nonatomic, weak) WeatherModel *day2;
@property (nonatomic, weak) WeatherModel *day3;
@property (nonatomic, weak) WeatherModel *day4;
@property (nonatomic, weak) WeatherModel *day5;
@property (nonatomic, weak) WeatherModel *day6;

- (void)getWeatherWithSixDay;

@end

//
//  WeatherModelList.h
//  WeatherPrototype
//
//  Created by Fan's Mac on 13-10-11.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherModel.h"

@protocol WeatherInfoDelegate

- (void)getCurrentInfoFinished;
- (void)getDetailInfoFinished;

@end

@interface WeatherModelList : NSObject{
    NSString *_intString;
    NSDictionary *currentWeatherinfo;
    NSDictionary *detailWeatherinfo;
}

@property (weak, nonatomic) id<WeatherInfoDelegate> delegate;

- (void)getWeatherWithLocation;
- (void)getWeatherWithCityID:(int)cityID;
- (WeatherModel *)getModelOfDay:(int)index;
- (void)addWeatherModelToArray;

@end

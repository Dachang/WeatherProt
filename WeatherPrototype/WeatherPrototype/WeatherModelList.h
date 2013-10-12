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

- (void)getWeatherWithSixDay;

@end

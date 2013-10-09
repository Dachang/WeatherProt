//
//  UIView+Frame.h
//  WeatherPrototype
//
//  Created by Fan's Mac on 13-10-9.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
//location
#define LOCATION_INDICATOR_POSITION CGRectMake(118, 160, 10, 15)
#define LOCATION_LABEL_POSITION CGRectMake(135, 158, 120, 20)
//weather image
#define WEATHER_IMAGE_POSITION CGRectMake(15, 280, 65, 65)
//date & week
#define DATE_LABEL_POSITION CGRectMake(230, 280, 120, 20)
#define WEEK_LABEL_POSITION CGRectMake(290, 280, 120, 20)
//high/low & condition & percip
#define HIGH_LOW_TEMP_IMAGE_POSITION CGRectMake(98, 338, 36, 6.5)
#define HIGH_LOW_TEMP_LABEL_POSITION CGRectMake(140, 338, 40, 6.5)
#define CONDITION_IMAGE_POSITION CGRectMake(182, 338, 39, 6)
#define CONDITION_LABEL_POSITION CGRectMake(227, 338, 40, 6)
#define PERCIP_IMAGE_POSITION CGRectMake(267, 338, 25, 6)
#define PERCIP_LABEL_POSITION CGRectMake(297, 338, 40, 6)

@interface UIView (Frame)

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x Y:(CGFloat)y;

- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width height:(CGFloat)height;

- (void)setX:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height;

@end

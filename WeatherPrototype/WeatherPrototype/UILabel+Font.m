//
//  UILabel+Font.m
//  WeatherPrototype
//
//  Created by Fan's Mac on 13-10-9.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "UILabel+Font.h"

@implementation UILabel (Font)

- (void)useRobotoBoldFontWithSize:(CGFloat)size
{
    [self setFont:[UIFont fontWithName:@"Roboto-Bold" size:size]];
}

@end

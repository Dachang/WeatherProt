//
//  UILabel+Font.h
//  WeatherPrototype
//
//  Created by Fan's Mac on 13-10-9.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Font)

- (void)useRobotoBoldFontWithSize:(CGFloat)size Color:(UIColor*)color;
- (void)useRobotoCondensedFontWithSize:(CGFloat)size Color:(UIColor*)color;
- (void)useRobotoThinFontWithSize:(CGFloat)size Color:(UIColor*)color;
- (void)useRobotoBoldCondensedFontWithSize:(CGFloat)size Color:(UIColor*)color;

@end

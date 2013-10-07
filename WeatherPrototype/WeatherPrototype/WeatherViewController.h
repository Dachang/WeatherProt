//
//  WeatherViewController.h
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-7.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherModel;

@interface WeatherViewController : UIViewController

@property (strong, nonatomic) WeatherModel *weather;
@property (strong, nonatomic) UIImageView *backgroundImage;

@end

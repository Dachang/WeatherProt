//
//  UpcomingWeatherViewController.h
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-8.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpcomingWeatherDelegate <NSObject>

@required
- (void)setupWeatherImage;
- (void)setupWeekLabel;
@end

@interface UpcomingWeatherViewController : UIViewController
//weather images
@property (strong, nonatomic) IBOutlet UIImageView *firstDayWeatherImage;
@property (strong, nonatomic) IBOutlet UIImageView *secondDayWeatherImage;
@property (strong, nonatomic) IBOutlet UIImageView *thirdDayWeatherImage;
@property (strong, nonatomic) IBOutlet UIImageView *fourthDayWeatherImage;
@property (strong, nonatomic) IBOutlet UIImageView *fifthDayWeatherImage;
//week label
@property (strong, nonatomic) IBOutlet UILabel *firstWeekLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondWeekLabel;
@property (strong, nonatomic) IBOutlet UILabel *thirdWeekLabel;
@property (strong, nonatomic) IBOutlet UILabel *fourthWeekLabel;
@property (strong, nonatomic) IBOutlet UILabel *fifthWeekLabel;

@property (nonatomic, weak) id<UpcomingWeatherDelegate> delegate;

@end

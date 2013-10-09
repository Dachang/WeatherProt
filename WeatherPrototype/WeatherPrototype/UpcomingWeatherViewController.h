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
- (void)setupHighLowTempLabel;
- (void)setupConditionImage;
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
//high/low label
@property (strong, nonatomic) IBOutlet UILabel *firstHighLowLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondHighLowLabel;
@property (strong, nonatomic) IBOutlet UILabel *thirdHighLowLabel;
@property (strong, nonatomic) IBOutlet UILabel *fourthHighLowLabel;
@property (strong, nonatomic) IBOutlet UILabel *fifthHighLowLabel;
//condition image
@property (strong, nonatomic) IBOutlet UIImageView *firstConditionImage;
@property (strong, nonatomic) IBOutlet UIImageView *secondConditionImage;
@property (strong, nonatomic) IBOutlet UIImageView *thirdConditionImage;
@property (strong, nonatomic) IBOutlet UIImageView *fourthConditionImage;
@property (strong, nonatomic) IBOutlet UIImageView *fifthConditionImage;

@property (nonatomic, weak) id<UpcomingWeatherDelegate> delegate;

@end

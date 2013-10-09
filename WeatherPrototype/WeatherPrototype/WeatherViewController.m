//
//  WeatherViewController.m
//  WeatherPrototype
//
//  Created by 大畅 on 13-10-7.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherModel.h"
#import "UILabel+Font.h"
#import "UIView+Frame.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.weather = [WeatherModel sharedWeatherWithCurrentTemp:27 highTemp:33 lowTemp:21 location:@"Shanghai, CH" week:@"TUE" date:@"2013-10-8" condition:@"CLEAR" percip:@"65%" weather:Clear];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupBackgroundImage];
    [self setupWeatherInfo];
    [self initUpcomingWeatherVC];
}

- (void)setupBackgroundImage
{
    self.backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:self.backgroundImage];
    self.dashboardBackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dashboardBG"]];
    self.dashboardBackgroundImage.frame = CGRectMake(0, self.view.bounds.size.height - self.dashboardBackgroundImage.bounds.size.height, self.dashboardBackgroundImage.bounds.size.width, self.dashboardBackgroundImage.bounds.size.height);
    [self.view addSubview:self.dashboardBackgroundImage];
    self.gardientBackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gardientBG"]];
    self.gardientBackgroundImage.frame = CGRectMake(0, self.view.bounds.size.height - self.dashboardBackgroundImage.bounds.size.height - self.gardientBackgroundImage.bounds.size.height + 1, self.gardientBackgroundImage.bounds.size.width, self.gardientBackgroundImage.bounds.size.height);
    [self.view addSubview:self.gardientBackgroundImage];
}

- (void)setupWeatherInfo
{
    //current temperature today
    self.currentTemperature = [[UILabel alloc] init];
    self.currentTemperature.text =[NSString stringWithFormat:@"%d", [self.weather getCurrentTemp]];
    self.currentTemperature.frame = CGRectMake((self.view.bounds.size.width - 130)/2, 50, 130, 130);
    [self.currentTemperature useRobotoThinFontWithSize:68 Color:[UIColor whiteColor]];
    [self.view addSubview:self.currentTemperature];
    //temperature unit
    self.tempUnitImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calculus"]];
    self.tempUnitImage.frame = CGRectMake((self.view.bounds.size.width - 130)/2 + 80, 89, self.tempUnitImage.bounds.size.width, self.tempUnitImage.bounds.size.height);
    [self.view addSubview:self.tempUnitImage];
    //location indicator
    self.LocationIndicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"locationInd"]];
    self.LocationIndicator.frame = LOCATION_INDICATOR_POSITION;
    [self.view addSubview:self.LocationIndicator];
    //location
    self.location = [[UILabel alloc] init];
    self.location.text =[NSString stringWithFormat:@"%@", [self.weather getLocation]];
    self.location.frame = LOCATION_LABEL_POSITION;
    [self.location useRobotoCondensedFontWithSize:13 Color:[UIColor whiteColor]];
    [self.view addSubview:self.location];
    //weather image
    self.weatherImage = [[UIImageView alloc] init];
    self.weatherImage.image = [self setupWeatherImageWithWeather:Clear];
    self.weatherImage.frame = WEATHER_IMAGE_POSITION;
    [self.view addSubview:self.weatherImage];
    //date
    self.date = [[UILabel alloc] init];
    self.date.text = [NSString stringWithFormat:@"%@", [self.weather getDate]];
    self.date.frame = DATE_LABEL_POSITION;
    [self.date useRobotoCondensedFontWithSize:12 Color:[UIColor whiteColor]];
    [self.view addSubview:self.date];
    //week
    self.week = [[UILabel alloc] init];
    self.week.text = [NSString stringWithFormat:@"%@", [self.weather getWeek]];
    self.week.frame = WEEK_LABEL_POSITION;
    [self.week useRobotoCondensedFontWithSize:12 Color:[UIColor whiteColor]];
    [self.view addSubview:self.week];
    //high/low
    self.highLowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"highLow"]];
    self.highLowImage.frame = HIGH_LOW_TEMP_IMAGE_POSITION;
    [self.view addSubview:self.highLowImage];
    self.highLowTemperature = [[UILabel alloc] init];
    self.highLowTemperature.text = [NSString stringWithFormat:@"%d/%d", [self.weather getHighTemp],[self.weather getLowTemp]];
    self.highLowTemperature.frame = HIGH_LOW_TEMP_LABEL_POSITION;
    self.highLowTemperature.alpha = 0.65;
    [self.highLowTemperature useRobotoCondensedFontWithSize:8.5 Color:[UIColor whiteColor]];
    [self.view addSubview:self.highLowTemperature];
    //condition
    self.conditionImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"condition"]];
    self.conditionImage.frame = CONDITION_IMAGE_POSITION;
    [self.view addSubview:self.conditionImage];
    self.condition = [[UILabel alloc] init];
    self.condition.text = [NSString stringWithFormat:@"%@", [self.weather getCondition]];
    self.condition.frame = CONDITION_LABEL_POSITION;
    self.condition.alpha = 0.65;
    [self.condition useRobotoCondensedFontWithSize:8.5 Color:[UIColor whiteColor]];
    [self.view addSubview:self.condition];
    //percip
    self.percipImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"percip"]];
    self.percipImage.frame = PERCIP_IMAGE_POSITION;
    [self.view addSubview:self.percipImage];
    self.percip = [[UILabel alloc] init];
    self.percip.text = [NSString stringWithFormat:@"%@", [self.weather getPercip]];
    self.percip.frame = PERCIP_LABEL_POSITION;
    self.percip.alpha = 0.65;
    [self.percip useRobotoCondensedFontWithSize:8.5 Color:[UIColor whiteColor]];
    [self.view addSubview:self.percip];
}

#pragma mark - Setup Weather Image
- (UIImage*)setupWeatherImageWithWeather:(WeatherType)weather
{
    UIImage *weatherImage = [[UIImage alloc] init];
    
    switch (weather) {
        case Clear:
            return [UIImage imageNamed:@"Sunny"];
            break;
        //add
        default:
            break;
    }
    return weatherImage;
}

#pragma mark - Setup Tiny Weather Image
- (UIImage*)setupTinyWeatherImageWithWeather:(WeatherType)weather
{
    UIImage *tinyWeatherImage = [[UIImage alloc] init];
    
    switch (weather) {
        case Clear:
            return [UIImage imageNamed:@"ClearTiny"];
            break;
        case Overcast:
            return [UIImage imageNamed:@"OvercastTiny"];
            break;
        case Cloudy:
            return [UIImage imageNamed:@"CloudyTiny"];
            break;
        case MidRain:
            return [UIImage imageNamed:@"RainTiny"];
            break;
        case Thunder:
            return [UIImage imageNamed:@"ThunderStromTiny"];
            break;
        default:
            break;
    }
    return tinyWeatherImage;
}

#pragma mark - Init Upcoming Weather ViewController

- (void)initUpcomingWeatherVC
{
    _upcomingWeatherVC = [[UpcomingWeatherViewController alloc] init];
    _upcomingWeatherVC.delegate = self;
    _upcomingWeatherVC.view.frame = CGRectMake(0, self.view.bounds.size.height - _upcomingWeatherVC.view.bounds.size.height, _upcomingWeatherVC.view.bounds.size.width, _upcomingWeatherVC.view.bounds.size.height);
    [self addChildViewController:_upcomingWeatherVC];
    [self.view addSubview:_upcomingWeatherVC.view];
    [_upcomingWeatherVC didMoveToParentViewController:self];
}

#pragma mark - UpcomingWeatherDelegate

- (void)setupWeatherImage
{
    _upcomingWeatherVC.firstDayWeatherImage.image = [self setupTinyWeatherImageWithWeather:MidRain];
    _upcomingWeatherVC.secondDayWeatherImage.image = [self setupTinyWeatherImageWithWeather:Thunder];
    _upcomingWeatherVC.thirdDayWeatherImage.image = [self setupTinyWeatherImageWithWeather:Overcast];
    _upcomingWeatherVC.fourthDayWeatherImage.image = [self setupTinyWeatherImageWithWeather:Cloudy];
    _upcomingWeatherVC.fifthDayWeatherImage.image = [self setupTinyWeatherImageWithWeather:Clear];
}

- (void)setupWeekLabel
{
    _upcomingWeatherVC.firstWeekLabel.text = @"WED";
    _upcomingWeatherVC.secondWeekLabel.text = @"THUR";
    _upcomingWeatherVC.thirdWeekLabel.text = @"FRI";
    _upcomingWeatherVC.fourthWeekLabel.text = @"SAT";
    _upcomingWeatherVC.fifthWeekLabel.text = @"SUN";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

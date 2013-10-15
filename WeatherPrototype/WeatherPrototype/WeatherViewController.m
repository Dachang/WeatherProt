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
@synthesize weatherList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initWeather];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupBackgroundImage];
    [self setupWeatherInfo];
    [self setupLeftPanelButton];
    [self initUpcomingWeatherVC];
}

#pragma mark - init weather object
- (void)initWeather
{
    detailInfoFinished = NO;
    currentInfoFinished = NO;
    
    weatherList = [[WeatherModelList alloc] init];
    weatherList.delegate = self;
    [weatherList getWeatherWithLocation];
    
    _weatherArray = [[NSMutableArray alloc] init];
    
    [_weatherArray addObject:[WeatherModel sharedWeatherWithCurrentTemp:@"27" highTemp:@"33" lowTemp:@"27" location:@"Shanghai, CH" week:@"TUE" date:@"2013-10-8" condition:@"CLEAR" percip:@"65%" weather:Clear]];
    [_weatherArray addObject:[WeatherModel sharedWeatherWithCurrentTemp:@"0" highTemp:@"32" lowTemp:@"25" location:@"Shanghai, CH" week:@"WED" date:@"2013-10-9" condition:@"FAIR" percip:@"-" weather:MidRain]];
    [_weatherArray addObject:[WeatherModel sharedWeatherWithCurrentTemp:@"0" highTemp:@"30" lowTemp:@"23" location:@"Shanghai, CH" week:@"THUR" date:@"2013-10-10" condition:@"CLEAR" percip:@"-" weather:Thunder]];
    [_weatherArray addObject:[WeatherModel sharedWeatherWithCurrentTemp:@"0" highTemp:@"33" lowTemp:@"27" location:@"Shanghai, CH" week:@"FRI" date:@"2013-10-11" condition:@"FAIR" percip:@"-" weather:Overcast]];
    [_weatherArray addObject:[WeatherModel sharedWeatherWithCurrentTemp:@"0" highTemp:@"34" lowTemp:@"25" location:@"Shanghai, CH" week:@"SAT" date:@"2013-10-12" condition:@"FAIR" percip:@"-" weather:Cloudy]];
    [_weatherArray addObject:[WeatherModel sharedWeatherWithCurrentTemp:@"0" highTemp:@"36" lowTemp:@"27" location:@"Shanghai, CH" week:@"SUN" date:@"2013-10-13" condition:@"FAIR" percip:@"-" weather:Clear]];
}

#pragma mark - setup images

- (void)setupBackgroundImage
{
    self.backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    self.backgroundImage.frame = CGRectMake(0, 0, self.backgroundImage.bounds.size.width, self.backgroundImage.bounds.size.height);
    [self.view addSubview:self.backgroundImage];
    //暂时去掉motion effect
//    [self addMotionEffectToView:self.backgroundImage magnitude:40.0];
    self.dashboardBackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dashboardBG"]];
    self.dashboardBackgroundImage.frame = CGRectMake(0, self.view.bounds.size.height - self.dashboardBackgroundImage.bounds.size.height, self.dashboardBackgroundImage.bounds.size.width, self.dashboardBackgroundImage.bounds.size.height);
    [self.view addSubview:self.dashboardBackgroundImage];
    self.gardientBackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gardientBG"]];
    self.gardientBackgroundImage.frame = CGRectMake(0, self.view.bounds.size.height - self.dashboardBackgroundImage.bounds.size.height - self.gardientBackgroundImage.bounds.size.height + 1, self.gardientBackgroundImage.bounds.size.width, self.gardientBackgroundImage.bounds.size.height);
    [self.view addSubview:self.gardientBackgroundImage];
}

#pragma mark - setup current weather UI position

- (void)setupWeatherInfo
{
    //current temperature today
    self.currentTemperature = [[UILabel alloc] init];
    self.currentTemperature.text =[NSString stringWithFormat:@"%ld", (long)[[self.weatherArray objectAtIndex:0] getCurrentTemp]];
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
    self.location.text =[NSString stringWithFormat:@"%@", [[self.weatherArray objectAtIndex:0] getLocation]];
    self.location.frame = LOCATION_LABEL_POSITION;
    [self.location useRobotoCondensedFontWithSize:13 Color:[UIColor whiteColor]];
    [self.view addSubview:self.location];
    //weather image
    self.weatherImage = [[UIImageView alloc] init];
    self.weatherImage.image = [self setupWeatherImageWithWeather:[[self.weatherArray objectAtIndex:0] getWeather]];
    self.weatherImage.frame = WEATHER_IMAGE_POSITION;
    [self.view addSubview:self.weatherImage];
    //date
    self.date = [[UILabel alloc] init];
    self.date.text = [NSString stringWithFormat:@"%@", [[self.weatherArray objectAtIndex:0] getDate]];
    self.date.frame = DATE_LABEL_POSITION;
    [self.date useRobotoCondensedFontWithSize:12 Color:[UIColor whiteColor]];
    [self.view addSubview:self.date];
    //week
    self.week = [[UILabel alloc] init];
    self.week.text = [NSString stringWithFormat:@"%@", [[self.weatherArray objectAtIndex:0] getWeek]];
    self.week.frame = WEEK_LABEL_POSITION;
    [self.week useRobotoCondensedFontWithSize:12 Color:[UIColor whiteColor]];
    [self.view addSubview:self.week];
    //high/low
    self.highLowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"highLow"]];
    self.highLowImage.frame = HIGH_LOW_TEMP_IMAGE_POSITION;
    [self.view addSubview:self.highLowImage];
    self.highLowTemperature = [[UILabel alloc] init];
    self.highLowTemperature.text = [NSString stringWithFormat:@"%ld/%ld℃", (long)[[self.weatherArray objectAtIndex:0] getHighTemp],(long)[[self.weatherArray objectAtIndex:0] getLowTemp]];
    self.highLowTemperature.frame = HIGH_LOW_TEMP_LABEL_POSITION;
    self.highLowTemperature.alpha = 0.65;
    [self.highLowTemperature useRobotoCondensedFontWithSize:8.5 Color:[UIColor whiteColor]];
    [self.view addSubview:self.highLowTemperature];
    //condition
    self.conditionImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"condition"]];
    self.conditionImage.frame = CONDITION_IMAGE_POSITION;
    [self.view addSubview:self.conditionImage];
    self.condition = [[UILabel alloc] init];
    self.condition.text = [NSString stringWithFormat:@"%@", [[self.weatherArray objectAtIndex:0] getCondition]];
    self.condition.frame = CONDITION_LABEL_POSITION;
    self.condition.alpha = 0.65;
    [self.condition useRobotoCondensedFontWithSize:8.5 Color:[UIColor whiteColor]];
    [self.view addSubview:self.condition];
    //percip
    self.percipImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"percip"]];
    self.percipImage.frame = PERCIP_IMAGE_POSITION;
    [self.view addSubview:self.percipImage];
    self.percip = [[UILabel alloc] init];
    self.percip.text = [NSString stringWithFormat:@"%@", [[self.weatherArray objectAtIndex:0] getPercip]];
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

#pragma mark - Setup Condition Image
- (UIImage*)setupConditionImageWithCondition:(NSString*)condition
{
    if ([condition isEqualToString:@"FAIR"])
    {
        return [UIImage imageNamed:@"fair"];
    }
    else return [UIImage imageNamed:@"clear"];
}

#pragma mark - Add Motion Effect

- (void)addMotionEffectToView:(UIView*)view magnitude:(float)magnitude
{
    UIInterpolatingMotionEffect *xMotion = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xMotion.minimumRelativeValue = @(-magnitude);
    xMotion.maximumRelativeValue = @(magnitude);
    
    UIInterpolatingMotionEffect *yMotion = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    yMotion.minimumRelativeValue = @(-magnitude);
    yMotion.maximumRelativeValue = @(magnitude);
    
    UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
    group.motionEffects = @[xMotion, yMotion];
    [view addMotionEffect:group];
}

#pragma mark - left panel Button

- (void)setupLeftPanelButton
{
    _leftPanelButton = [[UIButton alloc] initWithFrame:LEFT_PANEL_BUTTON_POSITION];
    [_leftPanelButton setImage:[UIImage imageNamed:@"settingsButton"] forState:UIControlStateNormal];
    [_leftPanelButton addTarget:self action:@selector(leftPanelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftPanelButton];
}

- (void)leftPanelButtonPressed: (id)sender
{
    UIButton* button = sender;
    
    switch (button.tag) {
        case 0:
        {
            [_delegate moveViewRight];
            break;
        }
        case 1:
        {
            [_delegate moveViewToOriginalPosition];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Init Upcoming Weather ViewController

- (void)initUpcomingWeatherVC
{
    _upcomingWeatherVC = [[UpcomingWeatherViewController alloc] init];
    _upcomingWeatherVC.delegate = self;
    _upcomingWeatherVC.view.frame = CGRectMake(self.view.frame.origin.x, self.view.bounds.size.height - _upcomingWeatherVC.view.bounds.size.height, _upcomingWeatherVC.view.bounds.size.width, _upcomingWeatherVC.view.bounds.size.height);
    [self addChildViewController:_upcomingWeatherVC];
    [self.view addSubview:_upcomingWeatherVC.view];
    [_upcomingWeatherVC didMoveToParentViewController:self];
}

#pragma mark - UpcomingWeatherDelegate

- (void)setupWeatherImage
{
    _upcomingWeatherVC.firstDayWeatherImage.image = [self setupTinyWeatherImageWithWeather:[[self.weatherArray objectAtIndex:1] getWeather]];
    _upcomingWeatherVC.secondDayWeatherImage.image = [self setupTinyWeatherImageWithWeather:[[self.weatherArray objectAtIndex:2] getWeather]];
    _upcomingWeatherVC.thirdDayWeatherImage.image = [self setupTinyWeatherImageWithWeather:[[self.weatherArray objectAtIndex:3] getWeather]];
    _upcomingWeatherVC.fourthDayWeatherImage.image = [self setupTinyWeatherImageWithWeather:[[self.weatherArray objectAtIndex:4] getWeather]];
    _upcomingWeatherVC.fifthDayWeatherImage.image = [self setupTinyWeatherImageWithWeather:[[self.weatherArray objectAtIndex:5] getWeather]];
}

- (void)setupWeekLabel
{
    _upcomingWeatherVC.firstWeekLabel.text = [[self.weatherArray objectAtIndex:1] getWeek];
    _upcomingWeatherVC.secondWeekLabel.text = [[self.weatherArray objectAtIndex:2] getWeek];
    _upcomingWeatherVC.thirdWeekLabel.text = [[self.weatherArray objectAtIndex:3] getWeek];
    _upcomingWeatherVC.fourthWeekLabel.text = [[self.weatherArray objectAtIndex:4] getWeek];
    _upcomingWeatherVC.fifthWeekLabel.text = [[self.weatherArray objectAtIndex:5] getWeek];
}

- (void)setupHighLowTempLabel
{
    _upcomingWeatherVC.firstHighLowLabel.text = [NSString stringWithFormat:@"%@/%@℃", [[self.weatherArray objectAtIndex:1] getHighTemp], [[self.weatherArray objectAtIndex:1] getLowTemp]];
    _upcomingWeatherVC.secondHighLowLabel.text = [NSString stringWithFormat:@"%@/%@℃", [[self.weatherArray objectAtIndex:2] getHighTemp], [[self.weatherArray objectAtIndex:2] getLowTemp]];
    _upcomingWeatherVC.thirdHighLowLabel.text = [NSString stringWithFormat:@"%@/%@℃", [[self.weatherArray objectAtIndex:3] getHighTemp], [[self.weatherArray objectAtIndex:3] getLowTemp]];
    _upcomingWeatherVC.fourthHighLowLabel.text = [NSString stringWithFormat:@"%@/%@℃", [[self.weatherArray objectAtIndex:4] getHighTemp], [[self.weatherArray objectAtIndex:4] getLowTemp]];
    _upcomingWeatherVC.fifthHighLowLabel.text = [NSString stringWithFormat:@"%@/%@℃", [[self.weatherArray objectAtIndex:5] getHighTemp], [[self.weatherArray objectAtIndex:5] getLowTemp]];
}

- (void)setupConditionImage
{
    _upcomingWeatherVC.firstConditionImage.image = [self setupConditionImageWithCondition:[[self.weatherArray objectAtIndex:1] getCondition]];
    _upcomingWeatherVC.secondConditionImage.image = [self setupConditionImageWithCondition:[[self.weatherArray objectAtIndex:2] getCondition]];
    _upcomingWeatherVC.thirdConditionImage.image = [self setupConditionImageWithCondition:[[self.weatherArray objectAtIndex:3] getCondition]];
    _upcomingWeatherVC.fourthConditionImage.image = [self setupConditionImageWithCondition:[[self.weatherArray objectAtIndex:4] getCondition]];
    _upcomingWeatherVC.fifthConditionImage.image = [self setupConditionImageWithCondition:[[self.weatherArray objectAtIndex:5] getCondition]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Mini Function

- (void)setWeatherInfo
{
    NSLog(@"setWeatherInfo");
    [weatherList addWeatherModelToArray];
    for (int i=1; i<7; ++i) {
        [weatherList getModelOfDay:i];
        NSLog(@"%d currenttemp %@,weather %@",i,(WeatherModel *)[weatherList getModelOfDay:i]._currentTemperature,(WeatherModel *)[weatherList getModelOfDay:i]._weather);
    }
}

#pragma mark WeatherInfoDelegate

- (void)getCurrentInfoFinished
{
    NSLog(@"get current info");
    currentInfoFinished = YES;
    if (currentInfoFinished && detailInfoFinished) {
        [self setWeatherInfo];
    }
}

- (void)getDetailInfoFinished
{
    NSLog(@"get detail info");
    detailInfoFinished = YES;
    if (currentInfoFinished && detailInfoFinished) {
        [self setWeatherInfo];
    }
}

@end

//
//  WeatherModelList.m
//  WeatherPrototype
//
//  Created by Fan's Mac on 13-10-11.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "WeatherModelList.h"
#import "CheckNetworking.h"

#define kShowWeatherDayTime 6

@interface WeatherModelList()
@property (strong, nonatomic) NSMutableArray *weatherArray;
@end

@implementation WeatherModelList

- (NSMutableArray *)weatherArray
{
    if (_weatherArray == nil) {
        _weatherArray = [[NSMutableArray alloc] init];
    }
    return _weatherArray;
}

#pragma mark Public Method

- (void)getWeatherWithLocation
{
    //解析网址通过ip 获取城市天气代码
    NSURL *url = [NSURL URLWithString:@"http://61.4.185.48:81/g/"];
    
    //    定义一个NSError对象，用于捕获错误信息
    NSError *error;
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    // 得到城市代码字符串，截取出城市代码
    NSString *Str;
    for (int i = 0; i<=[jsonString length]; i++)
    {
        for (int j = i+1; j <=[jsonString length]; j++)
        {
            Str = [jsonString substringWithRange:NSMakeRange(i, j-i)];
            if ([Str isEqualToString:@"id"]) {
                if (![[jsonString substringWithRange:NSMakeRange(i+3, 1)] isEqualToString:@"c"]) {
                    _intString = [jsonString substringWithRange:NSMakeRange(i+3, 9)];
                    NSLog(@"***%@***",_intString);
                }
            }
        }
    }
    
//    //中国天气网解析地址；
//    NSString *detailPath = @"http://m.weather.com.cn/data/cityNumber.html";     //实时信息
//    NSString *currentPath =  @"http://www.weather.com.cn/data/sk/cityNumber.html";        //详细信息
//    //将城市代码替换到天气解析网址cityNumber 部分！
//    detailPath = [detailPath stringByReplacingOccurrencesOfString:@"cityNumber" withString:_intString];
//    currentPath = [currentPath stringByReplacingOccurrencesOfString:@"cityNumber" withString:_intString];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([CheckNetworking checkNetworkingIsAvailable])
        {
            //中国天气网解析地址；
            NSString *detailPath = @"http://m.weather.com.cn/data/cityNumber.html";     //实时信息
            NSString *currentPath =  @"http://www.weather.com.cn/data/sk/cityNumber.html";        //详细信息
            //将城市代码替换到天气解析网址cityNumber 部分！
            detailPath = [detailPath stringByReplacingOccurrencesOfString:@"cityNumber" withString:_intString];
            currentPath = [currentPath stringByReplacingOccurrencesOfString:@"cityNumber" withString:_intString];
            
            dispatch_queue_t detailQueue = dispatch_queue_create("Load Detail Info", NULL);
            dispatch_async(detailQueue, ^{
                NSError *othererror;
                NSURLResponse *response;
                NSData *detailDataReply;
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: detailPath]];
                [request setHTTPMethod: @"GET"];
                detailDataReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&othererror];
                
                NSError *error;
                NSDictionary *detailWeatherDic = [NSJSONSerialization JSONObjectWithData:detailDataReply options:NSJSONReadingMutableLeaves error:&error];
                detailWeatherinfo = [detailWeatherDic objectForKey:@"weatherinfo"];
                [self.delegate getDetailInfoFinished];
            });
            
            dispatch_queue_t currentQueue = dispatch_queue_create("Load Current Info", NULL);
            dispatch_async(currentQueue, ^{
                NSError *othererror;
                NSURLResponse *response;
                NSData *currentDataReply;
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: currentPath]];
                [request setHTTPMethod: @"GET"];
                currentDataReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&othererror];
                
                NSError *error;
                NSDictionary *currentWeatherDic = [NSJSONSerialization JSONObjectWithData:currentDataReply options:NSJSONReadingMutableLeaves error:&error];
                currentWeatherinfo = [currentWeatherDic objectForKey:@"weatherinfo"];
                [self.delegate getCurrentInfoFinished];
            });
        }
        else
        {
            [_delegate networkUnavailable];
        }
    });
    
//    dispatch_queue_t detailQueue = dispatch_queue_create("Load Detail Info", NULL);
//    dispatch_async(detailQueue, ^{
//        NSError *othererror;
//        NSURLResponse *response;
//        NSData *detailDataReply;
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: detailPath]];
//        [request setHTTPMethod: @"GET"];
//        detailDataReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&othererror];
//        
//        NSError *error;
//        NSDictionary *detailWeatherDic = [NSJSONSerialization JSONObjectWithData:detailDataReply options:NSJSONReadingMutableLeaves error:&error];
//        detailWeatherinfo = [detailWeatherDic objectForKey:@"weatherinfo"];
//        [self.delegate getDetailInfoFinished];
//    });
//    
//    dispatch_queue_t currentQueue = dispatch_queue_create("Load Current Info", NULL);
//    dispatch_async(currentQueue, ^{
//        NSError *othererror;
//        NSURLResponse *response;
//        NSData *currentDataReply;
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: currentPath]];
//        [request setHTTPMethod: @"GET"];
//        currentDataReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&othererror];
//        
//        NSError *error;
//        NSDictionary *currentWeatherDic = [NSJSONSerialization JSONObjectWithData:currentDataReply options:NSJSONReadingMutableLeaves error:&error];
//        currentWeatherinfo = [currentWeatherDic objectForKey:@"weatherinfo"];
//        [self.delegate getCurrentInfoFinished];
//    });
}

- (WeatherModel *)getModelOfDay:(int)index
{
    return [self.weatherArray objectAtIndex:index-1];
}

- (void)addWeatherModelToArray
{
    for (int i=0; i<kShowWeatherDayTime; ++i) {
        WeatherModel *model = [[WeatherModel alloc] initWithCurrentTemp:[self getCurrentTemp] highTemp:[self getHighTempFromData:i+1] lowTemp:[self getLowTempFromData:i+1] location:[self getLocationFromData] week:[self getWeekFromData:i+1] date:[self getDateFromData:i+1] condition:[self getConditionFromData:i] percip:[self getPercip] weather:0];
        [self.weatherArray addObject:model];
    }
}

#pragma mark Private Method

- (NSString *)getCurrentTemp
{
    return [currentWeatherinfo objectForKey:@"temp"];
}

- (NSString *)getHighTempFromData:(int)day
{
    return [[[detailWeatherinfo objectForKey:[@"temp" stringByAppendingString:[NSString stringWithFormat:@"%d",day]]] componentsSeparatedByString:@"~"] objectAtIndex:0];
}

- (NSString *)getLowTempFromData:(int)day
{
    return [[[detailWeatherinfo objectForKey:[@"temp" stringByAppendingString:[NSString stringWithFormat:@"%d",day]]] componentsSeparatedByString:@"~"] objectAtIndex:1];
}

- (NSString *)getLocationFromData
{
    return [detailWeatherinfo objectForKey:@"city"];
}

- (NSString *)getWeekFromData:(int)day
{
    NSString *Today = [detailWeatherinfo objectForKey:@"week"];
    int num = 0;
    if ([Today isEqualToString:@"星期一"])
    {
        num = 1;
    }
    else if ([Today isEqualToString:@"星期二"])
    {
        num = 2;
    }
    else if ([Today isEqualToString:@"星期三"])
    {
        num = 3;
    }
    else if ([Today isEqualToString:@"星期四"])
    {
        num = 4;
    }
    else if ([Today isEqualToString:@"星期五"])
    {
        num = 5;
    }
    else if ([Today isEqualToString:@"星期六"])
    {
        num = 6;
    }
    else if ([Today isEqualToString:@"星期日"])
    {
        num = 7;
    }
    num = num + day - 1;
    if (num > 7)
    {
        num = num - 7;
    }
    switch (num) {
        case 1:
            return @"MON";
            break;
        case 2:
            return @"TUES";
            break;
        case 3:
            return @"WED";
            break;
        case 4:
            return @"THUR";
            break;
        case 5:
            return @"FRI";
            break;
        case 6:
            return @"SAT";
            break;
        case 7:
            return @"SUN";
            break;
        default:
            return @"WRONG";
            break;
    }
}

- (NSString *)getDateFromData:(int)day
{
    return [detailWeatherinfo objectForKey:@"date_y"];
}

- (NSString *)getConditionFromData:(int)day
{
    return [detailWeatherinfo objectForKey:@"city"];
}

- (NSString *)getPercip
{
    return [currentWeatherinfo objectForKey:@"SD"];
}

- (NSString *)getWeatherFromData:(int)day
{
    return [detailWeatherinfo objectForKey:[NSString stringWithFormat:@"weather%d",day]];
}

@end

//
//  WeatherModelList.m
//  WeatherPrototype
//
//  Created by Fan's Mac on 13-10-11.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "WeatherModelList.h"

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

- (void)getWeatherWithSixDay
{
    
    //解析网址通过ip 获取城市天气代码
    NSURL *url = [NSURL URLWithString:@"http://61.4.185.48:81/g/"];
    
    //    定义一个NSError对象，用于捕获错误信息
    NSError *error;
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"------------%@",jsonString);
    
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
    
    //中国天气网解析地址；
    NSString *detailPath=@"http://www.weather.com.cn/data/sk/cityNumber.html";     //实时信息
    //     @"http://m.weather.com.cn/data/cityNumber.html"     //详细信息
    //将城市代码替换到天气解析网址cityNumber 部分！
    detailPath=[detailPath stringByReplacingOccurrencesOfString:@"cityNumber" withString:_intString];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSError *othererror;
        NSURLResponse *response;
        NSData *dataReply;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: detailPath]];
        [request setHTTPMethod: @"GET"];
        dataReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&othererror];
        
        NSError *error;
        NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:dataReply options:NSJSONReadingMutableLeaves error:&error];
        detailWeatherinfo = [weatherDic objectForKey:@"weatherinfo"];
        NSLog(@"weatherinfo %@",detailWeatherinfo);
        
        for (int i=0; i<kShowWeatherDayTime; ++i) {
            WeatherModel *model = [[WeatherModel alloc] initWithCurrentTemp:[[detailWeatherinfo objectForKey:[@"temp" stringByAppendingString:[NSString stringWithFormat:@"%d",i]]] integerValue] highTemp:[self getHighTempFromData:i] lowTemp:[self getLowTempFromData:i] location:[self getLocationFromData] week:[self getWeekFromData:i] date:[self getDateFromData:i] condition:[self getConditionFromData:i] percip:[self getPercipFromData:i] weather:0];
            [self.weatherArray addObject:model];
            NSLog(@"model info %@, %@",model._location,model._week);
        }
    });
}

- (WeatherModel *)getModelOfDay:(int)index
{
    return [self.weatherArray objectAtIndex:index-1];
}

#pragma mark Private Method

- (NSInteger)getCurrentTempFromData:(int)day
{
    return [[currentWeatherinfo objectForKey:@"temp"] integerValue];
}

- (NSInteger)getHighTempFromData:(int)day
{
    return [[detailWeatherinfo objectForKey:[@"temp" stringByAppendingString:[NSString stringWithFormat:@"%d",day]]] integerValue];
}

- (NSInteger)getLowTempFromData:(int)day
{
    return [[detailWeatherinfo objectForKey:[@"temp" stringByAppendingString:[NSString stringWithFormat:@"%d",day]]] integerValue];
}

- (NSString *)getLocationFromData
{
    return [detailWeatherinfo objectForKey:@"city"];
}

- (NSString *)getWeekFromData:(int)day
{
    return [detailWeatherinfo objectForKey:@"week"];
}

- (NSString *)getDateFromData:(int)day
{
    return [detailWeatherinfo objectForKey:@"date_y"];
}

- (NSString *)getConditionFromData:(int)day
{
    return [detailWeatherinfo objectForKey:@"city"];
}

- (NSString *)getPercipFromData:(int)day
{
    return [currentWeatherinfo objectForKey:@"SD"];
}

- (NSString *)getWeatherFromData:(int)day
{
    return [detailWeatherinfo objectForKey:@"cityid"];
}

@end

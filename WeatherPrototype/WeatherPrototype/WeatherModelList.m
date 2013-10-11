//
//  WeatherModelList.m
//  WeatherPrototype
//
//  Created by Fan's Mac on 13-10-11.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "WeatherModelList.h"

@implementation WeatherModelList
@synthesize day1,day2,day3,day4,day5,day6;

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
    NSString *path=@"http://m.weather.com.cn/data/cityNumber.html";
    //将城市代码替换到天气解析网址cityNumber 部分！
    path=[path stringByReplacingOccurrencesOfString:@"cityNumber" withString:_intString];
    
    NSLog(@"path:%@",path);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSError *othererror;
        NSURLResponse *response;
        NSData *dataReply;
        NSString *stringReply;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: path]];
        [request setHTTPMethod: @"GET"];
        dataReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&othererror];
        stringReply = [[NSString alloc] initWithData:dataReply encoding:NSUTF8StringEncoding];
        NSLog(@"%@",stringReply);
    });
}

@end

//
//  CommentCellModel.m
//  MicroBlog
//
//  Created by administrator on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "CommentCellModel.h"
#import "MJExtension.h"
@implementation CommentCellModel
-(NSString *)created_at{
    /*
     服务器返回的_create_at格式为：Thu Oct 16 17:06：25 +0800 2014     （注释：+0800代表东八区）
     dataFormat== EEE MMM dd HH:mm:ss Z yyyy
     */
    
    //配置要转换的日期格式
    NSDateFormatter *format  = [[NSDateFormatter alloc]init] ;
    //如果是真机调试，转换这种欧美时间，需要设置locale
    format.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    format.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    //微博的创建日期 (将_created_at转换成format的格式)
    NSDate *createDate = [format dateFromString:_created_at];
    //当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象 （方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //NSCalendarUnit枚举代表想获取哪些差值，这里获取了年月日时分秒的差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    //这是存储的是createDate和now 两个时间差的年月日时分秒
    NSDateComponents *compare =  [calendar components:unit fromDate:createDate toDate:now options:0];
    //这个存储的是微博创建的时间
    NSDateComponents * createdTime= [calendar components:unit fromDate:createDate];
    //这个存储的是此刻的时间
    NSDateComponents * nowTime = [calendar components:unit fromDate:now];
    
    
    if(createdTime.year == nowTime.year ){ //今年
        if(compare.month >=1){ //一个月前
            return   [NSString stringWithFormat:@"%ld月%ld日",createdTime.month,createdTime.day] ;
        }else if(compare.day>=1){ //一天前，一个月内
            return   [NSString stringWithFormat:@"%ld天前",compare.day] ;
        }else if(compare.hour >=1){ //一小时前，24小时内
            return   [NSString stringWithFormat:@"%ld小时前",compare.hour];
        }else if(compare.minute >=1 ){ //一分钟前，一小时内
            return   [NSString stringWithFormat:@"%ld分钟前",compare.minute] ;
        }else{ //一分钟内，显示刚刚
            return  @"刚刚";
        }
        
    }
    //不是今年
    return [NSString stringWithFormat:@"%ld年%ld月%ld日",createdTime.year,createdTime.month,createdTime.day] ;
}

-(void)setSource:(NSString *)source{
    
    _source =source ;
    if(![_source isEqualToString:@""]){
        NSRange range =  [_source  rangeOfString:@"\">"];
        NSString *myString = [_source substringFromIndex:range.location+range.length];
        NSRange range2 = [myString rangeOfString:@"</a>"];
        NSString *resultString = [myString substringToIndex:range2.location  ];
        
        _source =  [NSString stringWithFormat:@"来自 %@",resultString] ;
    }else{
        _source =  @"来源不明";
    }
}

@end

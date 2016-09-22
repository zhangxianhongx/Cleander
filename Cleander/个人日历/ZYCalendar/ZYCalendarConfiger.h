//
//  ZYCalendarConfiger.h
//  个人日历
//
//  Created by ybon on 16/8/31.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCalendarConfiger : NSObject


+ (instancetype)ShareInstance;

#pragma mark - 计算年月
- (NSInteger)day:(NSDate *)date;
- (NSInteger)month:(NSDate *)date;
- (NSInteger)year:(NSDate *)date;

#pragma mark 计算上一个月的date
- (NSDate *)lastMonth:(NSDate *)date;
#pragma makr 计算下一个月的date
- (NSDate*)nextMonth:(NSDate *)date;

//计算当前月份第一个星期天
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
//计算当前月份的第一天
- (NSInteger)totaldaysInThisMonth:(NSDate *)date;
//计算月份的第一天
- (NSInteger)totaldaysInMonth:(NSDate *)date;

@end

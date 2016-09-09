//
//  CDDateHelper.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/8/4.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDDateHelper.h"

static NSCalendar *_calendar;
@interface CDDateHelper ()

@end

@implementation CDDateHelper

+ (NSCalendar *)calendar
{
    if(!_calendar){
#ifdef __IPHONE_8_0
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
        _calendar.timeZone = [NSTimeZone localTimeZone];
        _calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    }
    
    return _calendar;
}

+ (NSDateFormatter *)createDateFormatter
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    
    dateFormatter.timeZone = self.calendar.timeZone;
    dateFormatter.locale = self.calendar.locale;
    
    return dateFormatter;
}

#pragma mark - Operations

+ (NSDate *)addToDate:(NSDate *)date months:(NSInteger)months
{
    if (date == nil) {
        date = [NSDate date];
    }
    NSDateComponents *components = [NSDateComponents new];
    components.month = months;
    return [self.calendar dateByAddingComponents:components toDate:date options:0];
}

+ (NSDate *)addToDate:(NSDate *)date weeks:(NSInteger)weeks
{
    if (date == nil) {
        date = [NSDate date];
    }
    NSDateComponents *components = [NSDateComponents new];
    components.day = 7 * weeks;
    return [self.calendar dateByAddingComponents:components toDate:date options:0];
}

+ (NSDate *)addToDate:(NSDate *)date days:(NSInteger)days
{
    if (date == nil) {
        date = [NSDate date];
    }
    NSDateComponents *components = [NSDateComponents new];
    components.day = days;
    return [self.calendar dateByAddingComponents:components toDate:date options:0];
}

+ (NSDate *)addToDate:(NSDate *)date hours:(NSInteger)hours
{
    if (date == nil) {
        date = [NSDate date];
    }
    NSDateComponents *components = [NSDateComponents new];
    components.hour = hours;
    return [self.calendar dateByAddingComponents:components toDate:date options:0];
}

#pragma mark - Helpers
/**
 *  返回两个日期之间间隔的天数
 *
 *  @param startDate 开始日期
 *  @param endDate   结束日期
 *
 *  @return  间隔的总天数
 */
+ (NSInteger)numberBetweenStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate
{
    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:startDate toDate:endDate options:0];
    NSInteger days = components.year * 365 + components.month * 30 + components.weekOfMonth * 7 + components.day;
    return days;
}

+ (NSUInteger)numberOfWeeks:(NSDate *)date
{
    NSDate *firstDay = [self firstDayOfMonth:date];
    NSDate *lastDay = [self lastDayOfMonth:date];
    
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitWeekOfYear fromDate:firstDay];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitWeekOfYear fromDate:lastDay];
    
    // weekOfYear may return 53 for the first week of the year
    return (componentsB.weekOfYear - componentsA.weekOfYear + 52 + 1) % 52;
}

+ (NSDate *)firstDayOfMonth:(NSDate *)date
{
    NSDateComponents *componentsCurrentDate = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month;
    componentsNewDate.weekOfMonth = 1;
    componentsNewDate.day = 1;
    
    return [self.calendar dateFromComponents:componentsNewDate];
}

+ (NSDate *)lastDayOfMonth:(NSDate *)date
{
    NSDateComponents *componentsCurrentDate = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month + 1;
    componentsNewDate.day = 0;
    
    return [self.calendar dateFromComponents:componentsNewDate];
}

+ (NSDate *)firstWeekDayOfMonth:(NSDate *)date
{
    NSDate *firstDayOfMonth = [self firstDayOfMonth:date];
    return [self firstWeekDayOfWeek:firstDayOfMonth];
}

+ (NSDate *)firstWeekDayOfWeek:(NSDate *)date
{
    NSDateComponents *componentsCurrentDate = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month;
    componentsNewDate.weekOfMonth = componentsCurrentDate.weekOfMonth;
    componentsNewDate.weekday = self.calendar.firstWeekday;
    
    return [self.calendar dateFromComponents:componentsNewDate];
}

#pragma mark - Comparaison

+ (BOOL)date:(NSDate *)dateA isTheSameMonthThan:(NSDate *)dateB
{
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:dateA];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:dateB];
    
    return componentsA.year == componentsB.year && componentsA.month == componentsB.month;
}

+ (BOOL)date:(NSDate *)dateA isTheSameWeekThan:(NSDate *)dateB
{
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:dateA];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:dateB];
    
    return componentsA.year == componentsB.year && componentsA.weekOfYear == componentsB.weekOfYear;
}

+ (BOOL)date:(NSDate *)dateA isTheSameDayThan:(NSDate *)dateB
{
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateA];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateB];
    
    return componentsA.year == componentsB.year && componentsA.month == componentsB.month && componentsA.day == componentsB.day;
}

+ (BOOL)date:(NSDate *)dateA isEqualOrBefore:(NSDate *)dateB
{
    if([dateA compare:dateB] == NSOrderedAscending || [self date:dateA isTheSameDayThan:dateB]){
        return YES;
    }
    
    return NO;
}

+ (BOOL)date:(NSDate *)dateA isEqualOrAfter:(NSDate *)dateB
{
    if([dateA compare:dateB] == NSOrderedDescending || [self date:dateA isTheSameDayThan:dateB]){
        return YES;
    }
    
    return NO;
}

+ (BOOL)date:(NSDate *)date isEqualOrAfter:(NSDate *)startDate andEqualOrBefore:(NSDate *)endDate
{
    //    if([self date:date isEqualOrAfter:startDate] && [self date:date isEqualOrBefore:endDate]){
    //        return YES;
    //    }
    //
    //    return NO;
    
#pragma mark   Modify
    BOOL  isAfter;
    if (startDate == nil) {
        isAfter = YES;
    } else {
        isAfter = [self date:date isEqualOrAfter:startDate];
    }
    
    BOOL  isEnd;
    if (endDate == nil) {
        isEnd = YES;
    } else {
        isEnd = [self date:date isEqualOrBefore:endDate];
    }
    
    //  最终结果
    if(isAfter && isEnd){
        return YES;
    } else {
        return NO;
    }
}

#pragma mark  show
+ (NSDate *)today
{
    return [NSDate date];
}

/**
 *  按照指定的format格式转换一个日期，返回转换后的字符串
 *
 *  @param date   需要转换的日期
 *  @param format 转换格式
 *
 *  @return 转换后的字符串
 */
+ (NSString *)date:(NSDate *)date toStringByFormat:(NSString *)format
{
    static NSDateFormatter *dateFormatter = nil;
    if(!dateFormatter){
        dateFormatter = [self createDateFormatter];
    }
    //  eg : format = @"MMMM yyyy" ;  format = @"dd"  ;
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

/**
 *  获取某个日期是星期几
 *
 *  @param date 日期实例
 *
 *  @return 星期值
 */
+ (NSString *)getWeekdayStringWithDate:(NSDate *)date
{
    NSArray *weekdays = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday fromDate:date];
    if (components.weekday-1 < [weekdays count]) {
        return weekdays[components.weekday-1];
    } else {
        return @"";
    }
}

+ (CDCalendarWeekdays)getWeekdayWithDate:(NSDate *)date
{
    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday fromDate:date];
    return components.weekday-1;
}

/**
 *  按照指定的formatters分割一个日期；
 *  如：date是2016年8月23日，formatters是@[@"yyyy",@"MM",@"dd"]，则返回@[@"2016",@"08",@"23"];
 *
 *  @param date     需要分割的日期对象1
 *  @param formaters 分割的格式
 *
 *  @return 分割后的结果数组
 */
+ (NSArray *)dateSeparator:(NSDate *)date withSeparatorFormatterArray:(NSArray <NSString *>*)formaters
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [formaters count] ; i ++) {
        [temp addObject:[self date:date toStringByFormat:formaters[i]]];
    }
    return [NSArray arrayWithArray:temp];
}

@end

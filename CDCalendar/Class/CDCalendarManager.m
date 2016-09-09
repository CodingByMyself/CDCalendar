//
//  CDCalendarManager.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/9/9.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDCalendarManager.h"
#import "CDMonthModel.h"



static CDCalendarManager *_sharedSDK;
@implementation CDCalendarManager
@synthesize weekdaysDescriptions = _weekdaysDescriptions;
@synthesize calendarView = _calendarView;

#pragma mark - 生成单例
/**
 *  生成日历管理中心的单实例
 *
 *  @return 单例
 */
+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSDK = [[CDCalendarManager alloc] init]; //  初始化单例
    });
    return _sharedSDK;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self) {
        if (_sharedSDK == nil) {
            _sharedSDK = [super allocWithZone:zone];
        }
        return _sharedSDK;
    }
}



#pragma mark - Public Method
- (void)setMinDate:(NSDate *)minDate andMaxDate:(NSDate *)maxDate
{
    _minDate = minDate;
    _maxDate = maxDate;
    
    NSDate *startDay = [CDDateHelper firstDayOfMonth:_minDate];
    NSDate *endDay = [CDDateHelper lastDayOfMonth:_maxDate];
    NSMutableArray *tempData = [[NSMutableArray alloc] init];
    NSMutableArray *monthsArray = [[NSMutableArray alloc] init];
    BOOL flag = YES;
    NSInteger count = 0;
    NSDate *lastDate = startDay;
    [tempData addObject:startDay];
    while (flag) {
        count++;
        NSDate *date = [CDDateHelper addToDate:startDay days:count];
        if ([CDDateHelper date:date isEqualOrAfter:startDay andEqualOrBefore:endDay]) {
            if ([CDDateHelper date:date isTheSameMonthThan:lastDate] == NO) {
                CDMonthModel *monthModel = [[CDMonthModel alloc] init];
                monthModel.days = [NSArray arrayWithArray:tempData];
                monthModel.numberOfWeeks = [CDDateHelper numberOfWeeks:lastDate];
                monthModel.weekdayOfFirstDay = [CDDateHelper getWeekdayWithDate:[tempData firstObject]];
                monthModel.weekdayOfLastDay = [CDDateHelper getWeekdayWithDate:[tempData lastObject]];
                [monthsArray addObject:monthModel];
                [tempData removeAllObjects];
            }
            // 添加
            [tempData addObject:date];
        } else {
            flag = NO;
        }
        lastDate = date;
    }
    
    self.calendarView.monthDatas = [NSArray arrayWithArray:monthsArray];
}

#pragma mark - Getter Method
- (NSDate *)today
{
    if (_today == nil) {
        _today = [NSDate date];
    }
    return _today;
}

- (CDCalendarView *)calendarView
{
    if (_calendarView == nil) {
        _calendarView = [[CDCalendarView alloc] init];
    }
    return _calendarView;
}

- (NSArray *)weekdaysDescriptions
{
    if (_weekdaysDescriptions == nil) {
        _weekdaysDescriptions = @[@"周日", @"周一", @"周二", @"周三", @"周四",@"周五",@"周六"];
    }
    return _weekdaysDescriptions;
}

- (CDCalendarAppearance *)calendarAppearance
{
    if (_calendarAppearance == nil) {
        _calendarAppearance = [[CDCalendarAppearance alloc] init];
    }
    return _calendarAppearance;
}

@end

//
//  CDCalendarManager.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/9/9.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDCalendarView.h"
#import "CDCalendarAppearance.h"


@protocol CDCalendarManagerDelegate <NSObject>
/**
 * Asks the dataSource for a title for the specific date as a replacement of the day text
 */
- (NSString *)calendarView:(CDCalendarView *)calendar titleForDate:(NSDate *)date;

/**
 * Asks the dataSource for a subtitle for the specific date under the day text.
 */
- (NSString *)calendarView:(CDCalendarView *)calendar subtitleForDate:(NSDate *)date;

/**
 * Asks the dataSource the minimum date to display.
 */
- (NSDate *)minimumDateForCalendar:(CDCalendarView *)calendar;

/**
 * Asks the dataSource the maximum date to display.
 */
- (NSDate *)maximumDateForCalendar:(CDCalendarView *)calendar;

@end




@interface CDCalendarManager : NSObject

@property (nonatomic,weak) id<CDCalendarManagerDelegate> delegate;

@property (nonatomic,readonly) NSDate *minDate;  //  最小的日期
@property (nonatomic,readonly) NSDate *maxDate;  //  最小的日期
@property (nonatomic,strong) NSDate *today;  //  今天的日期

@property (nonatomic,readonly) NSArray *weekdaysDescriptions;  //  周信息的title文本显示

@property (nonatomic,readonly) CDCalendarView *calendarView;  //  日历视图
@property (nonatomic,strong) CDCalendarAppearance *calendarAppearance;  //  日历显示风格的封装类


#pragma mark - 生成单例
/**
 *  生成日历管理中心的单实例
 *
 *  @return 单例
 */
+ (instancetype)sharedManager;

- (void)setMinDate:(NSDate *)minDate andMaxDate:(NSDate *)maxDate;





@end

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
 * Asks the dataSource the minimum date to display.
 */
- (NSDate *)minimumDateForCalendarView:(CDCalendarView *)calendar;

/**
 * Asks the dataSource the maximum date to display.
 */
- (NSDate *)maximumDateForCalendarView:(CDCalendarView *)calendar;

@optional
/**
 * Asks the dataSource for a title for the specific date as a replacement of the day text
 */
- (NSString *)calendarView:(CDCalendarView *)calendar titleForDate:(NSDate *)date;

/**
 * Asks the dataSource for a subtitle for the specific date under the day text.
 */
- (NSString *)calendarView:(CDCalendarView *)calendar subtitleForDate:(NSDate *)date;

#pragma mark
/**
 * Asks the delegate whether the specific date is allowed to be selected by tapping.
 */
- (BOOL)calendarView:(CDCalendarView *)calendar shouldSelectDate:(NSDate *)date;

/**
 * Tells the delegate a date in the calendar is selected by tapping.
 */
- (void)calendarView:(CDCalendarView *)calendar didSelectDate:(NSDate *)date;

/**
 * Asks the delegate whether the specific date is allowed to be deselected by tapping.
 */
- (BOOL)calendarView:(CDCalendarView *)calendar shouldDeselectDate:(NSDate *)date;

/**
 * Tells the delegate a date in the calendar is deselected by tapping.
 */
- (void)calendarView:(CDCalendarView *)calendar didDeselectDate:(NSDate *)date;


// 视图代理方法
//- (void)calendarView:(CDCalendarView *)calendar loadedTitleLabel:(UILabel *)labelTitle subtitleLabel:(UILabel *)labelSubtitle OnTheDay:(NSDate *)date;

@end


#pragma mark 
#define CDDeselectDayColor   DefineColorRGB(200.0, 200.0, 200.0, 1.0)

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

//- (void)setMinDate:(NSDate *)minDate andMaxDate:(NSDate *)maxDate;
- (void)reloadCalendarView;




@end

//
//  CDMainViewController.m
//  CDCalendar
//
//  Created by Cindy on 16/9/9.
//  Copyright © 2016年 Mangocity. All rights reserved.
//

#import "CDMainViewController.h"
#import "CDCalendarManager.h"

@interface CDMainViewController () <CDCalendarManagerDelegate>

@end

@implementation CDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"日历测试";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self.view addSubview:[[CDCalendarManager sharedManager] calendarView]];
    [[[CDCalendarManager sharedManager] calendarView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100.0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    [[CDCalendarManager sharedManager] setDelegate:self];
    [[CDCalendarManager sharedManager] reloadCalendarView];
}

#pragma mark - Delegate Method
- (NSString *)calendarView:(CDCalendarView *)calendar titleForDate:(NSDate *)date
{
    if ([CDDateHelper date:date isTheSameDayThan:[NSDate date]]) {
        return @"今天";
    } else {
        return [CDDateHelper date:date toStringByFormat:@"dd"];
    }
    
}

/**
 * Asks the dataSource for a subtitle for the specific date under the day text.
 */
- (NSString *)calendarView:(CDCalendarView *)calendar subtitleForDate:(NSDate *)date
{
    return @"¥1025";
}

/**
 * Asks the dataSource the minimum date to display.
 */
- (NSDate *)minimumDateForCalendarView:(CDCalendarView *)calendar
{
    return [NSDate date];
}

/**
 * Asks the dataSource the maximum date to display.
 */
- (NSDate *)maximumDateForCalendarView:(CDCalendarView *)calendar
{
    return [CDDateHelper addToDate:[NSDate date] months:8];
}

@end

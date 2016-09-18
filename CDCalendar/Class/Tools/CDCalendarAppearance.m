//
//  CDCalendarAppearance.m
//  CDCalendar
//
//  Created by Cindy on 16/9/9.
//  Copyright © 2016年 Mangocity. All rights reserved.
//

#import "CDCalendarAppearance.h"

@implementation CDCalendarAppearance

- (NSString *)monthTitleFormatter
{
    if (_monthTitleFormatter == nil) {
        _monthTitleFormatter = @"yyyy 年 MM 月 ";
    }
    return _monthTitleFormatter;
}

- (UIColor *)monthTitleBackgroundColor
{
    if (_monthTitleBackgroundColor == nil) {
        _monthTitleBackgroundColor = [UIColor colorWithRed:240.0/256.0 green:240.0/256.0 blue:240.0/256.0 alpha:1.0];
    }
    return _monthTitleBackgroundColor;
}

- (UIColor *)monthTitleColor
{
    if (_monthTitleColor == nil) {
        _monthTitleColor = [UIColor darkTextColor];
    }
    return _monthTitleColor;
}

- (CGFloat)monthTitleFontSize
{
    if (_monthTitleFontSize == 0.0) {
        _monthTitleFontSize = 15.0;
    }
    return _monthTitleFontSize;
}

#pragma mark 
- (UIColor *)weekTitleColor
{
    if (_weekTitleColor == nil) {
        _weekTitleColor = [UIColor darkGrayColor];
    }
    return _weekTitleColor;
}

- (CGFloat)weekTitleFontSize
{
    if (_weekTitleFontSize == 0.0) {
        _weekTitleFontSize = 15.0;
    }
    return _weekTitleFontSize;
}

#pragma mark 
- (UIColor *)daySelectedViewbgColor
{
    if (_daySelectedViewbgColor == nil) {
        _daySelectedViewbgColor = [UIColor orangeColor];
    }
    return _daySelectedViewbgColor;
}

- (UIColor *)dayTitleColor
{
    if (_dayTitleColor == nil) {
        _dayTitleColor = [UIColor darkTextColor];
    }
    return _dayTitleColor;
}

- (UIColor *)dayTitleSelectedColor
{
    if (_dayTitleSelectedColor == nil) {
        _dayTitleSelectedColor = [UIColor whiteColor];
    }
    return _dayTitleSelectedColor;
}

- (CGFloat)dayTitleFontSize
{
    if (_dayTitleFontSize == 0.0) {
        _dayTitleFontSize = 16.0;
    }
    return _dayTitleFontSize;
}

- (UIColor *)daySubtitleColor
{
    if (_daySubtitleColor == nil) {
        _daySubtitleColor = [UIColor orangeColor];
    }
    return _daySubtitleColor;
}

- (UIColor *)daySubtitleSelectedColor
{
    if (_daySubtitleSelectedColor == nil) {
        _daySubtitleSelectedColor = [UIColor whiteColor];
    }
    return _daySubtitleSelectedColor;
}

- (CGFloat)daySubtitleFontSize
{
    if (_daySubtitleFontSize == 0.0) {
        _daySubtitleFontSize = 9.0;
    }
    return _daySubtitleFontSize;
}

#pragma mark 
- (CGFloat)radiusOfSelectedViewBgOffset
{
    if (_radiusOfSelectedViewBgOffset == 0.0) {
        if (ScreenWidth > 320) {
            _radiusOfSelectedViewBgOffset = 15.0;
        } else {
            _radiusOfSelectedViewBgOffset = 8.0;
        }
        
    }
    return _radiusOfSelectedViewBgOffset;
}

@end

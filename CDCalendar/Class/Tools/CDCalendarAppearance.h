//
//  CDCalendarAppearance.h
//  CDCalendar
//
//  Created by Cindy on 16/9/9.
//  Copyright © 2016年 Mangocity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDCalendarAppearance : NSObject

/**
 *  月份title的显示格式
 *  默认格式："yyyy年MM月"
 */
@property (nonatomic,retain) NSString *monthTitleFormatter;
@property (nonatomic,retain) UIColor *monthTitleBackgroundColor;
@property (nonatomic,retain) UIColor *monthTitleColor;
@property (nonatomic,assign) CGFloat monthTitleFontSize;

@property (nonatomic,retain) UIColor *weekTitleColor;
@property (nonatomic,assign) CGFloat weekTitleFontSize;

@property (nonatomic,retain) UIColor *daySelectedViewbgColor;  //  日期被选中时的背景色

@property (nonatomic,retain) UIColor *dayTitleColor;  //  日期的显示颜色
@property (nonatomic,retain) UIColor *dayTitleSelectedColor;  // 日期被选中时的颜色
@property (nonatomic,assign) CGFloat dayTitleFontSize;  //  日期的字体大小
@property (nonatomic,retain) UIColor *daySubtitleColor;  //  子title的显示颜色
@property (nonatomic,retain) UIColor *daySubtitleSelectedColor;  // 子title被选中时的颜色
@property (nonatomic,assign) CGFloat daySubtitleFontSize;  //  子title的字体大小

/**
 *  选中的背景圆半径的偏移量
 *   默认: 0
 */
@property (nonatomic,assign) CGFloat radiusOfSelectedViewBgOffset;

@end

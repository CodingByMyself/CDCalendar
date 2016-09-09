//
//  CDMonthModel.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/9/9.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CDMonthModel : NSObject

@property (nonatomic,strong) NSArray *days;  //  此月份总共有多少天
@property (nonatomic,assign) NSInteger numberOfWeeks;  //  此月份总共有多少周
@property (nonatomic,assign) CDCalendarWeekdays weekdayOfFirstDay;  //  此月份的第一天是周几
@property (nonatomic,assign) CDCalendarWeekdays weekdayOfLastDay;  //  此月份的最后一天是周几

@end

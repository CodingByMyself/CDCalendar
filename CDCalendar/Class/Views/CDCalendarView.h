//
//  CDCalendarView.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/9/9.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDCalendarView : UIView

@property (nonatomic,strong) NSArray *monthDatas;
@property (nonatomic,readonly) NSMutableArray *selectedDates;

- (void)reloadCalendarView;
- (void)selectDate:(NSDate *)date;
- (void)deselectDate:(NSDate *)date;
@end

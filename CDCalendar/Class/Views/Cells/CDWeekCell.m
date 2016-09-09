//
//  CDWeekCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/9/9.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDWeekCell.h"
#import "CDCalendarManager.h"


@implementation CDWeekCell
@synthesize labelWeekday = _labelWeekday;

#pragma mark - Getter Method
- (UILabel *)labelWeekday
{
    if (_labelWeekday == nil) {
        _labelWeekday = [[UILabel alloc] init];
        _labelWeekday.textColor = [[[CDCalendarManager sharedManager] calendarAppearance] weekTitleColor];
        _labelWeekday.font = [UIFont systemFontOfSize:[[[CDCalendarManager sharedManager] calendarAppearance] weekTitleFontSize]];
        _labelWeekday.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_labelWeekday];
        [_labelWeekday mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return _labelWeekday;
}

@end

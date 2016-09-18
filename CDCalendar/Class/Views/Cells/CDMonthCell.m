//
//  CDMonthCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/9/9.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDMonthCell.h"
#import "CDCalendarManager.h"

@interface CDMonthCell ()

@end

@implementation CDMonthCell
@synthesize labelMonth = _labelMonth;

#pragma mark - Getter Method
- (UILabel *)labelMonth
{
    if (_labelMonth == nil) {
        
        self.backgroundColor = [[[CDCalendarManager sharedManager] calendarAppearance] monthTitleBackgroundColor];
        self.layer.borderColor = [UIColor colorWithRed:230.0/256.0 green:230.0/256.0 blue:230.0/256.0 alpha:1.0].CGColor;
        self.layer.borderWidth = 0.3;
        
        _labelMonth = [[UILabel alloc] init];
        _labelMonth.textColor = [[[CDCalendarManager sharedManager] calendarAppearance] monthTitleColor];
        _labelMonth.font = [UIFont systemFontOfSize:[[[CDCalendarManager sharedManager] calendarAppearance] monthTitleFontSize]];
        _labelMonth.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_labelMonth];
        [_labelMonth mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return _labelMonth;
}
@end

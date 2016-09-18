//
//  CDDayCell.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/9/9.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDDayCell.h"
#import "CDCalendarManager.h"

@interface CDDayCell ()

@end


@implementation CDDayCell
@synthesize labelDay = _labelDay;
@synthesize labelSubtitle = _labelSubtitle;
@synthesize viewBg = _viewBg;

- (void)layoutSubviews
{
    CGFloat radius = (self.bounds.size.width - [[[CDCalendarManager sharedManager] calendarAppearance] radiusOfSelectedViewBgOffset])/2.0;
    _viewBg.layer.cornerRadius = radius;
    [_viewBg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(radius*2.0));
        make.height.equalTo(@(radius*2.0));
    }];
    
}

- (void)adjustTitlePostion
{
    if (self.labelSubtitle.text.length > 0) {
        CGFloat height = [self.labelSubtitle textRectForBounds:CGRectMake(0, 0, 100.0, 100.0) limitedToNumberOfLines:1].size.height;
        [_labelDay mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.viewBg).offset(-height/2.0);
        }];
    } else {
        [_labelDay mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.viewBg).offset(0.0);
        }];
    }
}

#pragma mark - Public Method
- (void)displayColorWithDate:(NSDate *)date
{
    NSLog(@"displayColorWithDate : %@",date);
    
    
}

- (void)setContentAtDate:(NSDate *)date andSelectedStatus:(BOOL)isSelected
{
    NSString *title = @"";
    NSString *subtitle = @"";
    if (date) {
        self.labelDay.hidden = NO;
        //  询问代理是否定义了 title 的内容
        if ([[[CDCalendarManager sharedManager] delegate] respondsToSelector:@selector(calendarView:titleForDate:)]) {
            title = [[[CDCalendarManager sharedManager] delegate] calendarView:[[CDCalendarManager sharedManager] calendarView] titleForDate:date];
        } else {
            title = [CDDateHelper date:date toStringByFormat:@"dd"];
        }
        //  询问代理是否定义了 subtitle 的内容
        if ([[[CDCalendarManager sharedManager] delegate] respondsToSelector:@selector(calendarView:subtitleForDate:)]) {
            subtitle = [[[CDCalendarManager sharedManager] delegate] calendarView:[[CDCalendarManager sharedManager] calendarView] subtitleForDate:date];
        }
    } else {
        self.labelDay.hidden = YES;
    }
    
    // 设置内容
    self.labelDay.text = title;
    self.labelSubtitle.text = subtitle;
    
    NSLog(@"date = %@",date);
    //  区间限制和属性设置
    if (date == nil) {
        [self setSeletedCell:NO animation:NO]; //  设置选中状态
        return;
    } else if ([CDDateHelper date:date isEqualOrAfter:[[CDCalendarManager sharedManager] minDate] andEqualOrBefore:[[CDCalendarManager sharedManager] maxDate]]) {
        [self setSeletedCell:isSelected animation:NO]; //  设置选中状态
        self.tag = 0;
    } else {
        [self setSeletedCell:NO animation:NO]; //  设置选中状态
        self.labelDay.textColor = CDDeselectDayColor;
        self.labelSubtitle.text = @"";
        self.tag = 100;
    }
    
    // 调整位置
    [self adjustTitlePostion];
}

- (void)setSeletedCell:(BOOL)selected animation:(BOOL)animation
{
    if (animation) {
        CGFloat dur = 0.2;
        if (selected == YES) {
            self.viewBg.backgroundColor = [[[CDCalendarManager sharedManager] calendarAppearance] daySelectedViewbgColor];
            self.labelDay.textColor = [[[CDCalendarManager sharedManager] calendarAppearance] dayTitleSelectedColor];
            self.labelDay.font = [UIFont fontWithName:@"HelveticaNeue" size:[[[CDCalendarManager sharedManager] calendarAppearance] dayTitleFontSize] - 4.0];
            self.labelSubtitle.textColor = [[[CDCalendarManager sharedManager] calendarAppearance] daySubtitleSelectedColor];
            
            [UIView animateWithDuration:dur animations: ^{
                CGAffineTransform scaleUpAnimationOut = CGAffineTransformMakeScale(0.5, 0.5);
                self.viewBg.transform = scaleUpAnimationOut;
            } completion: ^(BOOL finished) {
                [UIView animateWithDuration:dur animations: ^{
                    CGAffineTransform scaleUpAnimationOut = CGAffineTransformMakeScale(0.2, 1.1);
                    self.viewBg.transform = scaleUpAnimationOut;
                } completion: ^(BOOL finished) {
                    self.viewBg.transform = CGAffineTransformIdentity;
                }];
            }];
            
        } else {
            [UIView animateWithDuration:dur animations: ^{
                CGAffineTransform scaleUpAnimationOut = CGAffineTransformMakeScale(0.1, 0.1);
                self.viewBg.transform = scaleUpAnimationOut;
                
            } completion: ^(BOOL finished) {
                self.viewBg.backgroundColor = [UIColor clearColor];
                self.labelDay.textColor = [[[CDCalendarManager sharedManager] calendarAppearance] dayTitleColor];
                self.labelDay.font = [UIFont fontWithName:@"HelveticaNeue" size:[[[CDCalendarManager sharedManager] calendarAppearance] dayTitleFontSize]];
                self.labelSubtitle.textColor = [[[CDCalendarManager sharedManager] calendarAppearance] daySubtitleColor];
                self.viewBg.transform = CGAffineTransformIdentity;
            }];
        }
        
    } else {
        //  是否是选中的日期
        if (selected) {
            self.viewBg.backgroundColor = [[[CDCalendarManager sharedManager] calendarAppearance] daySelectedViewbgColor];
            self.labelDay.textColor = [[[CDCalendarManager sharedManager] calendarAppearance] dayTitleSelectedColor];
            self.labelDay.font = [UIFont fontWithName:@"HelveticaNeue" size:[[[CDCalendarManager sharedManager] calendarAppearance] dayTitleFontSize] - 4.0];
            self.labelSubtitle.textColor = [[[CDCalendarManager sharedManager] calendarAppearance] daySubtitleSelectedColor];
        } else {
            self.viewBg.backgroundColor = [UIColor clearColor];
            self.labelDay.textColor = [[[CDCalendarManager sharedManager] calendarAppearance] dayTitleColor];
            self.labelDay.font = [UIFont fontWithName:@"HelveticaNeue" size:[[[CDCalendarManager sharedManager] calendarAppearance] dayTitleFontSize]];
            self.labelSubtitle.textColor = [[[CDCalendarManager sharedManager] calendarAppearance] daySubtitleColor];
        }

    }
    
}



#pragma mark - Getter Method
- (UILabel *)labelDay
{
    if (_labelDay == nil) {
        _labelDay = [[UILabel alloc] init];
        _labelDay.textColor = [[[CDCalendarManager sharedManager] calendarAppearance] dayTitleColor];
        _labelDay.font = [UIFont fontWithName:@"HelveticaNeue" size:[[[CDCalendarManager sharedManager] calendarAppearance] dayTitleFontSize]];
        _labelDay.textAlignment = NSTextAlignmentCenter;
        [self.viewBg addSubview:_labelDay];
        [_labelDay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.viewBg);
            make.centerY.equalTo(self.viewBg);
        }];
    }
    return _labelDay;
}

- (UILabel *)labelSubtitle
{
    if (_labelSubtitle == nil) {
        _labelSubtitle = [[UILabel alloc] init];
        _labelSubtitle.textColor = [[[CDCalendarManager sharedManager] calendarAppearance] daySubtitleColor];
        _labelSubtitle.font = [UIFont fontWithName:@"HelveticaNeue" size:[[[CDCalendarManager sharedManager] calendarAppearance] daySubtitleFontSize]];
        _labelSubtitle.textAlignment = NSTextAlignmentCenter;
        [self.viewBg addSubview:_labelSubtitle];
        [_labelSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labelDay.mas_bottom);
            make.centerX.equalTo(self.labelDay);
        }];
    }
    return _labelSubtitle;
}

- (UIView *)viewBg
{
    if (_viewBg == nil) {
        _viewBg = [[UIView alloc] init];
        _viewBg.backgroundColor = [UIColor whiteColor];
        _viewBg.clipsToBounds = YES;
        CGFloat radius = (self.bounds.size.width - [[[CDCalendarManager sharedManager] calendarAppearance] radiusOfSelectedViewBgOffset])/2.0;
        _viewBg.layer.cornerRadius = radius;
        [self addSubview:_viewBg];
        [_viewBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@(radius*2.0));
            make.height.equalTo(@(radius*2.0));
        }];
    }
    return _viewBg;
}

@end

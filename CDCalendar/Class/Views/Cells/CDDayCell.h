//
//  CDDayCell.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/9/9.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDMonthModel.h"

@interface CDDayCell : UICollectionViewCell

@property (nonatomic,readonly) UILabel *labelDay;
@property (nonatomic,readonly) UILabel *labelSubtitle;
@property (nonatomic,readonly) UIView *viewBg;


- (void)setContentAtDate:(NSDate *)date andSelectedStatus:(BOOL)isSelected;
- (void)setSeletedCell:(BOOL)selected animation:(BOOL)animation;

@end

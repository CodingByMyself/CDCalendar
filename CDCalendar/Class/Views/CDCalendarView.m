//
//  CDCalendarView.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/9/9.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDCalendarView.h"
#import "CDMonthModel.h"
#import "CDMonthCell.h"
#import "CDWeekCell.h"
#import "CDDayCell.h"
#import "CDDateHelper.h"
#import "CDCalendarManager.h"

@interface CDCalendarView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionViewCalendar;

@end

@implementation CDCalendarView
@synthesize selectedDates = _selectedDates;


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    
}

#pragma mark - Public Method
- (void)reloadCalendarView
{
    [self.collectionViewCalendar reloadData];
}

- (void)selectDate:(NSDate *)date
{
    if ([date isKindOfClass:[NSDate class]]) {
        if ([self isSelected:date] == NO) {
            [self.selectedDates addObject:date];
        }
//        [self.collectionViewCalendar reloadData];
    }
}

- (void)deselectDate:(NSDate *)date
{
    if ([date isKindOfClass:[NSDate class]]) {
        [self removeSelectedDate:date];
//        [self.collectionViewCalendar reloadData];
    }
}

#pragma mark - Private Method
- (NSDate *)getDayDateAtIndexPath:(NSIndexPath *)indexPath
{
    CDMonthModel *month = [self.monthDatas objectAtIndex:indexPath.section];
    NSInteger currentDayNumber = indexPath.row - CDCalendarDayOffset;
    NSInteger index = currentDayNumber - month.weekdayOfFirstDay;
    if (currentDayNumber < month.weekdayOfFirstDay || index >= month.days.count) {
        return nil;
    } else {
        return month.days[index];
    }
}

- (void)setDayCell:(CDDayCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSDate *day = [self getDayDateAtIndexPath:indexPath];
    NSString *title = @"";
    NSString *subtitle = @"";
    if (day) {
         cell.labelDay.hidden = NO;
        //  询问代理是否定义了 title 的内容
        if ([[[CDCalendarManager sharedManager] delegate] respondsToSelector:@selector(calendarView:titleForDate:)]) {
            title = [[[CDCalendarManager sharedManager] delegate] calendarView:self titleForDate:day];
        } else {
            title = [CDDateHelper date:day toStringByFormat:@"dd"];
        }
        //  询问代理是否定义了 subtitle 的内容
        if ([[[CDCalendarManager sharedManager] delegate] respondsToSelector:@selector(calendarView:subtitleForDate:)]) {
            subtitle = [[[CDCalendarManager sharedManager] delegate] calendarView:self subtitleForDate:day];
        }
        
    } else {
        cell.labelDay.hidden = YES;
    }
    
    // 设置内容
    [cell setTitle:title andSubtitle:subtitle];
    //  设置选中状态
    [cell setSeletedCell:[self isSelected:day] animation:NO];
}

- (BOOL)isSelected:(NSDate *)date
{
    if ([date isKindOfClass:[NSDate class]]) {
        for (NSDate *selected in self.selectedDates) {
            if ([CDDateHelper date:date isTheSameDayThan:selected]) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)removeSelectedDate:(NSDate *)date
{
    for (NSDate *selected in self.selectedDates) {
        if ([CDDateHelper date:date isTheSameDayThan:selected]) {
            [_selectedDates removeObject:selected];
            break;
        }
    }
}

#pragma mark - UI Collection View  Data  And  Delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        /*************  月份  ***************/
        [self.collectionViewCalendar registerClass:[CDMonthCell class] forCellWithReuseIdentifier:@"CDMonthCellID"];
        CDMonthCell * cell = (CDMonthCell *)[self.collectionViewCalendar dequeueReusableCellWithReuseIdentifier:@"CDMonthCellID" forIndexPath:indexPath];
        cell.backgroundColor = [[[CDCalendarManager sharedManager] calendarAppearance] monthTitleBackgroundColor];
        
        CDMonthModel *month = [self.monthDatas objectAtIndex:indexPath.section];
        cell.labelMonth.text = [CDDateHelper date:month.days[0] toStringByFormat:[[[CDCalendarManager sharedManager] calendarAppearance] monthTitleFormatter]];
        return cell;
        
    } else if ([indexPath row] == 1 || [indexPath row] == 2 || [indexPath row] == 3 || [indexPath row] == 4 || [indexPath row] == 5 || [indexPath row] == 6 || [indexPath row] == 7) {
        /*************  周  ***************/
        [self.collectionViewCalendar registerClass:[CDWeekCell class] forCellWithReuseIdentifier:@"CDWeekCellID"];
        CDWeekCell * cell = (CDWeekCell *)[self.collectionViewCalendar dequeueReusableCellWithReuseIdentifier:@"CDWeekCellID" forIndexPath:indexPath];
        cell.labelWeekday.text = [[[CDCalendarManager sharedManager] weekdaysDescriptions] objectAtIndex:indexPath.row - 1];
        return cell;
        
    } else {
        /*************  日期  ***************/
        [self.collectionViewCalendar registerClass:[CDDayCell class] forCellWithReuseIdentifier:@"CDDayCellID"];
        CDDayCell * cell = (CDDayCell *)[self.collectionViewCalendar dequeueReusableCellWithReuseIdentifier:@"CDDayCellID" forIndexPath:indexPath];
        [self setDayCell:cell atIndexPath:indexPath];
        return cell;
        
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section = %zi , item = %zi   clicked !",[indexPath section],[indexPath row]);
    NSDate *date = [self getDayDateAtIndexPath:indexPath];
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if ([cell isKindOfClass:[CDDayCell class]] && date) {
        CDDayCell *dayCell = (CDDayCell *)cell;
        [dayCell setSeletedCell:(![self isSelected:date]) animation:YES];
        if ([self isSelected:date]) {
            [self deselectDate:date];
        } else {
            [self selectDate:date];
        }
        
    }
    
}

#pragma mark  Item Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    CGFloat w = collectionView.bounds.size.width/7.0 - 1.0;
    if ([indexPath row] == 0) {  // 月
        size = CGSizeMake(collectionView.bounds.size.width, CDCalendarMonthHeight);
    } else if ([indexPath row] == 1 || [indexPath row] == 2 || [indexPath row] == 3 || [indexPath row] == 4 || [indexPath row] == 5 || [indexPath row] == 6 || [indexPath row] == 7) {  //  周
        size = CGSizeMake(w, CDCalendarWeekHeight);
    } else {  //  日
        size = CGSizeMake(w, w);
    }
    
    return size;
}

#pragma mark  Item Number  And  Section Number
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CDMonthModel *month = [self.monthDatas objectAtIndex:section];
    NSInteger  number = 1 + 7 + month.weekdayOfFirstDay + month.days.count + (7 - month.weekdayOfLastDay -1);
    return number;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.monthDatas count];
}

#pragma mark  Item  Spacing
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.8;
}

#pragma mark - Getter Method
- (NSMutableArray *)selectedDates
{
    if (_selectedDates == nil) {
        _selectedDates = [[NSMutableArray alloc] init];
    }
    return _selectedDates;
}
- (UICollectionView *)collectionViewCalendar
{
    if (_collectionViewCalendar == nil) {
        //  初始化装载控件
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionViewCalendar.collectionViewLayout = flowLayout;
        _collectionViewCalendar = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionViewCalendar.backgroundColor = [UIColor whiteColor];
        _collectionViewCalendar.delegate = self;
        _collectionViewCalendar.dataSource = self;
        [self addSubview:_collectionViewCalendar];
        [_collectionViewCalendar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return _collectionViewCalendar;
}

@end

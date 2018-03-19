//
//  FYXCalendar.h
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/24.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"

@class FYXCalendar;
@protocol FYXCalendarDelegate <NSObject>;

@optional
/**
*时间选择
*/
- (void)calendar: (FYXCalendar *)calendar selectTime: (NSString *)selectTime;
/**
*按钮显示
*/
- (void)calendar: (FYXCalendar *)calendar collectionView: (UICollectionView *)collectionView willDisplayCell: (UICollectionViewCell *)cell cellForItemAtIndexPath: (NSIndexPath *)indexPath;
@end

@interface FYXCalendar : UIView <FSCalendarDelegate, FSCalendarDataSource, UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray *timeData;
}

@property (nonatomic, strong) NSCalendar *gregorianCalendar;
@property (nonatomic, strong) NSMutableArray *afternoonData;        /**< 下午数据 */
@property (nonatomic, strong) NSMutableArray *morningData;          /**< 上午数据 */
@property (nonatomic, strong) UIColor  *timeDetailSelectColor;      /**< 具体时间选中颜色 */
@property (nonatomic, strong) UIColor  *timeDetailColor;            /**< 具体时间颜色 */
@property (nonatomic, weak) id <FYXCalendarDelegate>delegate;
@property (nonatomic, weak) FSCalendar *calendar;                   /**< 日历 */
@property (nonatomic, weak) UICollectionView *collectView;          /**< 具体时间 */
@property (nonatomic, weak) UIButton *previousButton;               /**< 上月按钮 */
@property (nonatomic, weak) UIButton *nextButton;                   /**< 下月按钮 */
@property (nonatomic, weak) UIButton *previousWeekBtn;              /**< 上周按钮 */
@property (nonatomic, weak) UIButton *nextWeekBtn;                  /**< 下周按钮 */
@property (nonatomic, weak) UIButton *afternoonBtn;                 /**< 上午选择按钮 */
@property (nonatomic, weak) UIButton *morningBtn;                   /**< 下午选择按钮 */
@property (nonatomic, weak) UILabel  *timeTitleLB;                  /**< 时间标题 */

/**
*加载具体日期
*/
- (void)setCalendarData;
@end


@interface CollectionCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *timeBtn;
@end

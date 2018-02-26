//
//  FYXCalendar.h
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/24.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"

@interface FYXCalendar : UIView <FSCalendarDelegate, FSCalendarDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) FSCalendar *calendar;
@property (nonatomic, strong) NSCalendar *gregorianCalendar;
@property (nonatomic, weak) UICollectionView *collectView;
@property (nonatomic, weak) UIButton *previousButton;
@property (nonatomic, weak) UIButton *nextButton;
@property (nonatomic, weak) UIButton *previousWeekBtn;
@property (nonatomic, weak) UIButton *nextWeekBtn;
@property (nonatomic, weak) UIButton *afternoonBtn;
@property (nonatomic, weak) UIButton *morningBtn;
@property (nonatomic, weak) UILabel  *timeTitleLB;

@end


@interface CollectionCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *timeBtn;
@end

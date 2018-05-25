//
//  FYXCalendar.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/24.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "FYXCalendar.h"
#import "FYXCalendarDataModel.h"
#import "FYXButton.h"

#define normalColor [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f]
#define weekColor [UIColor colorWithRed:1 green:197.0 / 255 blue:20.0 / 255 alpha:1.0f]
#define todayTitleColor [UIColor colorWithRed:150.0 / 255 green:150.0 / 255 blue:150.0 / 255 alpha:1.0f]


#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define VIEW_CENTER(aView)       ((aView).center)
#define VIEW_CENTER_X(aView)     ((aView).center.x)
#define VIEW_CENTER_Y(aView)     ((aView).center.y)

#define VIEW_FRAME(aView)        ((aView).frame)

#define VIEW_ORIGIN(aView)       ((aView).frame.origin)
#define VIEW_X(aView)            ((aView).frame.origin.x)
#define VIEW_Y(aView)            ((aView).frame.origin.y)

#define VIEW_SIZE(aView)         ((aView).frame.size)
#define VIEW_HEIGHT(aView)       ((aView).frame.size.height)
#define VIEW_WIDTH(aView)        ((aView).frame.size.width)

#define VIEW_X_Right(aView)      ((aView).frame.origin.x + (aView).frame.size.width)
#define VIEW_Y_Bottom(aView)     ((aView).frame.origin.y + (aView).frame.size.height)


#define displayScale  (nativScale() / 2)

CGFloat nativScale(void) {
    static CGFloat scale = 0.0f;
    if (scale == 0.0f) {
        CGFloat width = SCREEN_WIDTH;
        scale = width / 375.0f;
    }
    return scale * 2;
}

@implementation FYXCalendar {
    NSIndexPath *selectTimeIndex;
    NSString    *selectDay;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        timeData  = [NSMutableArray array];
        selectDay = @"";

        self.timeDetailColor = [UIColor lightGrayColor];
        self.timeDetailSelectColor = normalColor;

        FSCalendar *_calendar = [[FSCalendar alloc]initWithFrame:CGRectMake(36, 0, self.frame.size.width - 72, 180)];
        _calendar.dataSource = self;
        _calendar.delegate   = self;
        _calendar.scope      = FSCalendarScopeWeek;
        _calendar.backgroundColor = [UIColor whiteColor];
        _calendar.appearance.headerMinimumDissolvedAlpha = 0;
        _calendar.appearance.todayColor = [UIColor whiteColor];         // 今天选中的颜色
        _calendar.appearance.selectionColor = [UIColor whiteColor];     // 选中的颜色
        _calendar.appearance.titleTodayColor =  todayTitleColor;        // 今天的字体颜色
        _calendar.appearance.satAndSunColor = weekColor;                // 周六周日的颜色
        _calendar.appearance.titleSelectionColor = [UIColor whiteColor];// 选中后字体颜色
        _calendar.appearance.weekdayTextColor = [UIColor blackColor];   // 周末字体颜色
        _calendar.appearance.titleWeekendColor = weekColor;             // 具体周末日期颜色
        _calendar.appearance.borderRadius = 1;                          // 选中的边角弧度
        _calendar.appearance.borderSelectionColor = normalColor;        // 选中的边角颜色
        _calendar.appearance.selectionColor = [UIColor getMainGradientColor:CGRectMake(0, 0, 40, 40)];              // 选中的颜色
        _calendar.appearance.headerTitleColor = [UIColor blackColor];   // 年份时间
        _calendar.appearance.headerDateFormat = @"yyyy年MM月";           // 设置年份格式
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;            // 改变星期显示
        _calendar.appearance.titleFont = [UIFont systemFontOfSize:14 * displayScale];
        _calendar.appearance.subtitleWeekendColor = weekColor;
        _calendar.appearance.titleDefaultColor = [UIColor colorWithRed:50 / 255.0 green:50 / 255.0 blue:50 / 255.0 alpha:1];
        _calendar.appearance.subtitleDefaultColor = [UIColor colorWithRed:50 / 255.0 green:50 / 255.0 blue:50 / 255.0 alpha:1];
//        _calendar.appearance.headerTitleFont
        [_calendar setFirstWeekday:2];
        [self addSubview:_calendar];
        self.calendar = _calendar;
        _gregorianCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];

        __weak typeof(self) weakSelf = self;
        EKEventStore *store = [[EKEventStore alloc] init];
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            if(granted) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"yyyy-MM-dd";
                NSDate *startDate = [dateFormatter dateFromString:@"2016-02-03"]; // 开始日期
                NSDate *endDate = [dateFormatter dateFromString:@"2118-04-10"]; // 截止日期
                NSPredicate *fetchCalendarEvents = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
                NSArray<EKEvent *> *eventList = [store eventsMatchingPredicate:fetchCalendarEvents];
                NSArray<EKEvent *> *events = [eventList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable event, NSDictionary<NSString *,id> * _Nullable bindings) {
                    return event.calendar.subscribed;
                }]];
                weakSelf.events = events;
            }
        }];


        UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        previousButton.frame = CGRectMake(0, 0, 95, 34);
        previousButton.backgroundColor = [UIColor whiteColor];
        previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [previousButton setImage:[UIImage imageNamed:@"prev.png"] forState:UIControlStateNormal];
        [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:previousButton];
        self.previousButton = previousButton;

        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        nextButton.frame = CGRectMake(CGRectGetWidth(self.frame)-95, 0, 95, 34);
        nextButton.backgroundColor = [UIColor whiteColor];
        nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [nextButton setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextButton];
        self.nextButton = nextButton;

        UIButton *previousWeekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        previousWeekBtn.frame = CGRectMake(0, 45, 36, 60);
        [previousWeekBtn setTitle:@"上\n一\n周 " forState:UIControlStateNormal];
        [previousWeekBtn setTitleColor:[UIColor colorWithRed:101 / 255.0 green:101 / 255.0 blue:101 / 255.0 alpha:1] forState:UIControlStateNormal];
        previousWeekBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        previousWeekBtn.titleLabel.numberOfLines = 0;
        previousWeekBtn.backgroundColor = [UIColor whiteColor];
        previousWeekBtn.layer.shadowOffset = CGSizeMake(4, 1);
        previousWeekBtn.layer.shadowOpacity = 0.4;
        previousWeekBtn.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        previousWeekBtn.layer.cornerRadius = 5;
        [previousWeekBtn addTarget:self action:@selector(previousWeekClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:previousWeekBtn];
        self.previousWeekBtn = previousWeekBtn;

        UIButton *nextWeekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nextWeekBtn.frame = CGRectMake(_calendar.frame.size.width + 36, 45, 36, 60);
        [nextWeekBtn setTitle:@"下\n一\n周 " forState:UIControlStateNormal];
        [nextWeekBtn setTitleColor:[UIColor colorWithRed:101 / 255.0 green:101 / 255.0 blue:101 / 255.0 alpha:1] forState:UIControlStateNormal];
        nextWeekBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        nextWeekBtn.titleLabel.numberOfLines = 0;
        nextWeekBtn.backgroundColor = [UIColor whiteColor];
        nextWeekBtn.layer.shadowOffset = CGSizeMake(-4, 1);
        nextWeekBtn.layer.shadowOpacity = 0.4;
        nextWeekBtn.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        nextWeekBtn.layer.cornerRadius = 5;
        [nextWeekBtn addTarget:self action:@selector(nextWeekClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextWeekBtn];
        self.nextWeekBtn = nextWeekBtn;

        UIView *lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(VIEW_X(_calendar), VIEW_Y_Bottom(_calendar), VIEW_WIDTH(_calendar), 1);
        lineView.backgroundColor = normalColor;
        [self addSubview:lineView];

        UIButton *morningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        morningBtn.frame = CGRectMake(VIEW_CENTER_X(_calendar) - 68, VIEW_Y_Bottom(_calendar) - 15, 68 , 30);
        [morningBtn setTitle:@"上午" forState:UIControlStateNormal];
        [morningBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        morningBtn.backgroundColor = self.timeBtnSelectColor == nil ? normalColor : self.timeBtnSelectColor;
        morningBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        morningBtn.layer.cornerRadius = 5;
        [morningBtn addTarget:self action:@selector(morningClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:morningBtn];
        self.morningBtn = morningBtn;

        UIButton *afternoonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        afternoonBtn.frame= CGRectMake(VIEW_CENTER_X(_calendar) - 8, VIEW_Y_Bottom(_calendar) - 15, 73 , 30);
        [afternoonBtn setTitle:@"下午" forState:UIControlStateNormal];
        [afternoonBtn setTitleColor:normalColor forState:UIControlStateNormal];
        afternoonBtn.backgroundColor = [UIColor whiteColor];
        afternoonBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        afternoonBtn.layer.cornerRadius = 5;
        afternoonBtn.layer.borderColor = self.timeBtnSelectColor == nil ? normalColor.CGColor : self.timeBtnSelectColor.CGColor;
        afternoonBtn.layer.borderWidth = 1;
        [afternoonBtn addTarget:self action:@selector(afternoonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:afternoonBtn];
        self.afternoonBtn = afternoonBtn;

        UILabel *timeTitleLb = [[UILabel alloc]init];
        timeTitleLb.frame = CGRectMake(0, VIEW_Y_Bottom(_calendar) - 50, VIEW_WIDTH(self), 23 );
        timeTitleLb.textAlignment = NSTextAlignmentCenter;
        timeTitleLb.font = [UIFont systemFontOfSize:16];
        timeTitleLb.textColor = [UIColor blackColor];
        timeTitleLb.text = @"可选预约时间";
        [self addSubview:timeTitleLb];
        self.timeTitleLB = timeTitleLb;

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        double collectionHeigt;
        
        if (VIEW_HEIGHT(self) - VIEW_HEIGHT(_calendar) -30 * displayScale >= 224 * displayScale) {
            collectionHeigt = 224 * displayScale;
        }else {
            collectionHeigt = VIEW_HEIGHT(self) - VIEW_HEIGHT(_calendar) -30 * displayScale;
        }
        UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(VIEW_X(_calendar), VIEW_Y_Bottom(morningBtn) + 18, VIEW_WIDTH(_calendar), collectionHeigt)collectionViewLayout:flowLayout];

        collectView.dataSource = self;
        collectView.delegate = self;
        collectView.backgroundColor = [UIColor whiteColor];
        [collectView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:collectView];
        self.collectView = collectView;


    }
    return self;
}

#pragma -mark FSCalendarDelegate
- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date {
//    EKEvent *event = [self eventsForDate:date].firstObject;
//    if (event) {
//        if ([event.title isEqualToString:@"清明节"]) {
//            return @"清明";
//        }
//        return event.title; // 春分、秋分、儿童节、植树节、国庆节、圣诞节...
//    }
    if ([self.gregorianCalendar isDateInToday:date]) {
        return @"今天";
    }
    return nil;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    selectDay = [dateFormatter stringFromDate:date];
//    if ([self eventsForDate:date].firstObject) {
//        selectDay = [self eventsForDate:date].firstObject.title;
//
//    }
    self.calendar.prevOrNextClick = 0;
    [calendar.calendarHeaderView configureAppearance];
    [self.collectView reloadData];
}


- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
    return _minimumDate;
}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date {
    EKEvent *event = [self eventsForDate:date].firstObject;

    if (event) {
//        _calendar.appearance.titleFont = [UIFont systemFontOfSize:12 * displayScale];
        if ([event.title isEqualToString:@"清明节"]) {
            return @"清明";
        }
        return event.title; // 春分、秋分、儿童节、植树节、国庆节、圣诞节...

    }
//    _calendar.appearance.titleFont = [UIFont systemFontOfSize:14 * displayScale];
    return nil;
}
// 某个日期的所有事件
- (NSArray<EKEvent *> *)eventsForDate:(NSDate *)date
{


    NSArray<EKEvent *> *filteredEvents = [self.events filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.occurrenceDate isEqualToDate:date];
    }]];

    return filteredEvents;


}

#pragma -mark 日期调整点击事件
- (void)previousClicked:(id)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorianCalendar dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    self.calendar.prevOrNextClick = 1;
    [_calendar setCurrentPage:previousMonth animated:YES];
}

- (void)nextClicked:(id)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorianCalendar dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    NSLog(@"%@",currentMonth);
    self.calendar.prevOrNextClick = 1;
    [_calendar setCurrentPage:nextMonth animated:YES];
}

- (void)previousWeekClick: (id)sender {
    NSDate *currentWeek = self.calendar.currentPage;
    NSDate *previousWeek = [self.gregorianCalendar dateByAddingUnit:NSCalendarUnitWeekOfYear value:-1 toDate:currentWeek options:0];
    self.calendar.prevOrNextClick = 1;
    [_calendar setCurrentPage:previousWeek animated:YES];
}

- (void)nextWeekClick: (id)sender {
    NSDate *currentWeek = self.calendar.currentPage;
    NSDate *nextWeek = [self.gregorianCalendar dateByAddingUnit:NSCalendarUnitWeekOfYear value:1 toDate:currentWeek options:0];
    self.calendar.prevOrNextClick = 1;
    [_calendar setCurrentPage:nextWeek animated:YES];
}

#pragma -mark CollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [timeData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.timeBtn.tag = indexPath.row;
    cell.timeBtn.layer.borderColor = self.timeDetailColor.CGColor;
    [cell.timeBtn setTitleColor:self.timeDetailColor forState:UIControlStateNormal];
    FYXCalendarDataModel *model = timeData[indexPath.row];
    [cell.timeBtn setTitle:model.timeStr forState:UIControlStateNormal];
    cell.timeBtn.enabled = model.timeStatus;
    if ([self.delegate respondsToSelector:@selector(calendar:collectionView:willDisplayCell:cellForItemAtIndexPath:)]) {
        [self.delegate calendar:self collectionView:collectionView willDisplayCell:cell cellForItemAtIndexPath:indexPath];
    }
    if (model.timeStatus == 1) {
        cell.timeBtn.layer.borderColor = [UIColor colorWithRed:152.0 / 255
                                                         green:152.0 / 255
                                                          blue:152.0 / 255
                                                         alpha:0.4].CGColor;
        [cell.timeBtn setTitleColor:[UIColor colorWithRed:152.0 / 255
                                                    green:152.0 / 255
                                                     blue:152.0 / 255
                                                    alpha:0.4] forState:UIControlStateNormal];


    }
    [cell.timeBtn setBackgroundImage:[UIImage imageNamed:model.timeUnenabledPic] forState:UIControlStateNormal];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (VIEW_HEIGHT(self.collectView) < 128) {
        return CGSizeMake((VIEW_WIDTH(_calendar) - 12 * 3) / 4, 0);
    }if (VIEW_HEIGHT(self.collectView) >= 224 * displayScale) {
        return CGSizeMake((VIEW_WIDTH(_calendar) - 12 * 3) / 4, ((224 * displayScale) - 12 * 3) / 4);
    }
    return CGSizeMake((VIEW_WIDTH(_calendar) - 12 * 3) / 4, (VIEW_HEIGHT(self.collectView) - 12 * 3) / 4);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath != selectTimeIndex) {
        CollectionCell *cell = (CollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.timeBtn.layer.borderColor = self.timeDetailSelectColor.CGColor;
        [cell.timeBtn setTitleColor:self.timeDetailSelectColor forState:UIControlStateNormal];

        CollectionCell *lastcell = (CollectionCell *)[collectionView cellForItemAtIndexPath:selectTimeIndex];
        lastcell.timeBtn.layer.borderColor = self.timeDetailColor.CGColor;
        [lastcell.timeBtn setTitleColor:self.timeDetailColor forState:UIControlStateNormal];
        selectTimeIndex = indexPath;
        if ([selectDay isEqual:@""]) {
            selectDay = @"no day select";
        }
        selectDay = [selectDay substringWithRange:NSMakeRange(0, 10)];
        selectDay = [NSString stringWithFormat:@"%@ %@",selectDay,cell.timeBtn.titleLabel.text];

        if ([self.delegate respondsToSelector:@selector(calendar:selectTime: )]) {
            [self.delegate calendar:self selectTime:selectDay];
        }
    }
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma -mark 时间选择按钮点击事件
- (void)afternoonClick: (UIButton *)sender {
    [self bringSubviewToFront:self.afternoonBtn];
    self.morningBtn.layer.borderColor = self.timeBtnSelectColor == nil ? normalColor.CGColor : self.timeBtnSelectColor.CGColor;
    self.morningBtn.layer.borderWidth = 1;
    self.morningBtn.backgroundColor = [UIColor whiteColor];
    [self.morningBtn setTitleColor: self.timeBtnSelectColor == nil ? normalColor : self.timeBtnSelectColor forState:UIControlStateNormal];
    sender.layer.borderColor = self.timeBtnSelectColor == nil ? normalColor.CGColor : self.timeBtnSelectColor.CGColor;
    sender.backgroundColor = self.timeBtnSelectColor == nil ? normalColor : self.timeBtnSelectColor;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    timeData = self.afternoonData;
    [self.collectView reloadData];
}

- (void)morningClick: (UIButton *)sender {
    [self bringSubviewToFront:self.morningBtn];
    self.afternoonBtn.layer.borderColor = self.timeBtnSelectColor == nil ? normalColor.CGColor : self.timeBtnSelectColor.CGColor;
    self.afternoonBtn.backgroundColor = [UIColor whiteColor];
    [self.afternoonBtn setTitleColor:self.timeBtnSelectColor == nil ? normalColor : self.timeBtnSelectColor forState:UIControlStateNormal];
    sender.layer.borderColor = self.timeBtnSelectColor == nil ? normalColor.CGColor : self.timeBtnSelectColor.CGColor;
    sender.backgroundColor = self.timeBtnSelectColor == nil ? normalColor : self.timeBtnSelectColor;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    timeData = self.morningData;
    [self.collectView reloadData];
}

- (void)setCalendarData {
    [self morningClick:_morningBtn];
}


@end

@implementation CollectionCell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _timeBtn = [[UIButton alloc]init];
        _timeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _timeBtn.layer.borderWidth = 1;
        _timeBtn.layer.cornerRadius = 5;
        [_timeBtn setTitle:@"8:00" forState:UIControlStateNormal];
        [_timeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _timeBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _timeBtn.enabled = NO;
        [self addSubview:_timeBtn];
    }
    return self;
}
@end

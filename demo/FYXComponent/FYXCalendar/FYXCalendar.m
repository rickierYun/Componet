//
//  FYXCalendar.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/24.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "FYXCalendar.h"

#define normalColor [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f]
#define weekColor [UIColor colorWithRed:1 green:197.0 / 255 blue:20.0 / 255 alpha:1.0f]
#define todayTitleColor [UIColor colorWithRed:150.0 / 255 green:150.0 / 255 blue:150.0 / 255 alpha:1.0f]
@implementation FYXCalendar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        _calendar = [[FSCalendar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
        _calendar.dataSource = self;
        _calendar.delegate   = self;
        _calendar.scope      = FSCalendarScopeWeek;
        _calendar.backgroundColor = [UIColor whiteColor];
        _calendar.appearance.headerMinimumDissolvedAlpha = 0;
        _calendar.appearance.todayColor = [UIColor whiteColor]; // 今天选中的颜色
        _calendar.appearance.selectionColor = [UIColor whiteColor]; // 选中的颜色
        _calendar.appearance.titleTodayColor =  todayTitleColor; // 今天的字体颜色
        _calendar.appearance.satAndSunColor = weekColor;              // 周六周日的颜色
        _calendar.appearance.titleSelectionColor = normalColor;       // 选中后字体颜色
        _calendar.appearance.weekdayTextColor = [UIColor blackColor]; // 周末字体颜色
        _calendar.appearance.titleWeekendColor = weekColor;           // 具体周末日期颜色
        _calendar.appearance.borderRadius = 1;                        // 选中的边角弧度
        _calendar.appearance.borderSelectionColor = normalColor;      // 选中的边角颜色
        _calendar.appearance.headerTitleColor = [UIColor blackColor]; // 年份时间
        _calendar.appearance.headerDateFormat = @"yyyy年MM月";         // 设置年份格式
        [self addSubview:_calendar];
        _gregorianCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return self;
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    if ([self.gregorianCalendar isDateInToday:date]) {
        return @"今天";
    }
    return nil;
}

@end

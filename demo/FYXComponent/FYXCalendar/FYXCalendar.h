//
//  FYXCalendar.h
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/24.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"

@interface FYXCalendar : UIView <FSCalendarDelegate, FSCalendarDataSource>

@property (nonatomic, strong) FSCalendar *calendar;
@property (nonatomic, strong) NSCalendar *gregorianCalendar;
@end

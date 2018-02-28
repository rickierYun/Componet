//
//  FYXCalendarDataModel.h
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/27.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYXCalendarDataModel : NSObject

/**
 *  显示文字
 */
@property (nonatomic, copy) NSString  *timeStr;
/**
 *   不能点击时显示图片
 */
@property (nonatomic, copy) NSString  *timeUnenabledPic;
/**
 *   能不能点击的状态： 0 可以点击， 1不可以点击
 */
@property (nonatomic, assign) NSInteger timeStatus;
@end

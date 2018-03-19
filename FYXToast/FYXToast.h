//
//  FYXToast.h
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/23.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define DEFAULT_DISPLAY_DURATION 1.5f

@interface FYXToast : NSObject {
    NSString *text;
    UIButton *contentView;
    CGFloat  duration;
    
}
/**
 *只需添加文字
 */
+ (void)showWithText:(NSString *)text_;                                                                 // 只需添加文字
/**
 *可以添加文字和持续时间
 */
+ (void)showWithText:(NSString *)text_ duration:(CGFloat)duration_;                                     // 可以添加文字和持续时间
/**
 *只需添加文字和图片名称
 */
+ (void)showWithTextImage:(NSString *)text_ imageName:(NSString *)imageName;                            // 只需添加文字和图片名称
/**
 *可以添加文字、图片名称和持续时间
 */
+ (void)showwithTextImage:(NSString *)text_ imageName:(NSString *)imageName duration:(CGFloat)duration_;// 可以添加文字、图片名称和持续时间
@end

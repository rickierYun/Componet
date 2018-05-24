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
#define displayScales    (nativeScaless() / 2)

@interface FYXToast : NSObject {
    NSString *text;
    UIButton *contentView;
    CGFloat  duration;
    
}
/**
 *只需添加文字
 */
+ (void)showWithText:(NSString *)text;                                                                 // 只需添加文字
/**
 *可以添加文字和持续时间
 */
+ (void)showWithText:(NSString *)text duration:(CGFloat)duration;                                     // 可以添加文字和持续时间
/**
 *只需添加文字和图片名称
 */
+ (void)showWithTextImage:(NSString *)text imageName:(NSString *)imageName;                            // 只需添加文字和图片名称
/**
 *可以添加文字、图片名称和持续时间
 */
+ (void)showwithTextImage:(NSString *)text imageName:(NSString *)imageName duration:(CGFloat)duration;// 可以添加文字、图片名称和持续时间

+ (void)showWithFrame:(NSString *)text frame: (CGRect)frame;

+ (void)showWithFrame:(NSString *)text frame: (CGRect)frame duration:(CGFloat)duration;
/**
 *可以添加文字、图片名称、更改大小
 */
+ (void)showWithImageFrame: (NSString *)text imageName: (NSString *)imageName frame: (CGRect)frame;
/**
 *可以添加文字、图片名称、持续时间、更改大小
 */
+ (void)showWithImageFrame: (NSString *)text imageName: (NSString *)imageName frame: (CGRect)frame duration: (CGFloat)duration;
@end

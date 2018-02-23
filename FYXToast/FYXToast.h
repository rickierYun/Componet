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

+ (void)showWithText:(NSString *)text_;
+ (void)showWithText:(NSString *)text_ duration:(CGFloat)duration_;
+ (void)showWithTextImage:(NSString *)text_ imageName:(NSString *)imageName;
+ (void)showwithTextImage:(NSString *)text_ imageName:(NSString *)imageName duration:(CGFloat)duration_;
@end

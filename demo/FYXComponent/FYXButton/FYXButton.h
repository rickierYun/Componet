//
//  FYXButton.h
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/23.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FYXButton : UIButton 
@end

@interface UIColor (BtnBGColor)
+ (UIColor *)getMainGradientColor:(CGRect)frame; /**< 设置背景渐变 > */

@end

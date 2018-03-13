//
//  FYXLoadingHud.h
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/12.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYXLoadingHud : UIView

-(void)start;

-(void)hide;

/**
 * 显示loadingHud
 */
+(FYXLoadingHud*)showIn:(UIView*)view;

/**
 * 隐藏loadingHud
 */
+(FYXLoadingHud*)hideIn:(UIView*)view;
@end

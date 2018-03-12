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

+(FYXLoadingHud*)showIn:(UIView*)view;

+(FYXLoadingHud*)hideIn:(UIView*)view;
@end

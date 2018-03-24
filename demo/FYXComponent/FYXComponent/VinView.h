//
//  VinView.h
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/23.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VinView;

@protocol VinViewDelegate <NSObject>

@optional

- (void)nextClick: (NSString *)vinStr;

@end

@interface VinView : UIView <UITextFieldDelegate>

@property (nonatomic, weak) id<VinViewDelegate>delegate;
@end

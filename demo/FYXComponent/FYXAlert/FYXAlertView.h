//
//  FYXAlertView.h
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/9.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define displayScale    (nativeScale() / 2)

@class FYXAlertView;

@protocol FYXAlertViewDelegate <NSObject>

@optional

- (void)sureDidClick: (FYXAlertView *)alertView;    // 确定按钮点击事件

@end

@interface FYXAlertView : UIView

@property (nonatomic, strong) UIButton * sureBtn;
@property (nonatomic, strong) UIButton * cancelBtn;
@property (nonatomic, assign) id<FYXAlertViewDelegate>delegate;


- (void)setAlertTitle: (NSString *)alertTitle titleFont:(NSInteger) titleFont;      // 普通弹框
- (void)setMsgAlertFrame: (NSInteger)alertHeight AlertWidth:(NSInteger)alertWidth;  // 设置文字弹窗大小
- (void)setRichTextView: (NSString*)textContent textFont:(NSInteger)textFont;       // 设置富文本
- (void)setRichTextViewFrame: (NSInteger)width height:(NSInteger)height;            // 设置富文本大小
- (void)setMsgAlertView: (NSString *)alertTitle 
              titleFont: (NSInteger) titleFont
               alertMsg: (NSString *)msg
                msgFont: (NSInteger)msgFont;                                         // 文字弹框

- (void)setImageAlertView: (NSString *)content
              contentFont: (NSInteger)contentFont
             contentColor: (UIColor *)contentColor
                imageName: (NSString *)imageName;                                   // 图片提示框
@end

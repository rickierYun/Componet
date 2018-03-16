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
/**
 *确定按钮点击事件
 */
- (void)sureDidClick: (FYXAlertView *)alertView;
/**
 *其他按钮点击事件
 */
- (void)otherBtnDidClick: (FYXAlertView *)alertView;
@end

@interface FYXAlertView : UIView

@property (nonatomic, weak) UIButton * sureBtn;
@property (nonatomic, weak) UIButton * cancelBtn;
@property (nonatomic, weak) UIButton * middleBtn;
@property (nonatomic, assign) id<FYXAlertViewDelegate>delegate;


/**
 *普通弹框
 */
- (void)setAlertTitle: (NSString *)alertTitle titleFont:(NSInteger) titleFont;      // 普通弹框
/**
 *设置文字弹窗大小
 */
- (void)setMsgAlertFrame: (NSInteger)alertHeight AlertWidth:(NSInteger)alertWidth;  // 设置文字弹窗大小
/**
 *设置富文本
 */
- (void)setRichTextView: (NSString*)textContent textFont:(NSInteger)textFont;       // 设置富文本
/**
 *设置富文本大小
 */
- (void)setRichTextViewFrame: (NSInteger)width height:(NSInteger)height;            // 设置富文本大小
/**
 *文字弹框
 */
- (void)setMsgAlertView: (NSString *)alertTitle 
              titleFont: (NSInteger) titleFont
               alertMsg: (NSString *)msg
                msgFont: (NSInteger)msgFont
               msgColor: (UIColor *)msgColor;                                         // 文字弹框
/**
 *图片提示框
 */
- (void)setImageAlertView: (NSString *)content
              contentFont: (NSInteger)contentFont
             contentColor: (UIColor *)contentColor
                imageName: (NSString *)imageName;                                    // 图片提示框
/**
 *设置多个按钮提示
 */
- (void)setMoreBtnAlertView: (NSString *)content contentFont: (NSInteger)contentFont;// 设置多个按钮提示
/**
 *气泡弹窗
 */
- (void)setBubbleView: (NSString *)text font: (CGFloat)textFont textColor: (UIColor *)textColor;
/**
 *故障灯
 */
- (void)setSafeLightView: (NSString *)instructText
                 suggest: (NSString *)suggestText
                   title: (NSString *)title
           instruteTitle: (NSString * )instruteTitle
            suggestTitle: (NSString *)suggestTitle
              titleImage: (NSString *)titleImage;
@end

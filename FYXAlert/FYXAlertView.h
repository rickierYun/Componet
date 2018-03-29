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
 *取消点击事件
 */
- (void)copyDidClick: (FYXAlertView *)alertView;
/**
 *其他按钮点击事件
 */
- (void)otherBtnDidClick: (FYXAlertView *)alertView;
/**
 *取消按钮点击事件
 */
- (void)cancelBtnDidClick: (FYXAlertView *)alertView;
/**
 *背景取消
 */
- (void)hiddenClick: (FYXAlertView *)alertView;
@end

@interface FYXAlertView : UIView
@property (nonatomic, weak) UIView   * alertView;
@property (nonatomic, weak) UIButton * sureBtn;
@property (nonatomic, weak) UIButton * cancelBtn;
@property (nonatomic, weak) UIButton * middleBtn;
@property (nonatomic, weak) UIButton * otherBtn;
@property (nonatomic, weak) UILabel  * msgLabel;           // 提示内容
@property (nonatomic, weak) id<FYXAlertViewDelegate>delegate;


/**
 *普通弹框
 */
- (void)setAlertTitle: (NSString *)alertTitle titleFont:(NSInteger) titleFont;      // 普通弹框
/**
 *设置普通弹框大小
 */
- (void)setAlertTitleFrame : (CGRect)frame;                                         
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
 *图片弹窗大小
 */
- (void)setImageAlertViewFrame: (CGRect)frame;
/**
 *设置多个按钮提示
 */
- (void)setMoreBtnAlertView: (NSString *)content contentFont: (NSInteger)contentFont;// 设置多个按钮提示
/**
 *设置多按钮大小
 */
- (void)setMoreBtnAlertViewFrame: (CGRect)frame;
/**
 *气泡弹窗
 */
- (void)setBubbleView: (NSString *)text font: (CGFloat)textFont textColor: (UIColor *)textColor;
/**
 *设置气泡弹窗高度
 */
- (void)setBubbleViewY: (CGFloat)ViewY;
/**
 *故障灯
 */
- (void)setSafeLightView: (NSString *)instructText
                 suggest: (NSString *)suggestText
                   title: (NSString *)title
           instruteTitle: (NSString * )instruteTitle
            suggestTitle: (NSString *)suggestTitle
              titleImage: (NSString *)titleImage;
/**
 *设置故障灯大小
 */
- (void)setSafeLightView: (CGRect)frame;
/**
 *优惠券
 */
- (void)setCardAlert: (NSString *)title
            subtitle: (NSString *)subtitle
            cardNumb: (NSString *)cardNumb
              cardPw: (NSString *)cardPw
              prompt: (NSString *)prompt
          firstImage: (NSString *)firstImage
         secondImage: (NSString *)secondImage
          thirdImage: (NSString *)thirdImage
         firstString: (NSString *)firstString
        secondString: (NSString *)secondString
         thirdString: (NSString *)thirdString;
/**
 *顶部弹窗
 */
- (void)setTopAlert: (NSString *)title titleFont: (CGFloat )titleFont;
/**
 *设置顶部弹窗高度
 */
- (void)tTopAlertHight: (CGFloat)height;
/**
 *更改点击范围
 **/
- (void)setOtherBtnframe: (NSRange )range;
@end

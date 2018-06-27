    //
//  FYXAlertView.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/9.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "FYXAlertView.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import <CoreText/CoreText.h>

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define VIEW_CENTER(aView)       ((aView).center)
#define VIEW_CENTER_X(aView)     ((aView).center.x)
#define VIEW_CENTER_Y(aView)     ((aView).center.y)

#define VIEW_FRAME(aView)        ((aView).frame)

#define VIEW_ORIGIN(aView)       ((aView).frame.origin)
#define VIEW_X(aView)            ((aView).frame.origin.x)
#define VIEW_Y(aView)            ((aView).frame.origin.y)

#define VIEW_SIZE(aView)         ((aView).frame.size)
#define VIEW_HEIGHT(aView)       ((aView).frame.size.height)
#define VIEW_WIDTH(aView)        ((aView).frame.size.width)

#define VIEW_X_Right(aView)      ((aView).frame.origin.x + (aView).frame.size.width)
#define VIEW_Y_Bottom(aView)     ((aView).frame.origin.y + (aView).frame.size.height)

CGFloat nativeScale(void) {
    static CGFloat scale = 0.0f;
    if (scale == 0.0f) {
        CGFloat width = SCREEN_WIDTH;
        scale = width / 375.0f;
    }
    return scale * 2;
}


@implementation FYXAlertView
{
    UIButton    * _backGroundBtn;      // 灰色背景按钮
    UILabel     * _alertTitle;         // 提示文字
    UILabel     * _subtitle;           // 副标题
    UILabel     * _cardNumb;           // 卡券账号
    UILabel     * _cardPw;             // 卡券密码
    UIView      * _msgAlertView;       // 文字弹窗view
    UIImageView * _alertTitleImage;    // 提示图片
    UIView      * _lineBreak1;         // 分割线
    NSString    * _text;               // 文字载体
    UIScrollView* _safeLightView;      // 安全提示灯
    UILabel     * _btnLabel1;
    UILabel     * _btnLabel2;
    UILabel     * _btnLabel3;
    UILabel     * _prompt;
    UILabel     * _instruteTitleLb;
    UILabel     * _instruteTextLb;
    UILabel     * _suggestTitleLb;
    UILabel     * _suggestLb;
    UIView      * lineBreak2;
}

- (id)initWithFrame: (CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self createMainViewWithFrame: frame];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self createMainViewWithFrame: frame];
}

- (void)createMainViewWithFrame: (CGRect)frame {

    [_backGroundBtn removeFromSuperview];
    _backGroundBtn = nil;
    // 背景按钮
    _backGroundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backGroundBtn.frame = self.frame;
    [_backGroundBtn setTitle:@"" forState:UIControlStateNormal];
    [_backGroundBtn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [_backGroundBtn addTarget:self action:@selector(hiddenClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _backGroundBtn];

    // 初始一根分割线
    _lineBreak1 = [[UIView alloc]init];
    _lineBreak1.backgroundColor = [UIColor colorWithRed:235.0 / 255 green:235.0 / 255 blue:235.0 / 255 alpha:1];

}

#pragma -mark 基本弹窗
// 创建弹窗
- (void)createAlertView {
    UIView *_alertView = [[UIView alloc]init];
    _alertView.frame = CGRectMake(55 * displayScale, 200 * displayScale, VIEW_WIDTH(self)  - 110 *displayScale, 135 * displayScale);
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 0.96;
    _alertView.layer.cornerRadius = 8;
    [self addSubview:_alertView];
    self.alertView = _alertView;

    _alertTitle = [[UILabel alloc]init];
    _alertTitle.frame = CGRectMake(19 * displayScale, 5, VIEW_WIDTH(_alertView) - 38 * displayScale, VIEW_HEIGHT(_alertView) * 2 / 3);
    _alertTitle.numberOfLines = 0;
    _alertTitle.lineBreakMode = NSLineBreakByCharWrapping;
    _alertTitle.textAlignment = NSTextAlignmentCenter;
    _alertTitle.textColor     = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
    [_alertView addSubview:_alertTitle];
    self.msgLabel = _alertTitle;

    // 取消、确定按钮
    UIButton *_sureBtn   = [[UIButton alloc]init];
    UIButton *_cancelBtn = [[UIButton alloc]init];

    _sureBtn.frame   = CGRectMake(VIEW_WIDTH(_alertView) / 2, VIEW_HEIGHT(_alertTitle) + 5 * displayScale, VIEW_WIDTH(_alertView) / 2, 50 * displayScale);
    _cancelBtn.frame = CGRectMake(0,VIEW_HEIGHT(_alertTitle) + 5 * displayScale, VIEW_WIDTH(_alertView) / 2, 50 * displayScale);
    
    [_cancelBtn setTitleColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor colorWithRed:11/255.0 green:171/255.0 blue:254/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    _sureBtn.titleLabel.font   = [UIFont boldSystemFontOfSize:18 * displayScale];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18 * displayScale];

    [_sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];

    [_alertView addSubview:_sureBtn];
    [_alertView addSubview:_cancelBtn];
    self.sureBtn = _sureBtn;
    self.cancelBtn = _cancelBtn;

    // 分割线

    lineBreak2 = [[UIView alloc]init];

    _lineBreak1.frame = CGRectMake(VIEW_X(_cancelBtn), VIEW_Y(_cancelBtn), VIEW_WIDTH(_alertView), 1);
    lineBreak2.frame  = CGRectMake(VIEW_WIDTH(_alertView) / 2, VIEW_Y(_cancelBtn), 1, VIEW_HEIGHT(_cancelBtn));

    lineBreak2.backgroundColor = [UIColor colorWithRed:235.0 / 255 green:235.0 / 255 blue:235.0 / 255 alpha:1];

    [_alertView addSubview:_lineBreak1];
    [_alertView addSubview:lineBreak2];

}

// 设置弹框文字
- (void)setAlertTitle: (NSString *)alertTitle titleFont:(NSInteger) titleFont{
    [self createAlertView];
    _alertTitle.text = alertTitle;

    [_alertTitle setFont: [UIFont systemFontOfSize:( titleFont * displayScale)]];

    //根据字数和字体自适应大小。
    //如有不适应的地方，可以调节
    //[UIFont boldSystemFontOfSize: 17 * displayScale] 和 [alertTitle boundingRectWithSize:CGSizeMake(220 * displayScale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size 中的数字来适配
    UIFont *font = [UIFont boldSystemFontOfSize: 17 * displayScale];
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize textSize = [alertTitle boundingRectWithSize:CGSizeMake(220 * displayScale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

    //判断是否有字母，特殊处理排版的问题
    if ([self isABC:alertTitle]) {
        _alertTitle.frame = CGRectMake(19 * displayScale, 40 * displayScale, VIEW_WIDTH(_alertView) - 38 * displayScale, textSize.height);
    }
    else {
        _alertTitle.frame = CGRectMake(25 * displayScale, 40 * displayScale, VIEW_WIDTH(_alertView) -50 * displayScale, textSize.height);
    }


    self.alertView.frame = CGRectMake(55 * displayScale, 200 * displayScale, VIEW_WIDTH(self)  - 110 *displayScale, VIEW_Y_Bottom(_alertTitle) +  75 * displayScale);
    _sureBtn.frame   = CGRectMake(VIEW_WIDTH(_alertView) / 2, VIEW_Y_Bottom(_alertTitle) + 24 * displayScale, VIEW_WIDTH(_alertView) / 2, 50 * displayScale);
    _cancelBtn.frame = CGRectMake(0,VIEW_Y_Bottom(_alertTitle) + 24 * displayScale, VIEW_WIDTH(_alertView) / 2, 50 * displayScale);
    lineBreak2.frame  = CGRectMake(VIEW_WIDTH(_alertView) / 2, VIEW_Y(_cancelBtn), 1, VIEW_HEIGHT(_cancelBtn));
    _lineBreak1.frame = CGRectMake(VIEW_X(_cancelBtn), VIEW_Y(_cancelBtn), VIEW_WIDTH(_alertView), 1);

    //第一很居中对齐
    if ([[self getLinesArrayOfStringInLabel:_alertTitle] count] > 1) {
        _alertTitle.textAlignment = NSTextAlignmentLeft;
    }else { // 其他行居左对齐
        _alertTitle.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)setAlertTitleFrame : (CGRect)frame {
    self.alertView.frame = frame;
}
#pragma -mark 文字弹窗
- (void)createMsgAlert {
    _msgAlertView = [[UIView alloc]init];

    _msgAlertView.frame = CGRectMake(40 * displayScale,
                                     160 * displayScale,
                                     295 * displayScale,
                                     300 * displayScale);
    _msgAlertView.layer.cornerRadius = 8;
    _msgAlertView.backgroundColor = [UIColor whiteColor];
    _msgAlertView.alpha = 0.96;
    [self addSubview:_msgAlertView];

    _alertTitle = [[UILabel alloc]init];
    _alertTitle.frame = CGRectMake(24 * displayScale, 25 * displayScale, VIEW_WIDTH(_msgAlertView) - 48 * displayScale, 23 * displayScale);
    _alertTitle.numberOfLines = 2;
    _alertTitle.textAlignment = NSTextAlignmentCenter;
    _alertTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [_msgAlertView addSubview:_alertTitle];
    self.msgLabel = _alertTitle;

    UITextView *_richTextView = [[UITextView alloc]init];
    _richTextView.frame = CGRectMake(24 * displayScale,
                                 VIEW_Y_Bottom(_alertTitle) + 12 * displayScale,
                                 VIEW_WIDTH(_msgAlertView) - 48 * displayScale,
                                 VIEW_HEIGHT(_msgAlertView) - VIEW_HEIGHT(_alertTitle) - 116 * displayScale);

    _richTextView.textAlignment = NSTextAlignmentLeft;
    _richTextView.textColor     = [UIColor blackColor];
    _richTextView.editable = NO;
    [_msgAlertView addSubview:_richTextView];
    self.richTextView = _richTextView;


    UIButton *_cancelBtn = [[UIButton alloc]init];
    _cancelBtn.frame = CGRectMake(0,
                                  VIEW_Y_Bottom(_richTextView) +26 * displayScale,
                                  VIEW_WIDTH(_msgAlertView),
                                  50 * displayScale);

    [_cancelBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18 * displayScale]];
    [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [_msgAlertView addSubview:_cancelBtn];
    self.cancelBtn = _cancelBtn;


}

// 设置弹窗内容
- (void)setMsgAlertView: (NSString *)alertTitle titleFont:(NSInteger) titleFont alertMsg:(NSString *)msg msgFont:(NSInteger)msgFont  msgColor: (UIColor *)msgColor{
    [self createMsgAlert];
    _richTextView.editable = NO;
    _alertTitle.text = alertTitle;
    _richTextView.text   = msg;
    _richTextView.textColor = msgColor;
    [_alertTitle setFont:[UIFont boldSystemFontOfSize:titleFont * displayScale]];
    if ([alertTitle length] > 12) {
        _alertTitle.frame = CGRectMake(24 * displayScale,25 * displayScale , VIEW_WIDTH(_msgAlertView) - 48 * displayScale, 60 * displayScale);

    }

    //根据字数和字体自适应大小。
    //如有不适应的地方，可以调节
    //[UIFont boldSystemFontOfSize: 16 ] 和 [alertTitle boundingRectWithSize:CGSizeMake(240, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size 中的数字来适配
    UIFont *font = [UIFont boldSystemFontOfSize: 16];
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize textSize = [msg boundingRectWithSize:CGSizeMake(240, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

    //判断是否大于300的高度
    if (( textSize.height + VIEW_Y_Bottom(_alertTitle) + 92 * displayScale) < 300 *displayScale ) {
        NSLog(@"%f",VIEW_Y_Bottom(_alertTitle));
        if (SCREEN_WIDTH == 320) {
            _msgAlertView.frame = CGRectMake(40 * displayScale,
                                             160 * displayScale,
                                             295 * displayScale,
                                             textSize.height + VIEW_Y_Bottom(_alertTitle) + 92 * displayScale);
            _richTextView.frame  = CGRectMake(24 * displayScale,
                                              VIEW_Y_Bottom(_alertTitle) + 12* displayScale,
                                              VIEW_WIDTH(_msgAlertView) - 48 * displayScale,
                                              textSize.height + 20 * displayScale );

            _cancelBtn.frame    = CGRectMake(0,
                                             VIEW_Y_Bottom(_richTextView) +6 * displayScale,
                                             VIEW_WIDTH(_msgAlertView),
                                             50 * displayScale);
        }else {
            _msgAlertView.frame = CGRectMake(40 * displayScale,
                                             160 * displayScale,
                                             295 * displayScale,
                                             textSize.height + VIEW_Y_Bottom(_alertTitle) + 102 * displayScale);
            _richTextView.frame  = CGRectMake(24 * displayScale,
                                              VIEW_Y_Bottom(_alertTitle) + 12 * displayScale,
                                              VIEW_WIDTH(_msgAlertView) - 48 * displayScale,
                                              textSize.height + 20 * displayScale );

            _cancelBtn.frame    = CGRectMake(0,
                                             VIEW_Y_Bottom(_richTextView) +16 * displayScale,
                                             VIEW_WIDTH(_msgAlertView),
                                             50 * displayScale);
        }

    }else { // 大于300的固定高度并允许滑动
        _msgAlertView.frame = CGRectMake(40 * displayScale,
                                         160 * displayScale,
                                         295 * displayScale,
                                         300 * displayScale);
        _richTextView.frame = CGRectMake(24 * displayScale,
                                         VIEW_Y_Bottom(_alertTitle) + 12 * displayScale,
                                         VIEW_WIDTH(_msgAlertView) - 48 * displayScale,
                                         VIEW_HEIGHT(_msgAlertView) - VIEW_HEIGHT(_alertTitle) - 116 * displayScale);
        _cancelBtn.frame    = CGRectMake(0,
                                         VIEW_Y_Bottom(_richTextView) +26 * displayScale,
                                         VIEW_WIDTH(_msgAlertView),
                                         50 * displayScale);
    }

    // 分割线
    _lineBreak1.frame   = CGRectMake(0 * displayScale, VIEW_Y(_cancelBtn) - 2 * displayScale, VIEW_WIDTH(_cancelBtn), 1);
    [_msgAlertView addSubview:_lineBreak1];
    [_richTextView setFont:[UIFont systemFontOfSize:msgFont * displayScale]];

}

// 设置文本弹窗大小
- (void)setMsgAlertFrame: (CGRect)frame {
    _msgAlertView.frame = frame;
    _alertTitle.frame   = CGRectMake(24 * displayScale,25 * displayScale , VIEW_WIDTH(_msgAlertView) - 48 * displayScale, 30 * displayScale);

    _richTextView.frame  = CGRectMake(24 * displayScale,
                                         VIEW_HEIGHT(_alertTitle) + VIEW_Y(_alertTitle) + 12 * displayScale,
                                         VIEW_WIDTH(_msgAlertView) - 48 * displayScale,
                                         VIEW_HEIGHT(_msgAlertView) - VIEW_HEIGHT(_alertTitle) - 116 * displayScale);

    _cancelBtn.frame    = CGRectMake(0,
                                     VIEW_Y_Bottom(_richTextView) +26 * displayScale,
                                     VIEW_WIDTH(_msgAlertView),
                                     50 * displayScale);

    _lineBreak1.frame   = CGRectMake(8 * displayScale, VIEW_Y(_cancelBtn) - 2 * displayScale, VIEW_WIDTH(_cancelBtn) - 16, 1);

    [_msgAlertView addSubview:_lineBreak1];
}

// 设置文本弹窗的高度
- (void)setMsgAlertHeight: (NSInteger)alertHeight AlertWidth:(NSInteger)alertWidth {
    _msgAlertView.frame = CGRectMake(VIEW_CENTER_X(self) - alertWidth / 2 * displayScale,
                                     160 * displayScale,
                                     alertWidth * displayScale,
                                     alertHeight * displayScale);

    _alertTitle.frame   = CGRectMake(24 * displayScale,25 * displayScale , VIEW_WIDTH(_msgAlertView) - 48 * displayScale, 38 * displayScale);

    _richTextView.frame     = CGRectMake(24 * displayScale,
                                     VIEW_HEIGHT(_alertTitle) + VIEW_Y(_alertTitle) + 12 * displayScale,
                                     VIEW_WIDTH(_msgAlertView) - 48 * displayScale,
                                     VIEW_HEIGHT(_msgAlertView) - VIEW_HEIGHT(_alertTitle) - 116 * displayScale);

    _cancelBtn.frame    = CGRectMake(0,
                                     VIEW_Y_Bottom(_richTextView) + 26,
                                     VIEW_WIDTH(_msgAlertView),
                                     50 * displayScale);

    _lineBreak1.frame   = CGRectMake(0 * displayScale, VIEW_Y(_cancelBtn) - 2 * displayScale, VIEW_WIDTH(_cancelBtn), 1);

    [_msgAlertView addSubview:_lineBreak1];
}


#pragma -mark 富文本显示框
- (void)createRichTextAlertView {
    UITextView *_richTextView = [[UITextView alloc]init];
    _richTextView.frame = CGRectMake(VIEW_CENTER_X(self) - 100 * displayScale, 160 * displayScale, 200 * displayScale, 300 * displayScale);
    _richTextView.textColor = [UIColor blackColor];
    _richTextView.textAlignment = NSTextAlignmentLeft;
    _richTextView.backgroundColor = [UIColor whiteColor];
    _richTextView.alpha = 0.96;
    _richTextView.editable = NO;
    _richTextView.layer.cornerRadius = 8;

    [self addSubview:_richTextView];
    self.richTextView = _richTextView;

    UIButton *_cancelBtn = [[UIButton alloc]init];
    _cancelBtn.frame = CGRectMake(VIEW_CENTER_X(_richTextView) + 8 * displayScale,
                                  VIEW_HEIGHT(_richTextView) + 20 * displayScale + VIEW_Y(_richTextView),
                                  30 * displayScale,
                                  30 * displayScale);

    [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [self addSubview:_cancelBtn];
    self.cancelBtn = _cancelBtn;
}


// 设置富文本内容
- (void)setRichTextView: (NSString*)textContent textFont:(NSInteger)textFont {
    [self createRichTextAlertView];
    _richTextView.text = textContent;
    [_richTextView setFont:[UIFont systemFontOfSize:textFont * displayScale]];
}

// 设置富文本高度
- (void)setRichTextViewFrame: (NSInteger)width height:(NSInteger)height {
    _richTextView.frame = CGRectMake(VIEW_CENTER_X(self) - width / 2 * displayScale,
                                     160 * displayScale,
                                     width * displayScale,
                                     height * displayScale);

    _cancelBtn.frame    = CGRectMake(VIEW_CENTER_X(self) - 15 * displayScale,
                                     VIEW_HEIGHT(_richTextView) + 20 * displayScale + VIEW_Y(_richTextView),
                                     30 * displayScale,
                                     30 * displayScale);
}

#pragma -mark 图片的提示框
- (void)createImageAlertView {
    UIView *_alertView = [[UIView alloc]init];
    _alertView.frame = CGRectMake(40 * displayScale, 160 * displayScale, VIEW_WIDTH(self) - 80 * displayScale, 200 * displayScale);
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 0.96;
    _alertView.layer.cornerRadius = 8;
    [self addSubview:_alertView];
    self.alertView = _alertView;

    _alertTitleImage = [[UIImageView alloc]init];
    _alertTitleImage.frame = CGRectMake(VIEW_WIDTH(_alertView) / 2 - 25 * displayScale, 18 * displayScale, 50 * displayScale, 50 * displayScale);
    _alertTitleImage.image = [UIImage imageNamed:@"sure.png"];
    [_alertView addSubview:_alertTitleImage];

    UILabel *_msgLabel = [[UILabel alloc]init];
    _msgLabel.frame = CGRectMake(15,
                                 VIEW_Y(_alertTitleImage) + VIEW_HEIGHT(_alertTitleImage),
                                 VIEW_WIDTH(_alertView) - 30 * displayScale,
                                 70 * displayScale);
    _msgLabel.numberOfLines = 0;
    _msgLabel.textAlignment = NSTextAlignmentCenter;
    _msgLabel.textColor     = [UIColor blackColor];
    [_alertView addSubview:_msgLabel];
    self.msgLabel = _msgLabel;

    UIButton *_cancelBtn = [[UIButton alloc]init];
    _cancelBtn.frame = CGRectMake(0,
                                  VIEW_HEIGHT(_msgLabel) + 10 * displayScale + VIEW_Y(_msgLabel),
                                  VIEW_WIDTH(_alertView),
                                  50 * displayScale);
    [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor colorWithRed:11.0 / 255 green:171.0 / 255 blue:254.0/255 alpha:1] forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18 * displayScale];
    [_alertView addSubview:_cancelBtn];

    self.cancelBtn = _cancelBtn;
    // 分割线
    _lineBreak1.frame = CGRectMake(0 * displayScale, VIEW_Y(_cancelBtn), VIEW_WIDTH(_cancelBtn), 1);
    [_alertView addSubview:_lineBreak1];
}

// 设置图片弹窗
- (void)setImageAlertView: (NSString *)content contentFont: (NSInteger)contentFont contentColor: (UIColor *)contentColor imageName: (NSString *)imageName {
    [self createImageAlertView];
    _msgLabel.text = content;
    _msgLabel.textColor = contentColor;
    [_msgLabel setFont:[UIFont systemFontOfSize:contentFont * displayScale]];

    if (imageName != nil) {
        _alertTitleImage.image = [UIImage imageNamed:imageName];
    }

    //根据字数和字体自适应大小。
    //如有不适应的地方，可以调节
    //[UIFont boldSystemFontOfSize: 16 ] 和 [alertTitle boundingRectWithSize:CGSizeMake(240, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size 中的数字来适配
    UIFont *font = [UIFont boldSystemFontOfSize: contentFont];
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize textSize = [content boundingRectWithSize:CGSizeMake(240, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    if (textSize.height > 70 * displayScale) {
        _alertView.frame = CGRectMake(40 * displayScale, 160 * displayScale, VIEW_WIDTH(self) - 80 * displayScale, 200 * displayScale + textSize.height - 70 * displayScale);
        _msgLabel.frame = CGRectMake(15,
                                     VIEW_Y(_alertTitleImage) + VIEW_HEIGHT(_alertTitleImage),
                                     VIEW_WIDTH(_alertView) - 30 * displayScale,
                                     textSize.height);
        _cancelBtn.frame = CGRectMake(0,
                                      VIEW_HEIGHT(_msgLabel) + 10 * displayScale + VIEW_Y(_msgLabel),
                                      VIEW_WIDTH(_alertView),
                                      50 * displayScale);
        _lineBreak1.frame = CGRectMake(0 * displayScale, VIEW_Y(_cancelBtn), VIEW_WIDTH(_cancelBtn), 1);

    }

}
// 设置图片弹窗大小
- (void)setImageAlertViewFrame: (CGRect)frame {
    self.alertView.frame = frame;
}

# pragma -mark 三个按钮弹窗
// 三个按钮弹窗
- (void)creatMoreBtnAlertView {
    UIView *_alertView = [[UIView alloc]init];
    _alertView.frame = CGRectMake(55 * displayScale, 160 * displayScale, VIEW_WIDTH(self) - 110 * displayScale, 278 * displayScale);
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 0.96;
    _alertView.layer.cornerRadius = 8;
    [self addSubview:_alertView];
    self.alertView = _alertView;

    UILabel *_msgLabel = [[UILabel alloc]init];
    _msgLabel.frame = CGRectMake(22 * displayScale , 40 * displayScale, VIEW_WIDTH(_alertView) - 44 * displayScale, 70 * displayScale);
    _msgLabel.textAlignment = NSTextAlignmentLeft;
    _msgLabel.textColor     = [UIColor colorWithRed:50 / 255.0 green:50 / 255.0 blue:50 / 255.0 alpha:1];
    _msgLabel.numberOfLines = 0;
    [_alertView addSubview:_msgLabel];
    self.msgLabel = _msgLabel;

    UIButton *_sureBtn = [[UIButton alloc]init];
    _sureBtn.frame = CGRectMake(0, VIEW_Y(_msgLabel) + VIEW_HEIGHT(_msgLabel) + 24 * displayScale, VIEW_WIDTH(_alertView), 48 * displayScale);
    [_sureBtn setTitle:@"是，取消" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor colorWithRed:50.0/ 255 green:50.0 / 255 blue:50.0 / 255 alpha:1] forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_sureBtn];
    self.sureBtn = _sureBtn;

    UIButton *_middleBtn = [[UIButton alloc]init];
    _middleBtn.frame = CGRectMake(0, VIEW_Y(_sureBtn) + VIEW_HEIGHT(_sureBtn), VIEW_WIDTH(_sureBtn), VIEW_HEIGHT(_sureBtn));
    [_middleBtn setTitle:@"否，选择到店时间" forState:UIControlStateNormal];
    [_middleBtn setTitleColor:[UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1] forState:UIControlStateNormal];
    [_middleBtn addTarget:self action:@selector(otherClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_middleBtn];
    self.middleBtn = _middleBtn;

    UIButton *_cancelBtn =  [[UIButton alloc]init];
    _cancelBtn.frame = CGRectMake(0, VIEW_Y(_middleBtn) + VIEW_HEIGHT(_middleBtn), VIEW_WIDTH(_sureBtn), VIEW_HEIGHT(_sureBtn));
    [_cancelBtn setTitle:@"再想想" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor colorWithRed:11.0/255 green:171.0/255 blue:254.0/255 alpha:1] forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18 * displayScale];
    [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_cancelBtn];
    self.cancelBtn = _cancelBtn;
    // 分割线
    _lineBreak1.frame = CGRectMake(0, VIEW_Y(_sureBtn), VIEW_WIDTH(_sureBtn), 1);
    [_alertView addSubview:_lineBreak1];

    UIView * _lineBreak2 = [[UIView alloc]initWithFrame:CGRectMake(0, VIEW_Y(_middleBtn), VIEW_WIDTH(_middleBtn), 1)];
    _lineBreak2.backgroundColor = [UIColor colorWithRed:235.0 / 255 green:235.0 / 255 blue:235.0 / 255 alpha:1];
    [_alertView addSubview:_lineBreak2];

    UIView * _lineBreak3 = [[UIView alloc]initWithFrame:CGRectMake(0, VIEW_Y(_cancelBtn), VIEW_WIDTH(_cancelBtn), 1)];
    _lineBreak3.backgroundColor = [UIColor colorWithRed:235.0 / 255 green:235.0 / 255 blue:235.0 / 255 alpha:1];;
    [_alertView addSubview:_lineBreak3];

}

// 设置多按钮提示
- (void)setMoreBtnAlertView: (NSString *)content contentFont: (NSInteger)contentFont {
    [self creatMoreBtnAlertView];
    _msgLabel.text = content;
    [_msgLabel setFont:[UIFont systemFontOfSize:contentFont * displayScale]];
}

// 设置多按钮大小
- (void)setMoreBtnAlertViewFrame: (CGRect)frame {
    self.alertView.frame = frame;
}
#pragma -mark 气泡弹窗
- (void)setBubbleView: (NSString *)text font: (CGFloat)textFont textColor: (UIColor *)textColor{

    _text = [text copy];
    _alertTitle = [[UILabel alloc]init];
    _msgAlertView = [[UIView alloc]init];

    //根据字数和字体自适应大小。
    //如有不适应的地方，可以调节
    //[UIFont boldSystemFontOfSize: 16 ] 和 [alertTitle boundingRectWithSize:CGSizeMake(240, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size 中的数字来适配
    UIFont *font = [UIFont systemFontOfSize: textFont * displayScale];
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;                    // 随字数，字体扩展大小

    _alertTitle.text = _text;
    _alertTitle.font = font;
    _alertTitle.textColor = textColor;
    _alertTitle.frame = CGRectMake(8, 18, textSize.width, textSize.height);
    _alertTitle.textAlignment = NSTextAlignmentCenter;

    // 气泡背景图
    UIImageView *bubbleImageView = [[UIImageView alloc]init];
    bubbleImageView.image = [UIImage imageNamed:@"bubble.png"];
    bubbleImageView.frame = CGRectMake(0, 0, textSize.width + 16 * displayScale, textSize.height + 26 * displayScale);

    _msgAlertView.frame = CGRectMake(VIEW_WIDTH(self) - textSize.width - 30 * displayScale, 62 * displayScale, VIEW_WIDTH(bubbleImageView), VIEW_HEIGHT(bubbleImageView) + 5);
    _msgAlertView.backgroundColor = [UIColor clearColor];
    _msgAlertView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    [_msgAlertView addSubview:bubbleImageView];
    [bubbleImageView addSubview:_alertTitle];
    [self addSubview:_msgAlertView];

    UIButton *sureBtn = [[UIButton alloc]init];
    sureBtn.frame = _msgAlertView.frame;
    [sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    self.sureBtn = sureBtn;
}

- (void)setBubbleViewY: (CGFloat)ViewY{
    _msgAlertView.frame = CGRectMake(VIEW_X(_msgAlertView), ViewY, VIEW_WIDTH(_msgAlertView), VIEW_HEIGHT(_msgAlertView));
}

#pragma -mark 安全提示灯
- (void)createSafeLightView: (NSString *)instructText suggest: (NSString *)suggestText title: (NSString *)title instruteTitle: (NSString * ) instruteTitle suggestTitle: (NSString *)suggestTitle titleImage: (NSString *)titleImage{
    _alertTitleImage = [[UIImageView alloc]init];
    _alertTitleImage.frame = CGRectMake(25 * displayScale, 25 * displayScale, 70 * displayScale, 70 * displayScale);
    _alertTitleImage.image = [UIImage imageNamed:titleImage];

    UIFont *font = [UIFont boldSystemFontOfSize: 20 * displayScale];
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

    _alertTitle = [[UILabel alloc]init];
    _alertTitle.frame = CGRectMake(VIEW_X_Right(_alertTitleImage) + 20 * displayScale, VIEW_CENTER_Y(_alertTitleImage) - textSize.height / 2, 147 * displayScale, textSize.height);
    _alertTitle.text = title;
    _alertTitle.font = font;
    _alertTitle.numberOfLines = 0;
    _alertTitle.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1];

    _lineBreak1.frame = CGRectMake(VIEW_X(_alertTitleImage), VIEW_Y_Bottom(_alertTitleImage) + 10 * displayScale, SCREEN_WIDTH - 130 * displayScale, 1);

    _instruteTitleLb = [[UILabel alloc]init];
    font = [UIFont boldSystemFontOfSize: 14 * displayScale];
    attrs = @{NSFontAttributeName : font};
    textSize = [instruteTitle boundingRectWithSize:CGSizeMake(140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    _instruteTitleLb.frame = CGRectMake(VIEW_X(_lineBreak1), VIEW_Y_Bottom(_lineBreak1) + 12 * displayScale, VIEW_WIDTH(_lineBreak1), textSize.height);
    _instruteTitleLb.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1];
    _instruteTitleLb.font = font;
    _instruteTitleLb.text = instruteTitle;

    _instruteTextLb = [[UILabel alloc]init];
    font = [UIFont systemFontOfSize: 14 * displayScale];
    attrs = @{NSFontAttributeName : font};
    textSize = [instructText boundingRectWithSize:CGSizeMake(230 * displayScale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    _instruteTextLb.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:0.5];
    _instruteTextLb.numberOfLines = 0;
    _instruteTextLb.font = font;
    _instruteTextLb.text = instructText;
    _instruteTextLb.frame = CGRectMake(VIEW_X(_lineBreak1), VIEW_Y_Bottom(_instruteTitleLb) + 12 * displayScale, VIEW_WIDTH(_lineBreak1), textSize.height);

    _suggestTitleLb = [[UILabel alloc]init];
    font = [UIFont boldSystemFontOfSize: 14 * displayScale];
    attrs = @{NSFontAttributeName : font};
    textSize = [suggestTitle boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    _suggestTitleLb.frame = CGRectMake(VIEW_X(_lineBreak1), VIEW_Y_Bottom(_instruteTextLb) + 30 * displayScale, VIEW_WIDTH(_lineBreak1), textSize.height);
    _suggestTitleLb.text = suggestTitle;
    _suggestTitleLb.font = font;
    _suggestTitleLb.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1];

    _suggestLb = [[UILabel alloc]init];
    font = [UIFont systemFontOfSize: 14 * displayScale];
    attrs = @{NSFontAttributeName : font};
    textSize = [suggestText boundingRectWithSize:CGSizeMake(230 * displayScale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    _suggestLb.frame = CGRectMake(VIEW_X(_lineBreak1), VIEW_Y_Bottom(_suggestTitleLb) + 12 * displayScale, VIEW_WIDTH(_lineBreak1), textSize.height);
    _suggestLb.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:0.5];
    _suggestLb.numberOfLines = 0;
    _suggestLb.font = font;
    _suggestLb.text = suggestText;

    _safeLightView = [[UIScrollView alloc]init];

    // 判断根据字数自适应的大小
    if ( VIEW_HEIGHT(_alertTitleImage) + VIEW_HEIGHT(_suggestTitleLb) + VIEW_HEIGHT(_suggestLb) + VIEW_HEIGHT(_instruteTitleLb) + VIEW_HEIGHT(_instruteTextLb) + 130 * displayScale > [[UIScreen mainScreen] bounds].size.height  - 170 * displayScale ) {

        _safeLightView.frame = CGRectMake(40 * displayScale, 120 * displayScale, SCREEN_WIDTH - 80 * displayScale, [[UIScreen mainScreen] bounds].size.height - 250 * displayScale);
    }else {
        // 超出范围固定大小并开始滑动
        _safeLightView.frame = CGRectMake(40 * displayScale, 120 * displayScale, SCREEN_WIDTH - 80 * displayScale, VIEW_HEIGHT(_alertTitleImage) + VIEW_HEIGHT(_suggestTitleLb) + VIEW_HEIGHT(_suggestLb) + VIEW_HEIGHT(_instruteTitleLb) + VIEW_HEIGHT(_instruteTextLb) + 130 * displayScale);
    }
    _safeLightView.contentSize = CGSizeMake(SCREEN_WIDTH - 80 * displayScale, VIEW_HEIGHT(_alertTitleImage) + VIEW_HEIGHT(_suggestTitleLb) + VIEW_HEIGHT(_suggestLb) + VIEW_HEIGHT(_instruteTitleLb) + VIEW_HEIGHT(_instruteTextLb) + 130 * displayScale);
    _safeLightView.backgroundColor = [UIColor whiteColor];
    _safeLightView.alpha = 0.96;
    _safeLightView.layer.cornerRadius = 8;
    _safeLightView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self addSubview:_safeLightView];
    self.alertView = _safeLightView;

    [_safeLightView addSubview:_alertTitleImage];
    [_safeLightView addSubview:_alertTitle];
    [_safeLightView addSubview:_lineBreak1];
    [_safeLightView addSubview:_instruteTitleLb];
    [_safeLightView addSubview:_instruteTextLb];
    [_safeLightView addSubview:_suggestTitleLb];
    [_safeLightView addSubview:_suggestLb];

    // 底部取消按钮
    UIButton *_cancelBtn = [[UIButton alloc]init];
    _cancelBtn.frame = CGRectMake(VIEW_CENTER_X(self) - 20 * displayScale,VIEW_Y_Bottom(_safeLightView) + 30 * displayScale, 40 * displayScale, 40 * displayScale);
    [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [self addSubview:_cancelBtn];
    self.cancelBtn = _cancelBtn;

}

// 设置安全指示灯
- (void)setSafeLightView: (NSString *)instructText suggest: (NSString *)suggestText title: (NSString *)title instruteTitle: (NSString * ) instruteTitle suggestTitle: (NSString *)suggestTitle titleImage: (NSString *)titleImage{

    _alertTitleImage.frame = CGRectMake(25 * displayScale, 25 * displayScale, 70 * displayScale, 70 * displayScale);
    _alertTitleImage.image = [UIImage imageNamed:titleImage];

    UIFont *font = [UIFont boldSystemFontOfSize: 20 * displayScale];
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(140, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

    _alertTitle.frame = CGRectMake(VIEW_X_Right(_alertTitleImage) + 20 * displayScale, VIEW_CENTER_Y(_alertTitleImage) - textSize.height / 2, 147 * displayScale, textSize.height);
    _alertTitle.text = title;
    _alertTitle.font = font;
    _alertTitle.numberOfLines = 0;
    _alertTitle.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1];

    _lineBreak1.frame = CGRectMake(VIEW_X(_alertTitleImage), VIEW_Y_Bottom(_alertTitleImage) + 10 * displayScale,SCREEN_WIDTH - 130 * displayScale , 1);

    textSize = [instruteTitle boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    _instruteTitleLb.frame = CGRectMake(VIEW_X(_lineBreak1), VIEW_Y_Bottom(_lineBreak1) + 12 * displayScale, VIEW_WIDTH(_lineBreak1), textSize.height);
    _instruteTitleLb.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1];
    _instruteTitleLb.font = font;
    _instruteTitleLb.text = instruteTitle;


    font = [UIFont systemFontOfSize: 14 * displayScale];
    attrs = @{NSFontAttributeName : font};
    textSize = [instructText boundingRectWithSize:CGSizeMake(230 * displayScale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    _instruteTextLb.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:0.5];
    _instruteTextLb.numberOfLines = 0;
    _instruteTextLb.font = font;
    _instruteTextLb.text = instructText;
    _instruteTextLb.frame = CGRectMake(VIEW_X(_lineBreak1), VIEW_Y_Bottom(_instruteTitleLb) + 12 * displayScale, VIEW_WIDTH(_lineBreak1), textSize.height);

    font = [UIFont boldSystemFontOfSize: 16 * displayScale];
    attrs = @{NSFontAttributeName : font};
    textSize = [suggestTitle boundingRectWithSize:CGSizeMake(210, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    _suggestTitleLb.frame = CGRectMake(VIEW_X(_lineBreak1), VIEW_Y_Bottom(_instruteTextLb) + 30 * displayScale, VIEW_WIDTH(_lineBreak1), textSize.height);
    _suggestTitleLb.text = suggestTitle;
    _suggestTitleLb.font = font;
    _suggestTitleLb.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1];

    font = [UIFont systemFontOfSize: 14 * displayScale];
    attrs = @{NSFontAttributeName : font};
    textSize = [suggestText boundingRectWithSize:CGSizeMake(230 * displayScale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    _suggestLb.frame = CGRectMake(VIEW_X(_lineBreak1), VIEW_Y_Bottom(_suggestTitleLb) + 12 * displayScale, VIEW_WIDTH(_lineBreak1), textSize.height);
    _suggestLb.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:0.5];
    _suggestLb.numberOfLines = 0;
    _suggestLb.font = font;
    _suggestLb.text = suggestText;

    if ( VIEW_HEIGHT(_alertTitleImage) + VIEW_HEIGHT(_suggestTitleLb) + VIEW_HEIGHT(_suggestLb) + VIEW_HEIGHT(_instruteTitleLb) + VIEW_HEIGHT(_instruteTextLb) + 130 * displayScale > [[UIScreen mainScreen] bounds].size.height  - 170 * displayScale ) {

        _safeLightView.frame = CGRectMake(40 * displayScale, 120 * displayScale, SCREEN_WIDTH - 80 * displayScale, [[UIScreen mainScreen] bounds].size.height - 250 * displayScale);
    }else {
        _safeLightView.frame = CGRectMake(40 * displayScale, 120 * displayScale, SCREEN_WIDTH - 80 * displayScale, VIEW_HEIGHT(_alertTitleImage) + VIEW_HEIGHT(_suggestTitleLb) + VIEW_HEIGHT(_suggestLb) + VIEW_HEIGHT(_instruteTitleLb) + VIEW_HEIGHT(_instruteTextLb) + 130 * displayScale);
    }
    _safeLightView.contentSize = CGSizeMake(SCREEN_WIDTH - 80 * displayScale, VIEW_HEIGHT(_alertTitleImage) + VIEW_HEIGHT(_suggestTitleLb) + VIEW_HEIGHT(_suggestLb) + VIEW_HEIGHT(_instruteTitleLb) + VIEW_HEIGHT(_instruteTextLb) + 130 * displayScale);

    _safeLightView.backgroundColor = [UIColor whiteColor];
    _safeLightView.layer.cornerRadius = 8;
    _safeLightView.autoresizingMask = UIViewAutoresizingFlexibleHeight;

    self.cancelBtn.frame = CGRectMake(VIEW_CENTER_X(self) - 20 * displayScale,VIEW_Y_Bottom(_safeLightView) + 30 * displayScale, 40 * displayScale, 40 * displayScale);
    [self.cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];

}

- (void)setSafeLightView: (CGRect)frame {
    self.alertView.frame = frame;
}
#pragma -mark 卡券弹窗
- (void)createCardAlert {
    _alertTitle = [[UILabel alloc]init];
    _alertTitle.frame = CGRectMake(0, 12 * displayScale, VIEW_WIDTH(self) - 80 * displayScale, 18 * displayScale);
    _alertTitle.textAlignment = NSTextAlignmentCenter;

    _lineBreak1.frame = CGRectMake(5, VIEW_Y_Bottom(_alertTitle) + 10 * displayScale, VIEW_WIDTH(self) - 100 * displayScale, 1);

    _subtitle = [[UILabel alloc]init];
    _subtitle.frame = CGRectMake(0, VIEW_Y_Bottom(_lineBreak1) + 20 * displayScale, VIEW_WIDTH(self) - 80 * displayScale, 16 * displayScale);
    _subtitle.textAlignment= NSTextAlignmentCenter;

    UIView *msgBackView = [[UIView alloc]init];
    msgBackView.frame = CGRectMake(26 * displayScale, VIEW_Y_Bottom(_subtitle) + 15 * displayScale, VIEW_WIDTH(self) - 132 *displayScale, 60 * displayScale);
    msgBackView.backgroundColor = [UIColor colorWithRed:216.0 / 255 green:216.0 / 255 blue:216.0 / 255 alpha:1];

    _cardNumb = [[UILabel alloc]init];
    _cardNumb.frame = CGRectMake(0, 13 * displayScale, VIEW_WIDTH(msgBackView), 14 * displayScale);
    _cardNumb.textAlignment = NSTextAlignmentCenter;

    _cardPw = [[UILabel alloc]init];
    _cardPw.frame = CGRectMake(0, VIEW_Y_Bottom(_cardNumb) + 6 * displayScale, VIEW_WIDTH(msgBackView), 14 * displayScale);
    _cardPw.textAlignment = NSTextAlignmentCenter;

    [msgBackView addSubview:_cardNumb];
    [msgBackView addSubview:_cardPw];

    _prompt = [[UILabel alloc]init];
    _prompt.frame = CGRectMake(0, VIEW_Y_Bottom(msgBackView) + 5 * displayScale, VIEW_WIDTH(self) - 80 * displayScale, 14 * displayScale);
    _prompt.textAlignment = NSTextAlignmentCenter;

    UIButton *_sureBtn = [[UIButton alloc]init];
    _sureBtn.frame = CGRectMake(28 * displayScale, VIEW_Y_Bottom(_prompt) + 26 * displayScale, 50 * displayScale, 50 * displayScale);
    self.sureBtn = _sureBtn;
    [_sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];

    _btnLabel1 = [[UILabel alloc]init];
    _btnLabel1.frame = CGRectMake(VIEW_X(_sureBtn) - 5 * displayScale, VIEW_Y_Bottom(_sureBtn) + 10 * displayScale, 60 * displayScale, 20 * displayScale);

    UIButton *_middelBtn = [[UIButton alloc]init];
    _middelBtn.frame = CGRectMake(VIEW_CENTER_X(_prompt) - 25 * displayScale, VIEW_Y(_sureBtn), VIEW_WIDTH(_sureBtn), VIEW_HEIGHT(_sureBtn));
    [_middelBtn addTarget:self action:@selector(copyClick:) forControlEvents:UIControlEventTouchUpInside];
    self.middleBtn = _middelBtn;

    _btnLabel2 = [[UILabel alloc]init];
    _btnLabel2.frame = CGRectMake(VIEW_X(_middelBtn) - 10 * displayScale, VIEW_Y(_btnLabel1), VIEW_WIDTH(_btnLabel1) + 15 * displayScale, VIEW_HEIGHT(_btnLabel1));

    UIButton *_otherBtn = [[UIButton alloc]init];
    _otherBtn.frame = CGRectMake(VIEW_WIDTH(self) - 158 * displayScale , VIEW_Y(_sureBtn), VIEW_WIDTH(_sureBtn), VIEW_HEIGHT(_sureBtn));
    self.otherBtn = _otherBtn;
    [_otherBtn addTarget:self action:@selector(otherClick:) forControlEvents:UIControlEventTouchUpInside];

    _btnLabel3 = [[UILabel alloc]init];
    _btnLabel3.frame = CGRectMake(VIEW_X(_otherBtn) - 5 * displayScale, VIEW_Y(_btnLabel1), VIEW_WIDTH(_btnLabel1), VIEW_HEIGHT(_btnLabel1));

    _alertTitleImage = [[UIImageView alloc]init];
    _alertTitleImage.image = [UIImage imageNamed:@"card.png"];


    _msgAlertView = [[UIView alloc]init];
    _msgAlertView.frame = CGRectMake(40 * displayScale, 152 * displayScale, VIEW_WIDTH(self) - 80 * displayScale, 280 * displayScale);
    _alertTitleImage.frame = CGRectMake(0, 0, VIEW_WIDTH(_msgAlertView), VIEW_HEIGHT(_msgAlertView));
    [self addSubview:_msgAlertView];

    [_msgAlertView addSubview:_alertTitleImage];
    [_msgAlertView addSubview:_alertTitle];
    [_msgAlertView addSubview:_lineBreak1];
    [_msgAlertView addSubview:_subtitle];
    [_msgAlertView addSubview:msgBackView];
    [_msgAlertView addSubview:_prompt];
    [_msgAlertView addSubview:_sureBtn];
    [_msgAlertView addSubview:self.middleBtn];
    [_msgAlertView addSubview:self.otherBtn];
    [_msgAlertView addSubview:_btnLabel1];
    [_msgAlertView addSubview:_btnLabel2];
    [_msgAlertView addSubview:_btnLabel3];

    UIButton *_cancelBtn = [[UIButton alloc]init];
    _cancelBtn.frame = CGRectMake(VIEW_CENTER_X(self) - 20 * displayScale, VIEW_Y_Bottom(_msgAlertView) + 30 * displayScale , 40 * displayScale, 40 * displayScale);
    [_cancelBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelBtn];
}

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
         thirdString: (NSString *)thirdString{
    [self createCardAlert];
    _alertTitle.text = title;
    _alertTitle.font = [UIFont systemFontOfSize:18 * displayScale];
    _alertTitle.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1];

    _subtitle.text = subtitle;
    _subtitle.font = [UIFont systemFontOfSize:16 * displayScale];
    _subtitle.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1];

    _cardNumb.text = cardNumb;
    _cardNumb.font = [UIFont systemFontOfSize:14 * displayScale];
    _cardNumb.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1];

    _cardPw.text = cardPw;
    _cardPw.font = [UIFont systemFontOfSize:14 * displayScale];
    _cardPw.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1];

    _prompt.text = prompt;
    _prompt.font = [UIFont systemFontOfSize:12 * displayScale];
    _prompt.textColor = [UIColor colorWithRed:152.0 / 255 green:152.0 / 255 blue:152.0 / 255 alpha:1];

    [self.sureBtn setImage:[UIImage imageNamed:firstImage] forState:UIControlStateNormal];
    [self.middleBtn setImage:[UIImage imageNamed:secondImage] forState:UIControlStateNormal];
    [self.otherBtn setImage:[UIImage imageNamed:thirdImage] forState:UIControlStateNormal];

    _btnLabel1.text = firstString;
    _btnLabel2.text = secondString;
    _btnLabel3.text = thirdString;

    _btnLabel1.font = [UIFont systemFontOfSize:14 * displayScale];
    _btnLabel2.font = _btnLabel1.font;
    _btnLabel3.font = _btnLabel1.font;

    _btnLabel1.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1];
    _btnLabel2.textColor = _btnLabel1.textColor;
    _btnLabel3.textColor = _btnLabel1.textColor;

}

#pragma -mark 顶部弹窗
- (void)setTopAlert: (NSString *)title titleFont: (CGFloat )titleFont{
    UIFont *font = [UIFont systemFontOfSize: titleFont * displayScale];
    _backGroundBtn.backgroundColor = [UIColor clearColor];
    _alertTitle = [[UILabel alloc]init];
    _msgAlertView = [[UIView alloc]init];
    _alertTitle.font = font;
    _alertTitle.text = title;

    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:title];
    _alertTitle.attributedText = attributedString2;
    _alertTitle.numberOfLines = 0;
    _alertTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _alertTitle.textColor = [UIColor whiteColor];
    if ([title length] > 20) {
        _alertTitle.textAlignment = NSTextAlignmentLeft;
    }else {
        _alertTitle.textAlignment = NSTextAlignmentCenter;
    }

    // 根据字数来确定frame的大小
    if ([title length] < 22) {
        _alertTitle.frame = CGRectMake(8 * displayScale, 7 * displayScale, VIEW_WIDTH(self) - 50 * displayScale , 12 * displayScale);
        _msgAlertView.frame = CGRectMake(0, 0, VIEW_WIDTH(self), 26 * displayScale);
    }else if ([title length] > 22 && [title length] < 44) {
        _alertTitle.frame = CGRectMake(8 * displayScale, 7 * displayScale, VIEW_WIDTH(self) - 50 * displayScale , 40 * displayScale);
        _msgAlertView.frame = CGRectMake(0, 0, VIEW_WIDTH(self), 54 * displayScale);
    }else {
        _alertTitle.frame = CGRectMake(8 * displayScale, 7 * displayScale, VIEW_WIDTH(self) - 50 * displayScale , 53 * displayScale);
        _msgAlertView.frame = CGRectMake(0, 0, VIEW_WIDTH(self), 67 * displayScale);
    }
    self.msgLabel = _alertTitle;

    _msgAlertView.backgroundColor = [UIColor blackColor];
    _msgAlertView.alpha = 0.5;
    [_msgAlertView addSubview:_alertTitle];

    UIButton *cancel = [[UIButton alloc]init];
    cancel.frame = CGRectMake(VIEW_WIDTH(self) - 40 * displayScale, VIEW_CENTER_Y(_msgAlertView) - 10 * displayScale, 20 * displayScale, 20 * displayScale);
    [cancel setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [_msgAlertView addSubview:cancel];

    [self addSubview:_msgAlertView];
    self.alertView = _msgAlertView;

}

//将整个点击顶部弹窗变成可以点击 注释掉的部分为设置下划线部分字体可以点击
- (void)setOtherBtnframe: (NSRange )range{
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:_alertTitle.text];

//    NSString *str = [_alertTitle.text substringWithRange:range];

    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];

    [content addAttribute:NSFontAttributeName value:_alertTitle.font range:NSMakeRange(0, _alertTitle.text.length)];
    _alertTitle.attributedText = content;

    UIButton *btn     = [[UIButton alloc]init];
    btn.frame = CGRectMake(0, 0, VIEW_WIDTH(self)- 40 * displayScale, VIEW_HEIGHT(_msgAlertView));
//    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(otherClick:) forControlEvents:UIControlEventTouchUpInside];
    [_msgAlertView addSubview:btn];

//    [_alertTitle yb_addAttributeTapActionWithStrings:@[str] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
//        NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),index];
//        NSLog(@"%@",message);
//        if ([self.delegate respondsToSelector:@selector(otherBtnDidClick:)]) {
//            [self.delegate otherBtnDidClick:self];
//        }
//    }];

//    _alertTitle.enabledTapEffect = NO;


}

// 设置顶部弹窗的高度
- (void)tTopAlertHight: (CGFloat)height{
     _msgAlertView.frame = CGRectMake(0, height *displayScale, VIEW_WIDTH(_msgAlertView), VIEW_HEIGHT(_msgAlertView));
}

#pragma -mark actionsheetAlert
// actionsheet
- (void)setActionSheetAlert {
    UIView *actionSheet = [[UIView alloc]init];
    actionSheet.frame = CGRectMake(0, VIEW_Y_Bottom(self) - 136 * displayScale, VIEW_WIDTH(self), 136 * displayScale);
    actionSheet.backgroundColor = [UIColor whiteColor];

    UIButton *_sureBtn = [[UIButton alloc]init];
    _sureBtn.frame = CGRectMake(0, 0, VIEW_WIDTH(self), 44 * displayScale);
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:18 * displayScale];
    [actionSheet addSubview:_sureBtn];
    self.sureBtn = _sureBtn;

    UIButton *_middleBtn = [[UIButton alloc]init];
    _middleBtn.frame = CGRectMake(0, VIEW_Y_Bottom(_sureBtn), VIEW_WIDTH(_sureBtn), 44 * displayScale);
    [actionSheet addSubview:_middleBtn];
    self.middleBtn = _middleBtn;

    UIButton *_cancelBtn = [[UIButton alloc]init];
    _cancelBtn.frame = CGRectMake(0, VIEW_Y_Bottom(_middleBtn), VIEW_WIDTH(_sureBtn), 44 * displayScale);
    [actionSheet addSubview:_cancelBtn];
    self.cancelBtn = _cancelBtn;

    _lineBreak1.frame = CGRectMake(0, VIEW_Y_Bottom(_sureBtn), VIEW_WIDTH(self), 1);
    [actionSheet addSubview:_lineBreak1];

    UIView *lineBreak2 = [[UIView alloc]init];
    lineBreak2.frame = CGRectMake(0, VIEW_Y_Bottom(_middleBtn), VIEW_WIDTH(self), 1);
    lineBreak2.backgroundColor = _lineBreak1.backgroundColor;
    [actionSheet addSubview:lineBreak2];

    [self addSubview:actionSheet];
    self.alertView = actionSheet;

}

#pragma -mark 基本弹窗文字可点击
// 创建弹窗
- (void)createMsgClickAlertView {
    UIView *_alertView = [[UIView alloc]init];
    _alertView.frame = CGRectMake(40 * displayScale, 200 * displayScale, VIEW_WIDTH(self)  - 80 *displayScale, 177 * displayScale);
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.alpha = 0.96;
    _alertView.layer.cornerRadius = 8;
    [self addSubview:_alertView];
    self.alertView = _alertView;

    _alertTitle = [[UILabel alloc]init];
    _alertTitle.frame = CGRectMake(19 * displayScale, 24 * displayScale, VIEW_WIDTH(_alertView) - 38 * displayScale, 18 * displayScale);
    _alertTitle.numberOfLines = 0;
    _alertTitle.lineBreakMode = NSLineBreakByClipping;
    _alertTitle.textAlignment = NSTextAlignmentCenter;
    _alertTitle.textColor     = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
    _alertTitle.font          = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [_alertView addSubview:_alertTitle];

    UILabel *msgLable = [[UILabel alloc]init];
    msgLable.frame = CGRectMake(19 * displayScale, VIEW_Y_Bottom(_alertTitle) + 16 * displayScale, VIEW_WIDTH(_alertView) - 38 * displayScale, 40 * displayScale);
    msgLable.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
    msgLable.textAlignment = NSTextAlignmentCenter;
    msgLable.numberOfLines = 0;
    [_alertView addSubview:msgLable];

    self.msgLabel = msgLable;

    UIButton *msgBtn = [[UIButton alloc]init];
    msgBtn.frame = msgLable.frame;
    [msgBtn addTarget:self action:@selector(otherClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:msgBtn];
    // 取消、确定按钮
    UIButton *cancelBtn   = [[UIButton alloc]init];

    cancelBtn.frame   = CGRectMake(0, VIEW_Y_Bottom(msgLable) + 27 * displayScale, VIEW_WIDTH(_alertView), 50 * displayScale);

    [cancelBtn setTitleColor:[UIColor colorWithRed:11/255.0 green:171/255.0 blue:254/255.0 alpha:1.0] forState:UIControlStateNormal];

    cancelBtn.titleLabel.font   = [UIFont boldSystemFontOfSize:18 * displayScale];

    [cancelBtn setTitle:@"知道了" forState:UIControlStateNormal];

    [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];

    [_alertView addSubview:cancelBtn];

    self.cancelBtn = cancelBtn;

    // 分割线

    _lineBreak1.frame = CGRectMake(VIEW_X(cancelBtn), VIEW_Y(cancelBtn), VIEW_WIDTH(_alertView), 1);

    [_alertView addSubview:_lineBreak1];


}

// 弹窗文字可点击
- (void)setMsgClickAlertTitle: (NSString *)alertTitle titleFont:(NSInteger) titleFont msg:(NSString *)msg msgFont: (NSInteger) msgFont  clickMsgRange: (NSRange )range clickMsgFont: (NSInteger)clickMsgFont{
    [self createMsgClickAlertView];

    [_alertTitle setFont: [UIFont fontWithName:@"PingFangSC-Medium" size: titleFont * displayScale]];
    _alertTitle.text = alertTitle;
    self.msgLabel.font = [UIFont systemFontOfSize:msgFont * displayScale];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:msg];

    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:clickMsgFont * displayScale] range:range];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:11/255.0 green:171/255.0 blue:254/255.0 alpha:1/1.0] range:range];
    self.msgLabel.attributedText = text;

    if ([alertTitle length] > 15) {
        _alertTitle.textAlignment = NSTextAlignmentLeft;
        _alertView.frame = CGRectMake(40 * displayScale, 200 * displayScale, VIEW_WIDTH(self)  - 80 *displayScale, 199 * displayScale);
        _alertTitle.frame = CGRectMake(19 * displayScale, 24 * displayScale, VIEW_WIDTH(_alertView) - 38 * displayScale, 40 * displayScale);
    }else {
        _alertTitle.textAlignment = NSTextAlignmentCenter;
    }

    if ([msg length] > 15) {
        self.msgLabel.textAlignment = NSTextAlignmentLeft;

    }else {
        self.msgLabel.textAlignment = NSTextAlignmentCenter;
    }


}

- (void)setMsgClickAlertTitleFrame : (CGRect)frame {
    self.alertView.frame = frame;
}

#pragma -mark action （外部回调协议，也可以直接设置按钮的点击事件，不做回调）
// 点击背景隐藏
- (void)hiddenClick: (UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(hiddenClick:)]) {
        [self.delegate hiddenClick:self];
    }

}

// 弹窗点击确定
- (void)sureClick: (UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sureDidClick:)]) {
        [self.delegate sureDidClick:self];
    }

}

// 另外点击事件
- (void)otherClick: (UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(otherBtnDidClick:)]) {
        [self.delegate otherBtnDidClick:self];
    }
}

- (void)copyClick: (UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(copyDidClick:)]) {
        [self.delegate copyDidClick:self];
    }
}

- (void)cancelClick : (UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cancelBtnDidClick:)]) {
        [self.delegate cancelBtnDidClick:self];
    }
}

#pragma -mark 判断label文字行数
- (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label{
    NSString *text = [label text];
    UIFont *font = [label font];
    CGRect rect = [label frame];

    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));

        [linesArray addObject:lineString];
    }

    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}

#pragma -mark 判断文字是否存在字母
-(BOOL)isABC:(NSString *)str{

    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];

    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];

    if(tLetterMatchCount>=1){
        return YES;
    }else{
        return NO;
    }

}
@end

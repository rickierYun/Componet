//
//  FYXAlertView.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/9.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "FYXAlertView.h"
#import "UILabel+YBAttributeTextTapAction.h"

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
    UITextView  * _richTextView;       // 富文本显示框
    UIImageView * _alertTitleImage;    // 提示图片
    UIView      * _lineBreak1;         // 分割线
    NSString    * _text;               // 文字载体
    UIView      * _safeLightView;      // 安全提示灯
    UILabel     * _btnLabel1;
    UILabel     * _btnLabel2;
    UILabel     * _btnLabel3;
    UILabel     * _prompt;
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
    [_backGroundBtn setBackgroundColor:[UIColor colorWithDisplayP3Red:0 green:0 blue:0 alpha:0.3]];
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
    _alertView.layer.cornerRadius = 8;
    [self addSubview:_alertView];
    self.alertView = _alertView;

    _alertTitle = [[UILabel alloc]init];
    _alertTitle.frame = CGRectMake(0, 5, VIEW_WIDTH(_alertView), VIEW_HEIGHT(_alertView) * 2 / 3);
    _alertTitle.numberOfLines = 2;
    _alertTitle.lineBreakMode = NSLineBreakByCharWrapping;
    _alertTitle.textAlignment = NSTextAlignmentCenter;
    _alertTitle.textColor     = [UIColor blackColor];
    [_alertView addSubview:_alertTitle];

    // 取消、确定按钮
    UIButton *_sureBtn   = [[UIButton alloc]init];
    UIButton *_cancelBtn = [[UIButton alloc]init];

    _sureBtn.frame   = CGRectMake(VIEW_WIDTH(_alertView) / 2, VIEW_HEIGHT(_alertTitle), VIEW_WIDTH(_alertView) / 2, VIEW_HEIGHT(_alertView) * 1 / 3);
    _cancelBtn.frame = CGRectMake(0,VIEW_HEIGHT(_alertTitle), VIEW_WIDTH(_alertView) / 2, VIEW_HEIGHT(_alertView) * 1 / 3);

    _sureBtn.titleLabel.font   = [UIFont systemFontOfSize:17 * displayScale];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17 * displayScale];

    [_sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];

    [_alertView addSubview:_sureBtn];
    [_alertView addSubview:_cancelBtn];
    self.sureBtn = _sureBtn;
    self.cancelBtn = _cancelBtn;

    // 分割线

    UIView *lineBreak2 = [[UIView alloc]init];

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
}

- (void)setAlertTitleFrame : (CGRect)frame {
    self.alertView.frame = frame;
}
#pragma -mark 文字弹窗
- (void)createMsgAlert {
    _msgAlertView = [[UIView alloc]init];

    _msgAlertView.frame = CGRectMake(VIEW_CENTER_X(self) - 100 * displayScale,
                                     160 * displayScale,
                                     200 * displayScale,
                                     300 * displayScale);
    _msgAlertView.layer.cornerRadius = 8;
    _msgAlertView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_msgAlertView];

    _alertTitle = [[UILabel alloc]init];
    _alertTitle.frame = CGRectMake(0, 5, VIEW_WIDTH(_msgAlertView), 23 * displayScale);
    _alertTitle.numberOfLines = 1;
    _alertTitle.textAlignment = NSTextAlignmentCenter;
    _alertTitle.textColor     = [UIColor blackColor];
    [_msgAlertView addSubview:_alertTitle];

    _richTextView = [[UITextView alloc]init];
    _richTextView.frame = CGRectMake(8 * displayScale,
                                 VIEW_Y_Bottom(_alertTitle) + 5 * displayScale,
                                 VIEW_WIDTH(_msgAlertView) - 16 * displayScale,
                                 VIEW_HEIGHT(_msgAlertView) - VIEW_HEIGHT(_alertTitle) - 40 * displayScale);
     
//    _richTextView.numberOfLines = 0;
//    _richTextView.lineBreakMode = NSLineBreakByCharWrapping;
    _richTextView.textAlignment = NSTextAlignmentLeft;
    _richTextView.textColor     = [UIColor blackColor];
    [_msgAlertView addSubview:_richTextView];

    UIButton *_cancelBtn = [[UIButton alloc]init];
    _cancelBtn.frame = CGRectMake(0,
                                  VIEW_HEIGHT(_alertTitle) + VIEW_Y(_alertTitle) + VIEW_HEIGHT(_richTextView),
                                  VIEW_WIDTH(_msgAlertView),
                                  35 * displayScale);

    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17 * displayScale];
    [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [_msgAlertView addSubview:_cancelBtn];
    self.cancelBtn = _cancelBtn;
    // 分割线

}

// 设置弹窗内容
- (void)setMsgAlertView: (NSString *)alertTitle titleFont:(NSInteger) titleFont alertMsg:(NSString *)msg msgFont:(NSInteger)msgFont  msgColor: (UIColor *)msgColor{
    [self createMsgAlert];
    _alertTitle.text = alertTitle;
    _richTextView.text   = msg;
    _richTextView.textColor = msgColor;
    [_alertTitle setFont:[UIFont systemFontOfSize:titleFont * displayScale]];
    [_richTextView setFont:[UIFont systemFontOfSize:msgFont * displayScale]];

}

// 设置文本弹窗的高度
- (void)setMsgAlertFrame: (NSInteger)alertHeight AlertWidth:(NSInteger)alertWidth {
    _msgAlertView.frame = CGRectMake(VIEW_CENTER_X(self) - alertWidth / 2 * displayScale,
                                     160 * displayScale,
                                     alertWidth * displayScale,
                                     alertHeight * displayScale);

    _alertTitle.frame   = CGRectMake(0, 12, VIEW_WIDTH(_msgAlertView), 23 * displayScale);

    _richTextView.frame     = CGRectMake(13 * displayScale,
                                     VIEW_HEIGHT(_alertTitle) + VIEW_Y(_alertTitle) + 5 * displayScale,
                                     VIEW_WIDTH(_msgAlertView) - 26 * displayScale,
                                     VIEW_HEIGHT(_msgAlertView) - VIEW_HEIGHT(_alertTitle) - 60 * displayScale);

    _cancelBtn.frame    = CGRectMake(0,
                                     VIEW_HEIGHT(_alertTitle) + VIEW_Y(_alertTitle) + VIEW_HEIGHT(_richTextView) + 12 * displayScale,
                                     VIEW_WIDTH(_msgAlertView),
                                     30 * displayScale);

    _lineBreak1.frame   = CGRectMake(8 * displayScale, VIEW_Y(_cancelBtn), VIEW_WIDTH(_cancelBtn) - 16, 1);

    [_msgAlertView addSubview:_lineBreak1];
}


#pragma -mark 富文本显示框
- (void)createRichTextAlertView {
    _richTextView = [[UITextView alloc]init];
    _richTextView.frame = CGRectMake(VIEW_CENTER_X(self) - 100 * displayScale, 160 * displayScale, 200 * displayScale, 300 * displayScale);
    _richTextView.textColor = [UIColor blackColor];
    _richTextView.textAlignment = NSTextAlignmentLeft;
    _richTextView.backgroundColor = [UIColor whiteColor];
    _richTextView.layer.cornerRadius = 8;

    [self addSubview:_richTextView];

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
                                  VIEW_HEIGHT(_msgLabel) + 20 * displayScale + VIEW_Y(_msgLabel),
                                  VIEW_WIDTH(_alertView),
                                  40 * displayScale);
    [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"sure" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_alertView addSubview:_cancelBtn];
    self.cancelBtn = _cancelBtn;
    // 分割线
    _lineBreak1.frame = CGRectMake(8 * displayScale, VIEW_Y(_cancelBtn), VIEW_WIDTH(_cancelBtn) - 16, 1);
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

}
// 设置图片弹窗大小
- (void)setImageAlertViewFrame: (CGRect)frame {
    self.alertView.frame = frame;
}

# pragma -mark 三个按钮弹窗
// 三个按钮弹窗
- (void)creatMoreBtnAlertView {
    UIView *_alertView = [[UIView alloc]init];
    _alertView.frame = CGRectMake(55 * displayScale, 160 * displayScale, VIEW_WIDTH(self) - 110 * displayScale, 200 * displayScale);
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = 8;
    [self addSubview:_alertView];
    self.alertView = _alertView;

    UILabel *_msgLabel = [[UILabel alloc]init];
    _msgLabel.frame = CGRectMake(15 , 18 * displayScale, VIEW_WIDTH(_alertView) - 30, 72 * displayScale);
    _msgLabel.textAlignment = NSTextAlignmentLeft;
    _msgLabel.textColor     = [UIColor blackColor];
    _msgLabel.numberOfLines = 0;
    [_alertView addSubview:_msgLabel];
    self.msgLabel = _msgLabel;

    UIButton *_sureBtn = [[UIButton alloc]init];
    _sureBtn.frame = CGRectMake(0, VIEW_Y(_msgLabel) + VIEW_HEIGHT(_msgLabel) + 8, VIEW_WIDTH(_alertView), 35 * displayScale);
    [_sureBtn setTitle:@"sure" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor colorWithRed:0 green:122.0 / 255 blue:255.0 / 255 alpha:1] forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_sureBtn];
    self.sureBtn = _sureBtn;

    UIButton *_middleBtn = [[UIButton alloc]init];
    _middleBtn.frame = CGRectMake(0, VIEW_Y(_sureBtn) + VIEW_HEIGHT(_sureBtn), VIEW_WIDTH(_sureBtn), VIEW_HEIGHT(_sureBtn));
    [_middleBtn setTitle:@"NO,select Other" forState:UIControlStateNormal];
    [_middleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_middleBtn addTarget:self action:@selector(otherClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_middleBtn];
    self.middleBtn = _middleBtn;

    UIButton *_cancelBtn =  [[UIButton alloc]init];
    _cancelBtn.frame = CGRectMake(0, VIEW_Y(_middleBtn) + VIEW_HEIGHT(_middleBtn), VIEW_WIDTH(_sureBtn), VIEW_HEIGHT(_sureBtn));
    [_cancelBtn setTitle:@"think more" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
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

    UIFont *font = [UIFont systemFontOfSize: textFont * displayScale];
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;                    // 随字数，字体扩展大小

    _alertTitle.text = _text;
    _alertTitle.font = font;
    _alertTitle.textColor = textColor;
    _alertTitle.frame = CGRectMake(8, 18, textSize.width, textSize.height);
    _alertTitle.textAlignment = NSTextAlignmentCenter;

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
- (void)createSafeLightView: (NSString *)instructText suggest: (NSString *)suggestText title: (NSString *)title instruteTitle: (NSString * ) instruteTitle suggestTitle: (NSString *)suggestTitle{

    _alertTitleImage = [[UIImageView alloc]init];
    _alertTitleImage.frame = CGRectMake(25 * displayScale, 25 * displayScale, 70 * displayScale, 70 * displayScale);

    UIFont *font = [UIFont boldSystemFontOfSize: 18 * displayScale];
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

    _alertTitle = [[UILabel alloc]init];
    _alertTitle.frame = CGRectMake(VIEW_X_Right(_alertTitleImage) + 20 * displayScale, VIEW_CENTER_Y(_alertTitleImage) - textSize.height / 2, 147 * displayScale, textSize.height);
    _alertTitle.text = title;
    _alertTitle.font = font;
    _alertTitle.numberOfLines = 0;
    _alertTitle.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1];

    _lineBreak1.frame = CGRectMake(VIEW_X(_alertTitleImage), VIEW_Y_Bottom(_alertTitleImage) + 10 * displayScale, VIEW_WIDTH(_alertTitleImage) + VIEW_WIDTH(_alertTitle) + 20 * displayScale, 1);

    UILabel *instruteTitleLb = [[UILabel alloc]init];
    textSize = [instruteTitle boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    instruteTitleLb.frame = CGRectMake(VIEW_X(_lineBreak1), VIEW_Y_Bottom(_lineBreak1) + 12 * displayScale, VIEW_WIDTH(_lineBreak1), textSize.height);
    instruteTitleLb.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1];
    instruteTitleLb.font = font;
    instruteTitleLb.text = instruteTitle;

    UILabel *instruteTextLb = [[UILabel alloc]init];
    font = [UIFont systemFontOfSize: 14 * displayScale];
    attrs = @{NSFontAttributeName : font};
    textSize = [instructText boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    instruteTextLb.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:0.5];
    instruteTextLb.numberOfLines = 0;
    instruteTextLb.font = font;
    instruteTextLb.text = instructText;
    instruteTextLb.frame = CGRectMake(VIEW_X(_lineBreak1), VIEW_Y_Bottom(instruteTitleLb) + 12 * displayScale, VIEW_WIDTH(_lineBreak1), textSize.height);

    UILabel *suggestTitleLb = [[UILabel alloc]init];
    font = [UIFont boldSystemFontOfSize: 16 * displayScale];
    attrs = @{NSFontAttributeName : font};
    textSize = [suggestTitle boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    suggestTitleLb.frame = CGRectMake(VIEW_X(_lineBreak1), VIEW_Y_Bottom(instruteTextLb) + 30 * displayScale, VIEW_WIDTH(_lineBreak1), textSize.height);
    suggestTitleLb.text = suggestTitle;
    suggestTitleLb.font = font;
    suggestTitleLb.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1];

    UILabel *suggestLb = [[UILabel alloc]init];
    font = [UIFont systemFontOfSize: 14 * displayScale];
    attrs = @{NSFontAttributeName : font};
    textSize = [suggestText boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    suggestLb.frame = CGRectMake(VIEW_X(_lineBreak1), VIEW_Y_Bottom(suggestTitleLb) + 12 * displayScale, VIEW_WIDTH(_lineBreak1), textSize.height);
    suggestLb.textColor = [UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:0.5];
    suggestLb.numberOfLines = 0;
    suggestLb.font = font;
    suggestLb.text = suggestText;

    _safeLightView = [[UIView alloc]init];
    _safeLightView.frame = CGRectMake(40 * displayScale, 120 * displayScale, SCREEN_WIDTH - 80 * displayScale, VIEW_HEIGHT(_alertTitleImage) + VIEW_HEIGHT(suggestTitleLb) + VIEW_HEIGHT(suggestLb) + VIEW_HEIGHT(instruteTitleLb) + VIEW_HEIGHT(instruteTextLb) + 130 * displayScale);
    _safeLightView.backgroundColor = [UIColor whiteColor];
    _safeLightView.layer.cornerRadius = 8;
    _safeLightView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self addSubview:_safeLightView];
    self.alertView = _safeLightView;

    [_safeLightView addSubview:_alertTitleImage];
    [_safeLightView addSubview:_alertTitle];
    [_safeLightView addSubview:_lineBreak1];
    [_safeLightView addSubview:instruteTitleLb];
    [_safeLightView addSubview:instruteTextLb];
    [_safeLightView addSubview:suggestTitleLb];
    [_safeLightView addSubview:suggestLb];

    UIButton *_cancelBtn = [[UIButton alloc]init];
    _cancelBtn.frame = CGRectMake(VIEW_CENTER_X(self) - 10 * displayScale,VIEW_Y_Bottom(_safeLightView) + 30 * displayScale, 40 * displayScale, 40 * displayScale);
    [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [self addSubview:_cancelBtn];
    self.cancelBtn = _cancelBtn;

}

- (void)setSafeLightView: (NSString *)instructText suggest: (NSString *)suggestText title: (NSString *)title instruteTitle: (NSString * ) instruteTitle suggestTitle: (NSString *)suggestTitle titleImage: (NSString *)titleImage{
    [self createSafeLightView:instructText suggest:suggestText title:title instruteTitle:instruteTitle suggestTitle:suggestTitle];
    _alertTitleImage.image = [UIImage imageNamed:titleImage];
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
    msgBackView.frame = CGRectMake(26 * displayScale, VIEW_Y_Bottom(_subtitle) + 15 * displayScale, VIEW_WIDTH(self) - 122 *displayScale, 60 * displayScale);
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

- (void)setTopAlert: (NSString *)title titleFont: (CGFloat )titleFont{
    _backGroundBtn.backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont boldSystemFontOfSize: titleFont * displayScale];
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(120, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    _alertTitle = [[UILabel alloc]init];
    NSLog(@"%f",textSize.width);
    NSLog(@"%f",VIEW_WIDTH(self) - 50 * displayScale);
    _alertTitle.frame = CGRectMake(8 * displayScale, 5 * displayScale, VIEW_WIDTH(self) - 50 * displayScale , textSize.height);
    _alertTitle.text = title;
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:title];
    _alertTitle.attributedText = attributedString2;
    _alertTitle.numberOfLines = 0;

    _alertTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _alertTitle.textColor = [UIColor whiteColor];
    self.msgLabel = _alertTitle;

    _msgAlertView = [[UIView alloc]init];
    _msgAlertView.frame = CGRectMake(0, 0, VIEW_WIDTH(self), textSize.height + 10 * displayScale);
    _msgAlertView.backgroundColor = [UIColor blackColor];
    _msgAlertView.alpha = 0.4;
    [_msgAlertView addSubview:_alertTitle];

    UIButton *cancel = [[UIButton alloc]init];
    cancel.frame = CGRectMake(VIEW_WIDTH(self) - 40 * displayScale, VIEW_CENTER_Y(_alertTitle) - 10 * displayScale, 20 * displayScale, 20 * displayScale);
    [cancel setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [_msgAlertView addSubview:cancel];

    [self addSubview:_msgAlertView];
}

- (void)setOtherBtnframe: (NSRange )range{
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:_alertTitle.text];

    NSString *str = [_alertTitle.text substringWithRange:range];
    NSRange contentRange = range;
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];

    [content addAttribute:NSFontAttributeName value:_alertTitle.font range:NSMakeRange(0, content.length)];
    [_alertTitle yb_addAttributeTapActionWithStrings:@[str] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),index];
        NSLog(@"%@",message);
        if ([self.delegate respondsToSelector:@selector(otherBtnDidClick:)]) {
            [self.delegate otherBtnDidClick:self];
        }
    }];
    _alertTitle.attributedText = content;
    _alertTitle.enabledTapEffect = NO;

}

- (void)tTopAlertHight: (CGFloat)height{
     _msgAlertView.frame = CGRectMake(0, height *displayScale, VIEW_WIDTH(_msgAlertView), VIEW_HEIGHT(_msgAlertView));
}

#pragma -mark action
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
@end

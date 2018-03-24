//
//  ViewController.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/9.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "ViewController.h"
#import "FYXAlertView.h"
#import "FYXToast.h"
#import "FYXButton.h"
#import "FYXTextField.h"
#import "FYXSideMenu.h"
#import "CalendarViewController.h"
#import "PageFlowViewController.h"
#import "CheckAnimationViewController.h"
#import "HUdViewController.h"
#import "UIView+GlowView.h"
#import "VinViewController.h"
#import <EventKit/EventKit.h>

@interface ViewController ()<FYXAlertViewDelegate>
{
    FYXAlertView *alertView;
    FYXAlertView *alertMsgView;
    FYXAlertView *alertRichView;
    FYXAlertView *alertImageView;
    FYXAlertView *alertMoreBtnView;
    FYXAlertView *bubbleView;
    FYXAlertView *safelightView;
    FYXAlertView *cardAlerView;
    FYXAlertView *topAlertView;
    FYXSideMenu  *sideMenu;
    UIView       *lightView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *alertBtn = [[UIButton alloc]init];
    alertBtn.frame = CGRectMake(0, 100, 100, 30);
    [alertBtn setTitle:@"普通弹窗" forState:UIControlStateNormal];
    [alertBtn addTarget:self action:@selector(alertClick:) forControlEvents:UIControlEventTouchUpInside];
    [alertBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:alertBtn];

    UIButton *alertMsgBtn = [[UIButton alloc]init];
    alertMsgBtn.frame = CGRectMake(0, 150, 100, 30);
    [alertMsgBtn setTitle:@"文字弹窗" forState:UIControlStateNormal];
    [alertMsgBtn addTarget:self action:@selector(alertMsgClick:) forControlEvents:UIControlEventTouchUpInside];
    [alertMsgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:alertMsgBtn];

    UIButton *alertRichBtn = [[UIButton alloc]init];
    alertRichBtn.frame = CGRectMake(0, 200, 100, 30);
    [alertRichBtn setTitle:@"富文本弹窗" forState:UIControlStateNormal];
    [alertRichBtn addTarget:self action:@selector(alertRichClick:) forControlEvents:UIControlEventTouchUpInside];
    [alertRichBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:alertRichBtn];

    UIButton *alertImageBtn = [[UIButton alloc]init];
    alertImageBtn.frame = CGRectMake(0, 250, 100, 30);
    [alertImageBtn setTitle:@"图片弹窗" forState:UIControlStateNormal];
    [alertImageBtn addTarget:self action:@selector(alertImageClick:) forControlEvents:UIControlEventTouchUpInside];
    [alertImageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:alertImageBtn];

    UIButton *alertMoreBtn = [[UIButton alloc]init];
    alertMoreBtn.frame = CGRectMake(0, 300, 100, 30);
    [alertMoreBtn setTitle:@"多按钮弹窗" forState:UIControlStateNormal];
    [alertMoreBtn addTarget:self action:@selector(alertMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [alertMoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:alertMoreBtn];

    FYXButton *alertImage2Btn = [[FYXButton alloc]initWithFrame:CGRectMake(0, 450, 100, 30)];
    alertImage2Btn.layer.shadowOffset  = CGSizeMake(1, 7);
    alertImage2Btn.layer.shadowOpacity = 0.4;
    alertImage2Btn.layer.shadowColor   = [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f].CGColor;
    [alertImage2Btn setTitle:@"警告弹窗" forState:UIControlStateNormal];
    [alertImage2Btn addTarget:self action:@selector(alertImage2Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertImage2Btn];

    FYXButton *toastBtn = [[FYXButton alloc]initWithFrame:CGRectMake(0, 350, 100, 30)];
    toastBtn.layer.shadowOffset  = CGSizeMake(1, 7);
    toastBtn.layer.shadowOpacity = 0.4;
    toastBtn.layer.shadowColor   = [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f].CGColor;
    [toastBtn setTitle:@"toast弹窗" forState:UIControlStateNormal];
    [toastBtn addTarget:self action:@selector(toastBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toastBtn];

    FYXButton *toastPicBtn = [[FYXButton alloc]initWithFrame:CGRectMake(0, 550, 150, 30)];
    toastPicBtn.layer.shadowOffset  = CGSizeMake(1, 7);
    toastPicBtn.layer.shadowOpacity = 0.4;
    toastPicBtn.layer.shadowColor   = [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f].CGColor;
    [toastPicBtn setTitle:@"带图片toast弹窗" forState:UIControlStateNormal];
    [toastPicBtn addTarget:self action:@selector(toastPicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toastPicBtn];

    FYXButton *alertMsgBtn2 = [[FYXButton alloc]initWithFrame:CGRectMake(0, 500, 150, 30)];
    alertMsgBtn2.layer.shadowOffset  = CGSizeMake(1, 7);
    alertMsgBtn2.layer.shadowOpacity = 0.4;
    alertMsgBtn2.layer.shadowColor   = [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f].CGColor;
    [alertMsgBtn2 setTitle:@"多字体颜色弹窗" forState:UIControlStateNormal];
    [alertMsgBtn2 addTarget:self action:@selector(alertMsg2Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertMsgBtn2];

    FYXButton *cardBtn = [[FYXButton alloc]initWithFrame:CGRectMake(0, 600, 150, 30)];
    cardBtn.layer.shadowOffset  = CGSizeMake(1, 7);
    cardBtn.layer.shadowOpacity = 0.4;
    cardBtn.layer.shadowColor   = [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f].CGColor;
    [cardBtn setTitle:@"优惠券" forState:UIControlStateNormal];
    [cardBtn addTarget:self action:@selector(cardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cardBtn];

    FYXButton *calendarBtn = [[FYXButton alloc]initWithFrame:CGRectMake(0, 400, 100, 30)];
    calendarBtn.layer.shadowOffset  = CGSizeMake(1, 7);
    calendarBtn.layer.shadowOpacity = 0.4;
    calendarBtn.layer.shadowColor   = [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f].CGColor;
    [calendarBtn setTitle:@"日历" forState:UIControlStateNormal];
    [calendarBtn addTarget:self action:@selector(calendarClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:calendarBtn];

    FYXButton *pageFlowButton = [[FYXButton alloc]initWithFrame:CGRectMake(200, 200, 100, 30)];
    [pageFlowButton setTitle:@"卡片" forState:UIControlStateNormal];
    [pageFlowButton addTarget:self action:@selector(pageFlowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pageFlowButton];

    FYXButton *checkAnimationBtn = [[FYXButton alloc]initWithFrame:CGRectMake(200, 300, 100, 30)];
    [checkAnimationBtn setTitle:@"对勾" forState:UIControlStateNormal];
    [checkAnimationBtn addTarget:self action:@selector(checkAnimationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkAnimationBtn];

    FYXButton *HudBtn = [[FYXButton alloc]initWithFrame:CGRectMake(200, 400, 100, 30)];
    [HudBtn setTitle:@"Hud" forState:UIControlStateNormal];
    [HudBtn addTarget:self action:@selector(hudBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:HudBtn];

    FYXButton *bubble = [[FYXButton alloc]initWithFrame:CGRectMake(200, 450, 100, 30)];
    [bubble setTitle:@"气泡" forState:UIControlStateNormal];
    [bubble addTarget:self action:@selector(bubbleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bubble];

    FYXButton *safeLightBtn = [[FYXButton alloc]initWithFrame:CGRectMake(200, 500, 100, 30)];
    [safeLightBtn setTitle:@"故障灯" forState:UIControlStateNormal];
    [safeLightBtn addTarget:self action:@selector(safeLightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:safeLightBtn];

    FYXTextField *textField = [[FYXTextField alloc]initWithFrame:CGRectMake(200, 100, 100, 30)];
    [textField setPlaceholder:@"请登录"];
    [self.view addSubview:textField];

    FYXButton *vinBtn = [[FYXButton alloc]initWithFrame:CGRectMake(200, 600, 100, 30)];
    [vinBtn setTitle:@"车架号" forState:UIControlStateNormal];
    [vinBtn addTarget:self action:@selector(vinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:vinBtn];

    FYXButton *topBtn = [[FYXButton alloc]initWithFrame:CGRectMake(200, 650, 100, 30)];
    [topBtn setTitle:@"上部弹窗" forState:UIControlStateNormal];
    [topBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topBtn];

    cardAlerView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    cardAlerView.delegate = self;
    [self.view addSubview:cardAlerView];
    cardAlerView.hidden = YES;

    alertView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:alertView];
    alertView.delegate = self;
    alertView.hidden = YES;

    alertMsgView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:alertMsgView];
    alertMsgView.delegate = self;
    alertMsgView.hidden = YES;

    alertRichView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:alertRichView];
    alertRichView.delegate = self;
    alertRichView.hidden = YES;

    alertImageView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:alertImageView];
    alertImageView.hidden = YES;

    alertMoreBtnView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:alertMoreBtnView];
    alertMoreBtnView.hidden = YES;

    topAlertView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:topAlertView];
    topAlertView.hidden = YES;
    topAlertView.delegate = self;

    bubbleView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    bubbleView.hidden = YES;
    [self.view addSubview:bubbleView];

    safelightView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:safelightView];
    safelightView.hidden = YES;


    lightView = [[UIView alloc]init];
    lightView.frame = CGRectMake(0, 44, 24, 48);
    lightView.layer.shouldRasterize = YES;
    lightView.layer.shadowOpacity = 0.5;
    lightView.layer.shadowOffset = CGSizeMake(0, 0);
    lightView.layer.shadowColor = [UIColor whiteColor].CGColor;
    lightView.hidden = NO;

    [self.view addSubview:lightView];

    UIButton *lightBackgroundView = [[UIButton alloc]init];
    lightBackgroundView.frame = CGRectMake(0, 0,24, 49);
    [lightBackgroundView setImage:[UIImage imageNamed:@"lightView.png"] forState:UIControlStateNormal];
    [lightBackgroundView addTarget:self action:@selector(sideMenuClick:) forControlEvents:UIControlEventTouchUpInside];
    [lightView addSubview:lightBackgroundView];

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"light.png"];
    imageView.frame = CGRectMake(8, 14, 20, 20);
    imageView.glowRadius = @(10.0f);
    imageView.glowOpacity = @(0.5f);
    imageView.glowColor = [UIColor  colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1];

    imageView.glowDuration = @1.0;
    imageView.hideDuration = @0.5;
    imageView.glowAnimationDuration = @1.0;

    [imageView createGlowLayer];
    [imageView insertGlowLayer];
    [imageView startGlowLoop];
    [lightView addSubview:imageView];

    // 侧边栏
    sideMenu = [[FYXSideMenu alloc]initWithFrame:self.view.bounds];
    [sideMenu addgestureView:self.view hideView:lightView];
    sideMenu.backgroundView.hidden = YES;
    sideMenu.hidden = YES;
    [sideMenu setSideMenuViewWidth:self.view.frame.size.width / 4 * 3];
    [self.view addSubview:sideMenu];

}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}
- (void)alertClick: (UIButton *)sender {
    alertView.hidden        = NO;
    // 弹窗
    [alertView setAlertTitle:@"this create success" titleFont:17];
    [alertView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
    [alertView.sureBtn setTitle:@"sure" forState:UIControlStateNormal];
    [alertView.sureBtn setTitleColor:[UIColor colorWithRed:0 green:122.0 / 255 blue:255.0 / 255 alpha:1] forState:UIControlStateNormal];
    [alertView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

}

- (void)alertMsgClick: (UIButton *)sender {

    alertMsgView.hidden     = NO;

    // 文字弹窗
    [alertMsgView setMsgAlertView:@"提示" titleFont:19 alertMsg:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" msgFont:11 msgColor: [UIColor colorWithRed:101.0 / 255 green:101.0 / 255 blue:101.0 / 255 alpha:1]];
    
    [alertMsgView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
    [alertMsgView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [alertMsgView setMsgAlertFrame:200 AlertWidth: 295];
}

- (void)alertRichClick: (UIButton *)sender {
    alertRichView.hidden    = NO;
    // 富文本弹窗
    [alertRichView setRichTextView:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" textFont:11];
    [alertRichView setRichTextViewFrame:200 height:300];
}

- (void)alertImageClick: (UIButton *)sender {
    alertImageView.hidden   = NO;
    [alertImageView setImageAlertView:@"机器学习是近年来\n渐趋热门的一个领域" contentFont:17 contentColor:[UIColor blackColor] imageName:@"checkView.png"];
    [alertImageView.cancelBtn setTitleColor:[UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f] forState:UIControlStateNormal];
}

- (void)alertImage2Click: (UIButton *)sender {
    alertImageView.hidden   = NO;
    [alertImageView setImageAlertView:@"机器学习是近年来\n渐趋热门的一个领域" contentFont:17 contentColor:[UIColor blackColor] imageName:@"close_red.png"];
    [alertImageView.cancelBtn setTitleColor:[UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f] forState:UIControlStateNormal];
}

- (void)alertMoreBtnClick: (UIButton *)sender {
    alertMoreBtnView.hidden = NO;
    [alertMoreBtnView setMoreBtnAlertView:@"您目前的取送车订单有绑定的保养预约服务，是否同时取消保养预约？" contentFont:15];
    [alertMoreBtnView.sureBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [alertMoreBtnView.cancelBtn setTitleColor:[UIColor colorWithRed:0 green:122.0 / 255 blue:255.0 / 255 alpha:1] forState:UIControlStateNormal];
}

- (void)bubbleBtnClick: (UIButton *)sender {
    bubbleView.hidden = NO;
    [bubbleView setBubbleView:@"已取消预约" font:16 textColor: [UIColor blackColor]];
}

- (void)toastBtnClick: (UIButton *)sender {
//    [FYXToast showWithTextImage:@"您目前的取送车订单有绑" imageName:@"success.png"];
    [FYXToast showWithText:@"您目前的取送车订单有绑定的保养预约服务，是否同时取消保养预约？"];
}

- (void)toastPicBtnClick: (UIButton *)sender {
    [FYXToast showWithTextImage:@"您目前的取送车订单有绑" imageName:@"success.png"];
//    [FYXToast showWithText:@"您目前的取送车订单有绑定的保养预约服务，是否同时取消保养预约？"];
}

- (void)pageFlowBtnClick: (UIButton *)sender {
    PageFlowViewController *vc = [[PageFlowViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)calendarClick: (UIButton *)sender {
    CalendarViewController *vc = [[CalendarViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
 
}

- (void)checkAnimationBtnClick: (UIButton *)sender {
    CheckAnimationViewController *vc = [[CheckAnimationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)hudBtnClick: (UIButton *)sender {
    HUdViewController *vc = [[HUdViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)safeLightBtnClick: (UIButton *)sender {
    safelightView.hidden = NO;
    [safelightView setSafeLightView:@"点亮表示指示灯处于启动状态。" suggest:@"具体操作参考用户手册。" title:@"安全指示灯" instruteTitle:@"指示灯说明：" suggestTitle:@"建议：" titleImage:@"safeLight.png"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertMsg2Click: (UIButton *)sender {

    alertMsgView.hidden     = NO;

    // 文字弹窗
    [alertMsgView setMsgAlertView:@"取车计费方式" titleFont:19 alertMsg:@"" msgFont:11 msgColor: [UIColor colorWithRed:101.0 / 255 green:101.0 / 255 blue:101.0 / 255 alpha:1]];

    [alertMsgView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
    [alertMsgView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [alertMsgView setMsgAlertFrame:200 AlertWidth: 295];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@" 1、服务时间 07:00-20:59\n  \n 2、 收费规则:起步价39元（10公里内），10公里后，每公里加收10元，不足5公里按5公里计算。\n*注：以上计费方式"];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1] range:NSMakeRange(0, 68)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101.0 / 255 green:101.0 / 255 blue:101.0 / 255 alpha:1] range:NSMakeRange(68, 11)];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:5] range:NSMakeRange(68, 1)];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 68)];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(69, 11)];
    alertMsgView.msgLabel.attributedText = text;
    [alertMsgView.cancelBtn setTitleColor:[UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f] forState:UIControlStateNormal];

}

- (void)cardBtnClick: (UIButton *)sender {
    cardAlerView.hidden = NO;
    [cardAlerView setCardAlert:@"旅行大礼包" subtitle:@"我是副标题一行字" cardNumb:@"券码：aaaa" cardPw:@"密码：77777" prompt:@"如果密码一同复制，用/分隔" firstImage:@"call.png" secondImage:@"copy.png" thirdImage:@"link.png" firstString:@"客服热线" secondString:@"复制兑换码" thirdString:@"使用链接"];
}

- (void)vinBtnClick: (UIButton *)sender {
    VinViewController *vc = [[VinViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)topBtnClick: (UIButton *)sender {
    topAlertView.hidden = NO;
    [topAlertView setTopAlert:@"收费规则:起步价39元（10公里内），10公里后，每公里加收10元，不足5公里按5公里计算。adadda" titleFont:15];
    [topAlertView setOtherBtnframe:NSMakeRange(10, 7)];
}
- (void)sideMenuClick: (UIButton *)sender {
    
    [sideMenu clickDraw];
}
- (void)sureDidClick: (FYXAlertView *)alertView {
    NSLog(@"sure");
}

- (void)otherBtnDidClick:(FYXAlertView *)alertView {
    NSLog(@"跳转");
}

@end

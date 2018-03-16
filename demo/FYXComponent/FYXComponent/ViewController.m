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

@interface ViewController ()<FYXAlertViewDelegate>
{
    FYXAlertView *alertView;
    FYXAlertView *alertMsgView;
    FYXAlertView *alertRichView;
    FYXAlertView *alertImageView;
    FYXAlertView *alertMoreBtnView;
    FYXAlertView *bubbleView;
    FYXSideMenu  *sideMenu;
    
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

    FYXTextField *textField = [[FYXTextField alloc]initWithFrame:CGRectMake(200, 100, 100, 30)];
    [textField setPlaceholder:@"请登录"];
    [self.view addSubview:textField];

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

    bubbleView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    bubbleView.hidden = YES;
    [self.view addSubview:bubbleView];

    // 侧边栏
    sideMenu = [[FYXSideMenu alloc]initWithFrame:self.view.bounds];
    [sideMenu addgestureView:self.view];
    sideMenu.hidden = YES;
    [sideMenu setSideMenuViewWidth:self.view.frame.size.width / 4 * 3];
    [self.view addSubview:sideMenu];

}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}
- (void)alertClick: (UIButton *)sender {
    alertView.hidden        = NO;
    alertMsgView.hidden     = YES;
    alertRichView.hidden    = YES;
    alertImageView.hidden   = YES;
    alertMoreBtnView.hidden = YES;
    // 弹窗
    [alertView setAlertTitle:@"this create success" titleFont:17];
    [alertView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
    [alertView.sureBtn setTitle:@"sure" forState:UIControlStateNormal];
    [alertView.sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [alertView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (void)alertMsgClick: (UIButton *)sender {
    alertView.hidden        = YES;
    alertMsgView.hidden     = NO;
    alertRichView.hidden    = YES;
    alertImageView.hidden   = YES;
    alertMoreBtnView.hidden = YES;
    // 文字弹窗
    [alertMsgView setMsgAlertView:@"提示" titleFont:19 alertMsg:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" msgFont:11 msgColor: [UIColor colorWithRed:101.0 / 255 green:101.0 / 255 blue:101.0 / 255 alpha:1]];
    
    [alertMsgView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
    [alertMsgView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [alertMsgView setMsgAlertFrame:200 AlertWidth: 295];
}

- (void)alertRichClick: (UIButton *)sender {
    alertView.hidden        = YES;
    alertMsgView.hidden     = YES;
    alertRichView.hidden    = NO;
    alertImageView.hidden   = YES;
    alertMoreBtnView.hidden = YES;
    // 富文本弹窗
    [alertRichView setRichTextView:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" textFont:11];
    [alertRichView setRichTextViewFrame:200 height:300];
}

- (void)alertImageClick: (UIButton *)sender {
    alertView.hidden        = YES;
    alertMsgView.hidden     = YES;
    alertRichView.hidden    = YES;
    alertImageView.hidden   = NO;
    alertMoreBtnView.hidden = YES;
    [alertImageView setImageAlertView:@"机器学习是近年来\n渐趋热门的一个领域" contentFont:17 contentColor:[UIColor blackColor] imageName:@"checkView.png"];
    [alertImageView.cancelBtn setTitleColor:[UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f] forState:UIControlStateNormal];
}

- (void)alertImage2Click: (UIButton *)sender {
    alertView.hidden        = YES;
    alertMsgView.hidden     = YES;
    alertRichView.hidden    = YES;
    alertImageView.hidden   = NO;
    alertMoreBtnView.hidden = YES;
    [alertImageView setImageAlertView:@"机器学习是近年来\n渐趋热门的一个领域" contentFont:17 contentColor:[UIColor blackColor] imageName:@"close_red.png"];
    [alertImageView.cancelBtn setTitleColor:[UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f] forState:UIControlStateNormal];
}

- (void)alertMoreBtnClick: (UIButton *)sender {
    alertView.hidden        = YES;
    alertMsgView.hidden     = YES;
    alertRichView.hidden    = YES;
    alertImageView.hidden   = YES;
    alertMoreBtnView.hidden = NO;
    [alertMoreBtnView setMoreBtnAlertView:@"您目前的取送车订单有绑定的保养预约服务，是否同时取消保养预约？" contentFont:15];
}

- (void)bubbleBtnClick: (UIButton *)sender {
    bubbleView.hidden = NO;
    [bubbleView setBubbleView:@"已取消预约" font:16 textColor: [UIColor blackColor]];
}
- (void)toastBtnClick: (UIButton *)sender {
//    [FYXToast showWithTextImage:@"您目前的取送车订单有绑" imageName:@"success.png"];
    [FYXToast showWithText:@"您目前的取送车订单有绑定的保养预约服务，是否同时取消保养预约？"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sureDidClick:(FYXAlertView *)alertView {
    
}

@end

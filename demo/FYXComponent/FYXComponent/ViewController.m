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
    FYXAlertView *actionAlertView;
    UIView       *lightView;
    UITableView  *tableView;
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

    FYXButton *topBtn = [[FYXButton alloc]initWithFrame:CGRectMake(200, 50, 100, 30)];
    [topBtn setTitle:@"上部弹窗" forState:UIControlStateNormal];
    [topBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topBtn];

    FYXButton *actionSheet = [[FYXButton alloc]initWithFrame:CGRectMake(200, 600, 100, 30)];
    [actionSheet setTitle:@"actionSheetAlert" forState:UIControlStateNormal];
    [actionSheet addTarget:self action:@selector(actionSheetClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:actionSheet];

    cardAlerView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    cardAlerView.delegate = self;
    [self.view addSubview:cardAlerView];
    cardAlerView.hidden = YES;

    alertView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:alertView];
    alertView.delegate = self;
    alertView.hidden = YES;

    actionAlertView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:actionAlertView];
    actionAlertView.hidden = YES;

    alertMsgView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:alertMsgView];
//    alertMsgView.delegate = self;
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
    NSString * str = @"以下的计划由系统自动估算，仅供参考";

    [topAlertView setTopAlert: str titleFont:14];
        [topAlertView setOtherBtnframe:NSMakeRange(1, 7)];
//    if ([str length] > 10) {
//        topAlertView.msgLabel.textAlignment = NSTextAlignmentLeft;
//    }else {
//        topAlertView.msgLabel.textAlignment = NSTextAlignmentCenter;
//    }
    topAlertView.delegate = self;
    NSLog(@"这个弹窗的高度 %f", topAlertView.alertView.frame.size.height);

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
    lightBackgroundView.frame = CGRectMake(0, 55,24, 49);
    [lightBackgroundView setImage:[UIImage imageNamed:@"lightView.png"] forState:UIControlStateNormal];
    [lightBackgroundView addTarget:self action:@selector(sideMenuClick:) forControlEvents:UIControlEventTouchUpInside];


    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"light.png"];
    imageView.frame = CGRectMake(8, 69, 20, 20);
    imageView.glowRadius = @(10.0f);
    imageView.glowOpacity = @(0.5f);
    imageView.glowColor = [UIColor  colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1];

    imageView.glowDuration = @1.0;
    imageView.hideDuration = @0.5;
    imageView.glowAnimationDuration = @1.0;

    [imageView createGlowLayer];
    [imageView insertGlowLayer];
    [imageView startGlowLoop];
    [self.view addSubview:imageView];
    [self.view addSubview:lightBackgroundView];

    // 侧边栏
    sideMenu = [[FYXSideMenu alloc]initWithFrame:self.view.bounds];
//    [sideMenu addgestureView:self.view hideView:lightView];
    sideMenu.backgroundView.hidden = YES;
    sideMenu.hidden = YES;
    sideMenu.sideMenY = 100;
    [sideMenu setSideMenuViewWidth:self.view.frame.size.width / 4 * 3];
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, sideMenu.sideMenuView.frame.size.width, self.view.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass: [UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [sideMenu.sideMenuView addSubview:tableView];
    [self.view addSubview:sideMenu];

  
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}
- (void)alertClick: (UIButton *)sender {
    alertView.hidden        = NO;
    // 弹窗
//    [alertView setMsgClickAlertTitle:@"提示" titleFont:18 msg:@"当前设备或系统版本不在苹果AR技术支持范围内。查看支持设备>>" msgFont:16 clickMsgRange:NSMakeRange(23, 8) clickMsgFont:14];

//    [alertView setAlertTitle:@"您当前处于非wifi环境下。继续下载将会产生手机流量，确定继续？" titleFont:17];
    [alertView setAlertTitle:@"当前是移动网络，是否继续播放？挂个大概的空间哈会计核算的\n丁磺氨酸和大数据和大数据，好还是大家好噶第八十三的好噶时间吧哈睡觉可好北方大厦，结过婚还风景好噶舒服改哈说不乏世界级会发神经韩国发技术 把建良卡上头发衣服居家环境很高也同样天方夜谭返回同样非常认同出一个非常" titleFont:17];

////    alertView.msgLabel.textAlignment = NSTextAlignmentLeft;
    [alertView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
    [alertView.sureBtn setTitle:@"sure" forState:UIControlStateNormal];
//    //[alertView.sureBtn setTitleColor:[UIColor colorWithRed:0 green:122.0 / 255 blue:255.0 / 255 alpha:1] forState:UIControlStateNormal];
////    [alertView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [alertView.cancelBtn addTarget:self action:@selector(otherBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
}





- (void)alertMsgClick: (UIButton *)sender {

    alertView.hidden     = NO;

    // 文字弹窗
//    NSString *str1 = @"1、服务时间07:00-20:59\n2、收费规则：起步价39元（10公里内），10公里后，每公里加收10元，不足5公里按5公里计算。";
//    NSString *str2 = @"*注：以上计费方法为“e代驾”制定的上门取车代驾计费方法";
    [alertView setMsgAlertView:@"取送车计费方法我我方法为“e代驾”制定上门取车代驾计" titleFont:18 alertMsg:@"如果您的爱车无法绑定，请确定是否属于以下情况：\n\n1.可能由于订单车辆信息没有录入，请联系您的购车销售店确认。\n\n2.如果您的爱车是丰田进口车或者非广汽丰田品牌车辆，非常抱歉丰云行暂时只能绑定广汽丰田生产车辆，未来我们将支持更多车型，敬请期待。" msgFont:18 msgColor: [UIColor colorWithRed:101.0 / 255 green:101.0 / 255 blue:101.0 / 255 alpha:1]];

//    alertView.msgLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    [alertView.cancelBtn setTitle:@"知道了" forState:UIControlStateNormal];
    [alertView.cancelBtn setTitleColor:[UIColor colorWithRed:11.0 / 255 green:171.0 / 254 blue:254.0 / 254 alpha:1.0] forState:UIControlStateNormal];

//    alertView.richTextView.text = [str1 stringByAppendingString:str2];
//    [alertView setMsgAlertHeight:200 AlertWidth:295];

}

- (void)alertRichClick: (UIButton *)sender {
    alertRichView.hidden    = NO;
    // 富文本弹窗
    [alertRichView setRichTextView:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" textFont:11];
    [alertRichView setRichTextViewFrame:200 height:300];
}

- (void)alertImageClick: (UIButton *)sender {
    alertImageView.hidden   = NO;
    [alertImageView setImageAlertView:@"预约已取消成功" contentFont:17 contentColor:[UIColor blackColor] imageName:@"checkView.png"];
//    [alertImageView.cancelBtn setTitleColor:[UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f] forState:UIControlStateNormal];
}

- (void)alertImage2Click: (UIButton *)sender {
    alertImageView.hidden   = NO;
    [alertImageView setImageAlertView:@"机器学习是近年来\n渐趋热门的一个领域" contentFont:17 contentColor:[UIColor blackColor] imageName:@"close_red.png"];
    [alertImageView.cancelBtn setTitleColor:[UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f] forState:UIControlStateNormal];
}

- (void)alertMoreBtnClick: (UIButton *)sender {
    alertMoreBtnView.hidden = NO;
    [alertMoreBtnView setMoreBtnAlertView:@"您目前的取送车订单有绑定的保养预约服务，是否同时取消保养预约？" contentFont:18];
//    [alertMoreBtnView.sureBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [alertMoreBtnView.cancelBtn setTitleColor:[UIColor colorWithRed:0 green:122.0 / 255 blue:255.0 / 255 alpha:1] forState:UIControlStateNormal];
}

- (void)bubbleBtnClick: (UIButton *)sender {
    bubbleView.hidden = NO;
    bubbleView.delegate = self;
    [bubbleView setBubbleView:@"已取消预约,请在此预约" font:20 textColor:[UIColor blackColor]];
    [bubbleView setBubbleViewY:180 ];
}

- (void)toastBtnClick: (UIButton *)sender {
//    [FYXToast showWithTextImage:@"您目前的取送车订单有绑" imageName:@"success.png"];
//    [FYXToast showWithText:@"您目前的取送"];
    [FYXToast showWithText:@"密码输入错误超过5次，请通过忘记密码重置!"];

}

- (void)toastPicBtnClick: (UIButton *)sender {
    [FYXToast showWithTextImage:@"注册成功，请继续完善资料" imageName:@"success.png"];
//    [FYXToast showWithImageFrame:@"反馈成功" imageName:@"success.png" frame:CGRectMake([[UIScreen mainScreen] bounds].size.width / 2 - 165 / 2, [[UIScreen mainScreen] bounds].size.height / 2  - 116 / 2, 165, 116)];
//    [FYXToast showWithFrame:@"您目前的取送车订单有绑" frame:CGRectMake(0, 200, [[UIScreen mainScreen] bounds].size.width , 100)];
//    [FYXToast showWithText:@"您目前的取送车"];
//    [FYXToast showWithText:@"密码输入超过5次，请通过忘记密码重之"];
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

    [safelightView createSafeLightView:@"具体操作参考用户手册大撒打算啊大啊大撒打算的撒大的啊大大 大大大啊大啊大叔打啊师傅啊师傅的阿福啊师傅阿福啊师傅爱上大法啊师傅阿福阿福啊师傅的阿道夫啊师傅啊师傅 啊阿福吖吖发生 a s。具体操作参考用户手册大撒打算啊大啊大撒打算的撒大的啊大大 大大大啊大啊大叔打啊师傅啊师傅的阿福。" suggest:@"具体操作参考用户手册机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。" title:@"发动机停机装置&防盗系统指示灯" instruteTitle:@"指示灯说明：" suggestTitle:@"建议：" titleImage:@"safeLight.png"];


//    [safelightView setSafeLightView:@"具体操作参考用户手册大撒打算啊大啊大撒打算的撒大的啊大大 大大大啊大啊大叔打啊师傅啊师傅的阿福啊师傅阿福啊师傅爱上大法啊师傅阿福阿福啊师傅的阿道夫啊师傅啊师傅 啊阿福吖吖发生 a s。具体操作参考用户手册大撒打算啊大啊大撒打算的撒大的啊大大 大大大啊大啊大叔打啊师傅啊师傅的阿福" suggest:@"具体操作参考用户手册大撒打算啊大啊大撒打算的撒大的啊大大 大大大啊大啊大叔打啊师傅啊师傅的阿福啊师傅阿福啊师傅爱上大法啊师傅阿福阿福啊师傅的阿道夫啊师傅啊师傅 啊阿福吖吖发生 a s。机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学" title:@"发动机停机装置&防盗系统指示" instruteTitle:@"指示灯说明：" suggestTitle:@"建议：我们可以设置了" titleImage:@"safeLight.png"];


    [safelightView.cancelBtn addTarget:self action:@selector(safeLightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertMsg2Click: (UIButton *)sender {

    alertMsgView.hidden     = NO;

    // 文字弹窗
    [alertMsgView setMsgAlertView:@"取车计费方式" titleFont:19 alertMsg:@"" msgFont:11 msgColor: [UIColor colorWithRed:101.0 / 255 green:101.0 / 255 blue:101.0 / 255 alpha:1]];

    [alertMsgView.cancelBtn setTitle:@"知道了" forState:UIControlStateNormal];
    [alertMsgView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [alertMsgView setMsgAlertHeight:200 AlertWidth: 330];
    NSString *str1 = @"1、服务时间07:00-20:59\n2、收费规则：起步价39元（10公里内），10公里后，每公里加收10元，不足5公里按5公里计算。";
    NSString *str2 = @"\n*注：以上计费方法为“e代驾”制定的上门取车代驾计费方法";

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[str1 stringByAppendingString:str2]];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:50.0 / 255 green:50.0 / 255 blue:50.0 / 255 alpha:1] range:NSMakeRange(0, [str1 length])];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101.0 / 255 green:101.0 / 255 blue:101.0 / 255 alpha:1] range:NSMakeRange([str1 length], [str2 length])];
//    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:5] range:NSMakeRange(68, 1)];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, [str1 length])];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange([str1 length], [str2 length])];
    alertMsgView.richTextView.attributedText = text;
    [alertMsgView.cancelBtn setTitleColor:[UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f] forState:UIControlStateNormal];

}

- (void)cardBtnClick: (UIButton *)sender {
    cardAlerView.hidden = NO;
    [cardAlerView setCardAlert:@"旅行大礼包" subtitle:@"我是副标题一行字" cardNumb:@"券码：aaaa" cardPw:@"密码：77777" prompt:@"如果密码一同复制，用/分隔" firstImage:@"call.png" secondImage:@"copy.png" thirdImage:@"link.png" firstString:@"客服热线" secondString:@"复制兑换码" thirdString:@"使用链接"];
}

- (void)actionSheetClick: (UIButton *)sender {
    actionAlertView.hidden = NO;
    [actionAlertView setActionSheetAlert];
    [actionAlertView.sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [actionAlertView.middleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [actionAlertView.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [actionAlertView.sureBtn setTitle:@"只取消取车订单" forState:UIControlStateNormal];
    [actionAlertView.middleBtn setTitle:@"只取消送车订单" forState:UIControlStateNormal];
    [actionAlertView.cancelBtn setTitle:@"消取车订单" forState:UIControlStateNormal];
}
- (void)safeLightHidden: (UIButton *)sender {
    safelightView.hidden = YES;
}

- (void)vinBtnClick: (UIButton *)sender {
    VinViewController *vc = [[VinViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)topBtnClick: (UIButton *)sender {
    [topAlertView tTopAlertHight:100];
    topAlertView.hidden = NO;

}
- (void)sideMenuClick: (UIButton *)sender {
    
//    [sideMenu clickDraw];
    [sideMenu startAnimation];
}
- (void)sureDidClick: (FYXAlertView *)alertView {
    NSLog(@"sure");
     alertView.hidden = YES;
}

- (void)otherBtnDidClick:(FYXAlertView *)alertView {
    NSLog(@"跳转");
     alertView.hidden = YES;
}

- (void)cancelBtnDidClick:(FYXAlertView *)alertView {
    alertView.hidden = YES;
}

@end

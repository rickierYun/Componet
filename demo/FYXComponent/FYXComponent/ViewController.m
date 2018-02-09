//
//  ViewController.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/9.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "ViewController.h"
#import "FYXAlertView.h"
@interface ViewController ()<FYXAlertViewDelegate>
{
    FYXAlertView *alertView;
    FYXAlertView *alertMsgView;
    FYXAlertView *alertRichView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

    UIButton *alertBtn = [[UIButton alloc]init];
    alertBtn.frame = CGRectMake(0, 100, 100, 30);
    [alertBtn setTitle:@"普通弹窗" forState:UIControlStateNormal];
    [alertBtn addTarget:self action:@selector(alertClick:) forControlEvents:UIControlEventTouchUpInside];
    [alertBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:alertBtn];

    UIButton *alertMsgBtn = [[UIButton alloc]init];
    alertMsgBtn.frame = CGRectMake(0, 200, 100, 30);
    [alertMsgBtn setTitle:@"文字弹窗" forState:UIControlStateNormal];
    [alertMsgBtn addTarget:self action:@selector(alertMsgClick:) forControlEvents:UIControlEventTouchUpInside];
    [alertMsgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:alertMsgBtn];

    UIButton *alertRichBtn = [[UIButton alloc]init];
    alertRichBtn.frame = CGRectMake(0, 300, 100, 30);
    [alertRichBtn setTitle:@"富文本弹窗" forState:UIControlStateNormal];
    [alertRichBtn addTarget:self action:@selector(alertRichClick:) forControlEvents:UIControlEventTouchUpInside];
    [alertRichBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:alertRichBtn];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)alertClick: (UIButton *)sender {
    alertView.hidden = NO;
    alertMsgView.hidden = YES;
    alertRichView.hidden = YES;
    // 弹窗
    [alertView setAlertTitle:@"this create success" titleFont:17];
    [alertView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
    [alertView.sureBtn setTitle:@"sure" forState:UIControlStateNormal];
    [alertView.sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [alertView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (void)alertMsgClick: (UIButton *)sender {
    alertView.hidden = YES;
    alertMsgView.hidden = NO;
    alertRichView.hidden = YES;
    // 文字弹窗
    [alertMsgView setMsgAlertView:@"提示" titleFont:19 alertMsg:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" msgFont:11];
    [alertMsgView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
    [alertMsgView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [alertMsgView setMsgAlertFrame:200 AlertWidth:200];
}

- (void)alertRichClick: (UIButton *)sender {
    alertView.hidden = YES;
    alertMsgView.hidden = YES;
    alertRichView.hidden = NO;
    // 富文本弹窗
    [alertRichView setRichTextView:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" textFont:11];
    [alertRichView setRichTextViewFrame:200 height:300];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sureDidClick:(FYXAlertView *)alertView {
    alertView.hidden = YES;
}

@end

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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FYXAlertView *alertView = [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:alertView];
    alertView.delegate = self;

    // 弹窗
//    [alertView setAlertTitle:@"this create success" titleFont:17];
//    [alertView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
//    [alertView.sureBtn setTitle:@"sure" forState:UIControlStateNormal];
//    [alertView.sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [alertView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    // 文字弹窗
//    [alertView setMsgAlertView:@"提示" titleFont:19 alertMsg:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" msgFont:11];
//    [alertView.cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
//    [alertView.cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [alertView setMsgAlertFrame:200 AlertWidth:200];


    // 富文本弹窗
    [alertView setRichTextView:@"机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推机器学习是近年来渐趋热门的一个领域，同时Python 语言经过一段时间的发展也已逐渐成为主流的编程语言之一。本书结合了机器学习和Python 语言两个热门的领域，通过利用两种核心的机器学习算法来将Python 语言在数据分析方面的优势发挥到极 致。 全书共有10 章。第 1 章讲解了Python 机器学习的生态系统，剩余9 章介绍了众多与机器学习相关的算法，包括各类分类算法、数据可视化技术、推荐引擎等，主要包括机器学习在公寓、机票、IPO 市场、新闻源、内容推" textFont:11];
    [alertView setRichTextViewFrame:200 height:300];
    

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sureDidClick:(FYXAlertView *)alertView {
    alertView.hidden = YES;
}

@end

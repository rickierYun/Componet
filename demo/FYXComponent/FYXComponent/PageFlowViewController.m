//
//  PageFlowViewController.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/12.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "PageFlowViewController.h"
#import "FYXCalendar.h"

@interface PageFlowViewController ()

@end

@implementation PageFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

//    pageFlow = [[FYXPageFlow alloc]initWithFrame:self.view.bounds];
    pageFlow = [[FYXPageFlow alloc]initWithFrame: CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height)];
    pageFlow.dataSource = self;
    // 重新定义cell
//        [pageFlow.collectionView registerClass:[CollectionCell class]forCellWithReuseIdentifier:@"cell"];
        [pageFlow setPageSize:305 height:495 lineSpace:20];
    [pageFlow.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    pageFlow.pageControl.currentPage = 1;
    [self.view addSubview:pageFlow];
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(60,92, self.view.frame.size.width, 23)];
    lb.text = @"拉伸的字体";
    lb.textColor = [UIColor blueColor];
    lb.font = [UIFont systemFontOfSize:26];
    [self.view addSubview:lb];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfPageFlow:(FYXPageFlow *)pageFlow {
    return 5;
}


// 自定义cell
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//
//    cell.timeBtn.backgroundColor = [UIColor redColor];
//    return cell;
//}


@end

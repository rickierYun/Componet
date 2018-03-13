//
//  PageFlowViewController.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/12.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "PageFlowViewController.h"
#import "FYXPageFlow.h"

@interface PageFlowViewController ()

@end

@implementation PageFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    pageFlow = [[FYXPageFlow alloc]initWithFrame:self.view.bounds];
    pageFlow.dataSource = self;
    // 重新定义cell
//        [pageFlow.collectionView registerClass:[CollectionCell class]forCellWithReuseIdentifier:@"cell"];
//        [pageFlow setPageSize:288 height:500 lineSpace:10];
    [self.view addSubview:pageFlow];
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
//    cell.timeBtn.backgroundColor = [UIColor redColor];
//    return cell;
//}


@end

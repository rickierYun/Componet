//
//  CheckAnimationViewController.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/12.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "CheckAnimationViewController.h"
#import "FYXCheckView.h"

@interface CheckAnimationViewController ()

@end

@implementation CheckAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    FYXCheckView *checkView = [[FYXCheckView alloc]initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 80, 80)];
    [self.view addSubview:checkView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

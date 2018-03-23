//
//  VinViewController.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/23.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "VinViewController.h"
#import "VinView.h"

@interface VinViewController ()

@end

@implementation VinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    VinView *vinView = [[VinView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height )];
    
    [self.view addSubview:vinView];
    // Do any additional setup after loading the view.
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

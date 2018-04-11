//
//  FYXActionSheet.h
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/4/11.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYXActionSheet : UIView
@property (nonatomic, weak) UITableView *tableView;
@end

@interface ActionSheet : UITableViewCell

@property (nonatomic, weak) UIButton *actionBtn;
@end

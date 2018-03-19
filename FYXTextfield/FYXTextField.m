//
//  FYXTextField.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/23.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "FYXTextField.h"

@implementation FYXTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.borderWidth  = 1;
        self.textAlignment      = NSTextAlignmentLeft;
        self.layer.borderColor  = [UIColor lightGrayColor].CGColor;
        self.font               = [UIFont systemFontOfSize:16];
        self.textColor          = [UIColor colorWithRed:101.0 / 255 green:101.0 / 255 blue:101.0 / 255 alpha:1.0f];
        self.backgroundColor    = [UIColor whiteColor];
        self.tintColor          = [UIColor lightGrayColor];
        self.leftView           = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)]; //这是光标的起始位置
        self.leftViewMode       = UITextFieldViewModeAlways;
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入内容" attributes:@{
                                        NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                        NSFontAttributeName           : [UIFont systemFontOfSize:13]
                                    } ];            // 设置placeholder
        self.leftView.userInteractionEnabled = NO;
        self.contentVerticalAlignment  = UIControlContentVerticalAlignmentCenter;       // 设置内容对其方式
    }
    return self;
}

// 扩展设置placeholder函数，增加预设值
- (void)setPlaceholder:(NSString *)placeholder  {
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{
                                  NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                  NSFontAttributeName           : [UIFont systemFontOfSize:13]
                                  } ];
}
@end

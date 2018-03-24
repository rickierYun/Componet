//
//  VinView.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/23.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "VinView.h"
#import "FYXButton.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define VIEW_CENTER(aView)       ((aView).center)
#define VIEW_CENTER_X(aView)     ((aView).center.x)
#define VIEW_CENTER_Y(aView)     ((aView).center.y)

#define VIEW_FRAME(aView)        ((aView).frame)

#define VIEW_ORIGIN(aView)       ((aView).frame.origin)
#define VIEW_X(aView)            ((aView).frame.origin.x)
#define VIEW_Y(aView)            ((aView).frame.origin.y)

#define VIEW_SIZE(aView)         ((aView).frame.size)
#define VIEW_HEIGHT(aView)       ((aView).frame.size.height)
#define VIEW_WIDTH(aView)        ((aView).frame.size.width)

#define VIEW_X_Right(aView)      ((aView).frame.origin.x + (aView).frame.size.width)
#define VIEW_Y_Bottom(aView)     ((aView).frame.origin.y + (aView).frame.size.height)
@implementation VinView {
    UITextField *tf1;
    UITextField *tf2;
    UITextField *tf3;
    UITextField *tf4;
    UITextField *tf5;
    UITextField *tf6;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];

    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *vinImage = [[UIImageView alloc]init];
        vinImage.frame = CGRectMake(25 , 43, SCREEN_WIDTH - 50  , 180 );
        vinImage.image = [UIImage imageNamed:@"vin.png"];
//        self.delegate = self;
        [self addSubview:vinImage];

        UILabel *vinLabel = [[UILabel alloc]init];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"车架号(VIN)(填写后六位数字)"];
        [text addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 8)];
        [text addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(8, 9)];
        [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 8)];
        [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(8, 9)];
        vinLabel.attributedText = text;
        vinLabel.textAlignment = NSTextAlignmentCenter;
        vinLabel.frame = CGRectMake(0, VIEW_Y_Bottom(vinImage) + 18, VIEW_WIDTH(self), 25);
        [self addSubview:vinLabel];

        tf1 = [[UITextField alloc]init];
        tf1.frame = CGRectMake((VIEW_WIDTH(self) - 340) / 2 , VIEW_Y_Bottom(vinLabel) + 30, 50, 50);
        tf1.textAlignment = NSTextAlignmentCenter;
        tf1.font = [UIFont systemFontOfSize:21];
        tf1.layer.cornerRadius = 5;
        tf1.layer.borderColor = [UIColor blackColor].CGColor;
        tf1.layer.borderWidth = 1;
        tf1.delegate = self;
        [self addSubview:tf1];

        tf2 = [[UITextField alloc]init];
        tf2.frame = CGRectMake(VIEW_WIDTH(tf1) + VIEW_X(tf1) + 8, VIEW_Y_Bottom(vinLabel) + 30, 50, 50);
        tf2.textAlignment = NSTextAlignmentCenter;
        tf2.font = [UIFont systemFontOfSize:21];
        tf2.layer.cornerRadius = 5;
        tf2.layer.borderColor = [UIColor blackColor].CGColor;
        tf2.layer.borderWidth = 1;
        tf2.delegate = self;
        [self addSubview:tf2];

        tf3 = [[UITextField alloc]init];
        tf3.frame = CGRectMake(VIEW_WIDTH(tf1) + VIEW_X(tf2) + 8, VIEW_Y_Bottom(vinLabel) + 30, 50, 50);
        tf3.textAlignment = NSTextAlignmentCenter;
        tf3.font = [UIFont systemFontOfSize:21];
        tf3.layer.cornerRadius = 5;
        tf3.layer.borderColor = [UIColor blackColor].CGColor;
        tf3.layer.borderWidth = 1;
        tf3.delegate = self;
        [self addSubview:tf3];

        tf4 = [[UITextField alloc]init];
        tf4.frame = CGRectMake(VIEW_WIDTH(tf1) + VIEW_X(tf3) + 8, VIEW_Y_Bottom(vinLabel) + 30, 50, 50);
        tf4.textAlignment = NSTextAlignmentCenter;
        tf4.font = [UIFont systemFontOfSize:21];
        tf4.layer.cornerRadius = 5;
        tf4.layer.borderColor = [UIColor blackColor].CGColor;
        tf4.layer.borderWidth = 1;
        tf4.delegate = self;
        [self addSubview:tf4];

        tf5 = [[UITextField alloc]init];
        tf5.frame = CGRectMake(VIEW_WIDTH(tf1) + VIEW_X(tf4) + 8, VIEW_Y_Bottom(vinLabel) + 30, 50, 50);
        tf5.textAlignment = NSTextAlignmentCenter;
        tf5.font = [UIFont systemFontOfSize:21];
        tf5.layer.cornerRadius = 5;
        tf5.layer.borderColor = [UIColor blackColor].CGColor;
        tf5.layer.borderWidth = 1;
        tf5.delegate = self;
        [self addSubview:tf5];

        tf6 = [[UITextField alloc]init];
        tf6.frame = CGRectMake(VIEW_WIDTH(tf1) + VIEW_X(tf5) + 8, VIEW_Y_Bottom(vinLabel) + 30, 50, 50);
        tf6.textAlignment = NSTextAlignmentCenter;
        tf6.font = [UIFont systemFontOfSize:21];
        tf6.layer.cornerRadius = 5;
        tf6.layer.borderColor = [UIColor blackColor].CGColor;
        tf6.layer.borderWidth = 1;
        tf6.delegate = self;
        [self addSubview:tf6];

        FYXButton *next = [[FYXButton alloc]initWithFrame:CGRectMake(17, VIEW_Y_Bottom(tf1) + 30, VIEW_WIDTH(self) - 24, 50)];
        [next setTitle:@"下一步" forState:UIControlStateNormal];
        [self addSubview:next];
    }
    return self;
}

- (void)nextClick: (UIButton *)sender {
    NSString *vinStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",tf1.text,tf2.text,tf3.text,tf4.text,tf5.text,tf6.text];
    if ([self.delegate respondsToSelector:@selector(nextClick:)]) {
        [self.delegate nextClick:vinStr];
    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == tf1) {
        if ([textField.text length] >= 1) {
            [tf2 becomeFirstResponder];
        }
    }
    if (textField == tf2) {
        if ([textField.text length] >= 1) {
            [tf3 becomeFirstResponder];
        }
    }
    if (textField == tf3) {
        if ([textField.text length] >= 1) {
            [tf4 becomeFirstResponder];
        }
    }
    if (textField == tf4) {
        if ([textField.text length] >= 1) {
            [tf5 becomeFirstResponder];
        }
    }
    if (textField == tf5) {
        if ([textField.text length] >= 1) {
            [tf6 becomeFirstResponder];
        }
    }
    if (textField == tf6) {
        if ([textField.text length] >= 1) {
            [tf6 resignFirstResponder];
        }
    }
    return YES;
}

@end

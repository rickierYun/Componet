//
//  FYXCheckView.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/12.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "FYXCheckView.h"

@implementation FYXCheckView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f];
        self.layer.cornerRadius = self.frame.size.width / 2;

        self.layer.transform = CATransform3DMakeScale(0, 0, 1);
        [UIView animateWithDuration:2 animations:^{
            self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        } completion:^(BOOL finished) {
            [self checkAnimation];
        }];

    }
    return self;
}

- (void)startAnimation {
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:1 animations:^{
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
    } completion:^(BOOL finished) {
        [self checkAnimation];
    }];
}
- (void)checkAnimation {
    CAShapeLayer *checkLayer = [CAShapeLayer layer];

    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect rectInCircle = CGRectInset(self.bounds, self.bounds.size.width*(1-1/sqrt(2.0))/2, self.bounds.size.width*(1-1/sqrt(2.0))/2);
    [path moveToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width*2/9, rectInCircle.origin.y + rectInCircle.size.height*3/5)];
    [path addLineToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width*4/9,rectInCircle.origin.y + rectInCircle.size.height*4/5)];
    [path addLineToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width*8/9, rectInCircle.origin.y + rectInCircle.size.height*3/10)];

    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = [UIColor whiteColor].CGColor;
    checkLayer.lineWidth = 5.0;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:checkLayer];


    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = 0.5f;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
//    checkAnimation.delegate = self;
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [checkLayer addAnimation:checkAnimation forKey:nil];
}
@end

//
//  FYXSideMenu.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/6.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "FYXSideMenu.h"

#define VIEW_ORIGIN(aView)       ((aView).frame.origin)
#define VIEW_X(aView)            ((aView).frame.origin.x)
#define VIEW_Y(aView)            ((aView).frame.origin.y)
#define VIEW_X_Right(aView)      ((aView).frame.origin.x + (aView).frame.size.width)
#define VIEW_Y_Bottom(aView)     ((aView).frame.origin.y + (aView).frame.size.height)

#define VIEW_SIZE(aView)         ((aView).frame.size)
#define VIEW_HEIGHT(aView)       ((aView).frame.size.height)
#define VIEW_WIDTH(aView)        ((aView).frame.size.width)

@implementation FYXSideMenu {
    UIView *backgroundView;     // 灰色背景
    UIView *bezierView;         // 画布view
    UIView *lightView;

    CGPoint pointA; //A
    CGPoint pointB; //B
    CGPoint pointD; //D
    CGPoint pointC; //C
    CGPoint pointE; //E
    CGPoint pointF; //F
    CGPoint pointG; //G
    CGPoint pointH; //H
    CGPoint pointI; //I
    CGPoint pointJ; //J
    CGPoint pointM; //M
    CGPoint pointN; //N
    CGPoint pointK; //K

    UIBezierPath *lake;
    CAShapeLayer *lakeShapLayer;
    UIBezierPath *rain;
    CAShapeLayer *rainShapLayer;
    CGFloat offsetX;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        backgroundView = [[UIView alloc]init];
        backgroundView.frame = self.bounds;
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 0.1;
        backgroundView.hidden = YES;
        [self addSubview:backgroundView];

        bezierView = [[UIView alloc]init];
        bezierView.frame = self.bounds;
        bezierView.backgroundColor = [UIColor clearColor];
        bezierView.alpha = 1;
        [self addSubview:bezierView];

        UIView *sideMenuView = [[UIView alloc]init];
        sideMenuView.frame = CGRectMake(-self.frame.size.width / 3 * 2 , 0, self.frame.size.width / 3 * 2, self.frame.size.height);
        sideMenuView.backgroundColor = [UIColor whiteColor];
        [self addSubview:sideMenuView];
        self.sideMenuView = sideMenuView;

        UIPanGestureRecognizer *backGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(backEdgeGuseture:)];
        [sideMenuView addGestureRecognizer:backGesture];

        lakeShapLayer = [CAShapeLayer layer];
        rainShapLayer = [CAShapeLayer layer];

        lightView = [[UIView alloc]init];
        lightView.frame = CGRectMake(VIEW_X_Right(sideMenuView) + 15, 48, 15, 15);
        lightView.layer.shouldRasterize = YES;
        lightView.layer.cornerRadius = VIEW_WIDTH(lightView) / 2;
        lightView.layer.shadowOpacity = 0.5;
        lightView.layer.shadowOffset = CGSizeMake(0, 0);
//        lightView.layer.shadowColor =   [UIColor  colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1].CGColor;
        lightView.layer.shadowColor = [UIColor orangeColor].CGColor;
        lightView.backgroundColor = [UIColor  colorWithRed:42.0 / 255 green:199.0 / 255 blue:244.0 / 255 alpha:0.6];
        lightView.hidden = YES;
        [self addSubview:lightView];
    }
    return self;
}

- (void)setSideMenuViewWidth: (CGFloat)width {
    self.sideMenuView.frame = CGRectMake(-width, 0, width, self.frame.size.height);
}

- (void)addgestureView: (UIView *)gestureView {
    // 添加左屏幕边缘的滑动手势
    UIScreenEdgePanGestureRecognizer *leftEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(leftEdgeGusture:)];
    leftEdgeGesture.edges = UIRectEdgeLeft;
    [gestureView addGestureRecognizer:leftEdgeGesture];
}

- (void)leftEdgeGusture: (UIScreenEdgePanGestureRecognizer *)gesture {
    self.hidden = NO;

    backgroundView.hidden = NO;

    CGPoint translation = [gesture translationInView:gesture.view];

    if (UIGestureRecognizerStateBegan == gesture.state || UIGestureRecognizerStateChanged == gesture.state) {
        if (translation.x <= self.sideMenuView.frame.size.width) {
            CGFloat x = translation.x - self.sideMenuView.frame.size.width;
            self.sideMenuView.frame = CGRectMake(x, 0, self.sideMenuView.frame.size.width, self.sideMenuView.frame.size.height);
            lightView.frame = CGRectMake(VIEW_X_Right(self.sideMenuView) + 12, 58, 15, 15);
//            lightView.hidden = NO;
            offsetX = translation.x / 5;
            [self drawRect];

        }else {
            self.sideMenuView.frame = CGRectMake(0, 0, self.sideMenuView.frame.size.width, self.sideMenuView.frame.size.height);
            bezierView.alpha = 0;
        }
    }else {
        if (translation.x <= self.sideMenuView.frame.size.width) {
            [UIView animateWithDuration:0.5 animations:^{
                self.sideMenuView.frame = CGRectMake(0, 0, self.sideMenuView.frame.size.width, self.sideMenuView.frame.size.height);
                bezierView.alpha = 0;
            }];
        }
    }

}

- (void)backEdgeGuseture: (UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:gesture.view];

    if (UIGestureRecognizerStateBegan == gesture.state || UIGestureRecognizerStateChanged == gesture.state) {
        if (translation.x >= -self.sideMenuView.frame.size.width && translation.x <=0) {

            self.sideMenuView.frame = CGRectMake(translation.x, 0, self.sideMenuView.frame.size.width, self.sideMenuView.frame.size.height);

        }else {
            [UIView animateWithDuration:0.5 animations:^{
                self.sideMenuView.frame = CGRectMake(-self.sideMenuView.frame.size.width, 0, self.sideMenuView.frame.size.width, self.sideMenuView.frame.size.height);
            }completion:^(BOOL finished) {
                self.hidden = YES;
            }];
        }
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            self.sideMenuView.frame = CGRectMake(-self.sideMenuView.frame.size.width, 0, self.sideMenuView.frame.size.width, self.sideMenuView.frame.size.height);

        }completion:^(BOOL finished) {
            bezierView.alpha = 1;
            self.hidden = YES;
        } ];
    }
}

- (void)drawRect {

    CGFloat offset = 14 / 3.6;
    rainShapLayer.path = nil;
    pointA = CGPointMake(VIEW_X_Right(self.sideMenuView), 45);
    pointF = CGPointMake(VIEW_X_Right(self.sideMenuView) + 8 , 48);
    pointB = CGPointMake(VIEW_X_Right(self.sideMenuView) + 10, 50);
    pointM = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + offsetX, 55 + offsetX / 4);
    pointH = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX, 60);
    pointC = CGPointMake(VIEW_X_Right(self.sideMenuView) + 23 + offsetX, 65);
    pointI = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX, 70);
    pointN = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + offsetX, 75 - offsetX / 4);
    pointD = CGPointMake(VIEW_X_Right(self.sideMenuView) + 10 , 80);
    pointG = CGPointMake(VIEW_X_Right(self.sideMenuView) + 8, 82);
    pointE = CGPointMake(VIEW_X_Right(self.sideMenuView), 85);

    lake = [UIBezierPath bezierPath];
    [lake moveToPoint:pointA];

    [lake addQuadCurveToPoint:pointB controlPoint:pointF];

    if (offsetX >0 && offsetX < 22) {   // 初始半圆
        pointM = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + offsetX / 2, 55 - offsetX / 5);
        pointN = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + offsetX / 2, 75 + offsetX / 5);
        pointJ = CGPointMake(VIEW_X_Right(self.sideMenuView) + 13 + offsetX, 55 + offsetX );
        pointK = CGPointMake(VIEW_X_Right(self.sideMenuView) + 13 + offsetX, 75 - offsetX );
        pointC = CGPointMake(VIEW_X_Right(self.sideMenuView) + 24 + offsetX, 65);
        [lake addCurveToPoint:pointH controlPoint1:pointJ controlPoint2:pointM];
        [lake addQuadCurveToPoint:pointI controlPoint:pointC];
        [lake addCurveToPoint:pointD controlPoint1:pointN controlPoint2:pointK];
    }else if (offsetX >= 22 && offsetX < 30) {   // 水滴开始离开
        pointM = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + offsetX / 2, 55 - offsetX / 5);
        pointN = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + offsetX / 2, 75 + offsetX / 5);
        pointJ = CGPointMake(VIEW_X_Right(self.sideMenuView) + 13 + offsetX, 65 + offsetX / 2);
        pointK = CGPointMake(VIEW_X_Right(self.sideMenuView) + 13 + offsetX, 65 - offsetX / 2);
        pointC = CGPointMake(VIEW_X_Right(self.sideMenuView) + 23 + offsetX + 2, 65);
        [lake addCurveToPoint:pointH controlPoint1:pointJ controlPoint2:pointM];
        [lake addQuadCurveToPoint:pointI controlPoint:pointC];
        [lake addCurveToPoint:pointD controlPoint1:pointN controlPoint2:pointK];
    }else if (offsetX >= 30 && offsetX <= 35){     // 水滴形成，形成丝状
        pointM = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + 15, 55 - 6);
        pointN = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + 15, 75 + 6);
        pointJ = CGPointMake(VIEW_X_Right(self.sideMenuView) + 13 + offsetX, 65 + offsetX / 2);
        pointK = CGPointMake(VIEW_X_Right(self.sideMenuView) + 13 + offsetX, 65 - offsetX / 2);
        pointC = CGPointMake(VIEW_X_Right(self.sideMenuView) + 23 + offsetX + 2, 65);
        [lake addCurveToPoint:pointH controlPoint1:pointJ controlPoint2:pointM];
        [lake addQuadCurveToPoint:pointI controlPoint:pointC];
        [lake addCurveToPoint:pointD controlPoint1:pointN controlPoint2:pointK];
    }else if (offsetX > 35){    // 完全分离
        pointJ = CGPointMake(VIEW_X_Right(self.sideMenuView) + 25 , 65);
        pointC = CGPointMake(VIEW_X_Right(self.sideMenuView) + 27 + offsetX, 65);
        pointK = CGPointMake(VIEW_X_Right(self.sideMenuView) + 14 + offsetX, 65);
        pointH = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX, 58);
        pointI = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX, 72);

        pointM = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX + offset , 58);
        pointN = CGPointMake(VIEW_X_Right(self.sideMenuView) + 14 + offsetX , 65 + offset);
        CGPoint pointM2 = CGPointMake(VIEW_X_Right(self.sideMenuView) + 27 + offsetX, 65 - offset);
        CGPoint pointM3 = CGPointMake(VIEW_X_Right(self.sideMenuView) + 14 + offsetX, 65 - offset);
        CGPoint pointM4 = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX - offset, 58);
        CGPoint pointN2 = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX + offset, 72);
        CGPoint pointN3 = CGPointMake(VIEW_X_Right(self.sideMenuView) + 27 + offsetX , 65 + offset);
        CGPoint pointN4 = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX - offset, 72);
        [lake addQuadCurveToPoint:pointD controlPoint:pointJ];
        rain = [UIBezierPath bezierPath];
        [rain moveToPoint:pointH];
        [rain addCurveToPoint:pointC controlPoint1:pointM controlPoint2:pointM2];
        [rain addCurveToPoint:pointI controlPoint1:pointN3 controlPoint2: pointN2];
        [rain addCurveToPoint:pointK controlPoint1:pointN4 controlPoint2:pointN];
        [rain addCurveToPoint:pointH controlPoint1:pointM3 controlPoint2:pointM4];
        if (offsetX >= 40) {
            CGFloat alpha = 1 - (offsetX - 40) / 10;
            if (alpha <=0) {
                bezierView.alpha = 0;
            }else {
                bezierView.alpha = alpha;
            }

        }
    }else {
        [lake addQuadCurveToPoint:pointH controlPoint:pointM];
        [lake addQuadCurveToPoint:pointI controlPoint:pointC];
        [lake addQuadCurveToPoint:pointD controlPoint:pointN];
    }

    // 放置画布，避免error log
    UIGraphicsBeginImageContext(self.bounds.size);
    if (offsetX > 35) {
        [rain stroke];

        rainShapLayer.fillColor = [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:0.4].CGColor;;
        rainShapLayer.path = rain.CGPath;
        [bezierView.layer addSublayer:rainShapLayer];
    }

    [lake addQuadCurveToPoint:pointE controlPoint:pointG];
    [lake addLineToPoint:pointA];

    [lake stroke];

    lakeShapLayer.fillColor = [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:0.4].CGColor;
    lakeShapLayer.path = lake.CGPath;
    lakeShapLayer.lineWidth = 2;
    UIGraphicsEndImageContext();
    [bezierView.layer addSublayer:lakeShapLayer];

}

@end

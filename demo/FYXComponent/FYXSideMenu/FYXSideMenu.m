//
//  FYXSideMenu.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/6.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "FYXSideMenu.h"
#import "UIView+GlowView.h"

#define VIEW_ORIGIN(aView)       ((aView).frame.origin)
#define VIEW_X(aView)            ((aView).frame.origin.x)
#define VIEW_Y(aView)            ((aView).frame.origin.y)
#define VIEW_X_Right(aView)      ((aView).frame.origin.x + (aView).frame.size.width)
#define VIEW_Y_Bottom(aView)     ((aView).frame.origin.y + (aView).frame.size.height)

#define VIEW_SIZE(aView)         ((aView).frame.size)
#define VIEW_HEIGHT(aView)       ((aView).frame.size.height)
#define VIEW_WIDTH(aView)        ((aView).frame.size.width)

#define WEAK_SELF __weak typeof(self)weakSelf = self
@implementation FYXSideMenu {
    UIView *bezierView;         // 画布view
    UIView *lightView;
    UIButton *lightBtn;

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
    CGFloat translationX;
    CADisplayLink *_link;
    UIImageView *animationImgV;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *backgroundView = [[UIView alloc]init];
        backgroundView.frame = self.bounds;
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 0.1;
        backgroundView.hidden = YES;
        [self addSubview:backgroundView];
        self.backgroundView = backgroundView;

        UIButton *backgroundBtn = [[UIButton alloc]init];
        backgroundBtn.frame = self.bounds;
        [backgroundBtn addTarget:self action:@selector(sideMenuHidden) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:backgroundBtn];

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

//        UIPanGestureRecognizer *backGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(backEdgeGuseture:)];
//        [backgroundView addGestureRecognizer:backGesture];

        lakeShapLayer = [CAShapeLayer layer];
        rainShapLayer = [CAShapeLayer layer];

        animationImgV = [[UIImageView alloc]init];
        animationImgV.frame = CGRectMake(0, 20, 60, 121);
        [self addSubview:animationImgV];

    }
    return self;
}

- (void) setSideMenY:(CGFloat)sideMenY {
    animationImgV.frame = CGRectMake(0, 20 + sideMenY, 60, 121);
//    self.sideMenY = sideMenY;
}

- (void)setSideMenuViewWidth: (CGFloat)width {
    self.sideMenuView.frame = CGRectMake(-width, 0, width, self.frame.size.height);
}

- (void)addgestureView: (UIView *)gestureView hideView: (UIView *)hideView {
    // 添加左屏幕边缘的滑动手势
    UIScreenEdgePanGestureRecognizer *leftEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(leftEdgeGusture:)];
    leftEdgeGesture.edges = UIRectEdgeLeft;
    [gestureView addGestureRecognizer:leftEdgeGesture];
    lightView = hideView;
}


- (void)leftEdgeGusture: (UIScreenEdgePanGestureRecognizer *)gesture {
//    self.hidden = NO;
//
//    self.backgroundView.hidden = NO;
//
//    [self startAnimation];

//    CGPoint translation = [gesture translationInView:gesture.view];

//    if (UIGestureRecognizerStateBegan == gesture.state || UIGestureRecognizerStateChanged == gesture.state) {
//        if (translation.x <= self.sideMenuView.frame.size.width) {
//            CGFloat x = translation.x - self.sideMenuView.frame.size.width;
//            self.sideMenuView.frame = CGRectMake(x, 0, self.sideMenuView.frame.size.width, self.sideMenuView.frame.size.height);
//            lightView.hidden = YES;
//            offsetX = translation.x / 5 ;
//            bezierView.hidden = NO;
//            [self drawRect];
//
//        }else {
//            self.sideMenuView.frame = CGRectMake(0, 0, self.sideMenuView.frame.size.width, self.sideMenuView.frame.size.height);
//            bezierView.alpha = 0;
//        }

//    }else {
//        if (translation.x <= self.sideMenuView.frame.size.width) {
//            [UIView animateWithDuration:0.5 animations:^{
//                self.sideMenuView.frame = CGRectMake(0, 0, self.sideMenuView.frame.size.width, self.sideMenuView.frame.size.height);
//                bezierView.alpha = 0;
//            }];
//
//
//        }
//    }

}

- (void)backEdgeGuseture: (UIPanGestureRecognizer *)gesture {
//    CGPoint translation = [gesture translationInView:gesture.view];


//    if (UIGestureRecognizerStateBegan == gesture.state || UIGestureRecognizerStateChanged == gesture.state) {
//        if (translation.x >= -self.sideMenuView.frame.size.width && translation.x <=0) {
//
//            self.sideMenuView.frame = CGRectMake(translation.x, 0, self.sideMenuView.frame.size.width, self.sideMenuView.frame.size.height);
//
//        }else {
//            [UIView animateWithDuration:0.5 animations:^{
//                self.sideMenuView.frame = CGRectMake(-self.sideMenuView.frame.size.width, 0, self.sideMenuView.frame.size.width, self.sideMenuView.frame.size.height);
//            }completion:^(BOOL finished) {
//                self .hidden = YES;
//                bezierView.hidden = YES;
//            }];
//        }

//    }else {
    WEAK_SELF;
    [UIView animateWithDuration:3 animations:^{
        weakSelf.sideMenuView.frame = CGRectMake(-weakSelf.sideMenuView.frame.size.width, 0,    weakSelf.sideMenuView.frame.size.width, weakSelf.sideMenuView.frame.size.height);
        animationImgV.frame =  CGRectMake(0, VIEW_Y(animationImgV), 60, 121);
    }completion:^(BOOL finished) {
        bezierView.hidden = YES;
        bezierView.alpha = 1;
        weakSelf.hidden = YES;
        lightView.hidden = NO;
    } ];
//    }

}

- (void)clickDraw {
    self.hidden = NO;
    self.backgroundView.hidden = NO;
    bezierView.alpha = 1;
    bezierView.hidden = NO;
    lightView.hidden = YES;
    offsetX = 0;
    translationX = -self.sideMenuView.frame.size.width;
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(Addistance)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _link.paused = NO;
}

- (void)Addistance {
    translationX += 5; // 速度
    offsetX = (translationX + VIEW_WIDTH(self.sideMenuView)) / 5;
    self.sideMenuView.frame = CGRectMake(translationX, 0, self.sideMenuView.frame.size.width, self.sideMenuView.frame.size.height);
//    [self drawRect];
    if (translationX >= 0) {
        self.sideMenuView.frame = CGRectMake(0, 0, self.sideMenuView.frame.size.width, self.sideMenuView.frame.size.height);
        _link.paused = YES;
    }
}

//- (void)drawRect {
//
//    CGFloat offset = 18 / 3.6;
//    rainShapLayer.path = nil;
//    pointA = CGPointMake(VIEW_X_Right(self.sideMenuView), 45 + self.sideMenY);
//    pointF = CGPointMake(VIEW_X_Right(self.sideMenuView) + 8 , 48 + self.sideMenY);
//    pointB = CGPointMake(VIEW_X_Right(self.sideMenuView) + 10, 50+ self.sideMenY);
//    pointM = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + offsetX, 55 + offsetX / 4 + self.sideMenY);
//    pointH = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX, 58 + self.sideMenY);
//    pointC = CGPointMake(VIEW_X_Right(self.sideMenuView) + 27 + offsetX, 65 + self.sideMenY);
//    pointI = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX, 72 + self.sideMenY);
//    pointN = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + offsetX, 75 - offsetX / 4 + self.sideMenY);
//    pointD = CGPointMake(VIEW_X_Right(self.sideMenuView) + 10 , 80 + self.sideMenY);
//    pointG = CGPointMake(VIEW_X_Right(self.sideMenuView) + 8, 82 + self.sideMenY);
//    pointE = CGPointMake(VIEW_X_Right(self.sideMenuView), 85 + self.sideMenY);
//
//    lake = [UIBezierPath bezierPath];
//    [lake moveToPoint:pointA];
//
//    if (offsetX >0 && offsetX < 22) {           // 初始半圆
//        pointM = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + offsetX / 2, 55 - offsetX / 5 + self.sideMenY);
//        pointN = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + offsetX / 2, 75 + offsetX / 5 + self.sideMenY);
//        pointJ = CGPointMake(VIEW_X_Right(self.sideMenuView) + 13 + offsetX, 55 + offsetX + self.sideMenY);
//        pointK = CGPointMake(VIEW_X_Right(self.sideMenuView) + 13 + offsetX, 75 - offsetX + self.sideMenY);
//        pointC = CGPointMake(VIEW_X_Right(self.sideMenuView) + 27 + offsetX, 65 + self.sideMenY);
//
////        [lake addQuadCurveToPoint:pointB controlPoint:pointF];
//        [lake addCurveToPoint:pointH controlPoint1:pointJ controlPoint2:pointM];
//        [lake addQuadCurveToPoint:pointI controlPoint:pointC];
//        [lake addCurveToPoint:pointE controlPoint1:pointN controlPoint2:pointK];
//    }else if (offsetX >= 22 && offsetX < 30) {   // 水滴开始离开
//        pointM = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + offsetX / 2, 55 - offsetX / 5 + self.sideMenY);
//        pointN = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + offsetX / 2, 75 + offsetX / 5 + self.sideMenY);
//        pointJ = CGPointMake(VIEW_X_Right(self.sideMenuView) + 13 + offsetX, 65 + offsetX / 2 + self.sideMenY);
//        pointK = CGPointMake(VIEW_X_Right(self.sideMenuView) + 13 + offsetX, 65 - offsetX / 2 + self.sideMenY);
//        pointC = CGPointMake(VIEW_X_Right(self.sideMenuView) + 25 + offsetX + 2, 65 + self.sideMenY);
//
////        [lake addQuadCurveToPoint:pointB controlPoint:pointF];
//        [lake addCurveToPoint:pointH controlPoint1:pointJ controlPoint2:pointM];
//        [lake addQuadCurveToPoint:pointI controlPoint:pointC];
//        [lake addCurveToPoint:pointE controlPoint1:pointN controlPoint2:pointK];
//    }else if (offsetX >= 30 && offsetX <= 40){     // 水滴形成，形成丝状
//        pointM = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + 15, 55 - 6 + self.sideMenY);
//        pointN = CGPointMake(VIEW_X_Right(self.sideMenuView) + 18 + 15, 75 + 6 + self.sideMenY);
//        pointJ = CGPointMake(VIEW_X_Right(self.sideMenuView) + 13 + offsetX, 65 + offsetX / 2 + self.sideMenY);
//        pointK = CGPointMake(VIEW_X_Right(self.sideMenuView) + 13 + offsetX, 65 - offsetX / 2 + self.sideMenY);
//        pointC = CGPointMake(VIEW_X_Right(self.sideMenuView) + 25 + offsetX + 2, 65 + self.sideMenY);
////        [lake addQuadCurveToPoint:pointB controlPoint:pointF];
//        [lake addCurveToPoint:pointH controlPoint1:pointJ controlPoint2:pointM];
//        [lake addQuadCurveToPoint:pointI controlPoint:pointC];
//        [lake addCurveToPoint:pointE controlPoint1:pointN controlPoint2:pointK];
//    }else if (offsetX > 40){    // 完全分离
//        pointJ = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 , 65 + self.sideMenY);
//        pointC = CGPointMake(VIEW_X_Right(self.sideMenuView) + 29 + offsetX, 65 + self.sideMenY);
//        pointK = CGPointMake(VIEW_X_Right(self.sideMenuView) + 11 + offsetX, 65 + self.sideMenY);
//        pointH = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX, 56 + self.sideMenY);
//        pointI = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX, 74 + self.sideMenY);
//        pointM = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX + offset , 56 + self.sideMenY);
//        pointN = CGPointMake(VIEW_X_Right(self.sideMenuView) + 11 + offsetX , 65 + offset + self.sideMenY);
//
//        CGPoint pointM2 = CGPointMake(VIEW_X_Right(self.sideMenuView) + 29 + offsetX, 65 - offset + self.sideMenY);
//        CGPoint pointM3 = CGPointMake(VIEW_X_Right(self.sideMenuView) + 11 + offsetX, 65 - offset + self.sideMenY);
//        CGPoint pointM4 = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX - offset, 56 + self.sideMenY);
//        CGPoint pointN2 = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX + offset, 74 + self.sideMenY);
//        CGPoint pointN3 = CGPointMake(VIEW_X_Right(self.sideMenuView) + 29 + offsetX , 65 + offset + self.sideMenY);
//        CGPoint pointN4 = CGPointMake(VIEW_X_Right(self.sideMenuView) + 20 + offsetX - offset, 74 + self.sideMenY);
//        [lake addQuadCurveToPoint:pointE controlPoint:pointJ];
//        rain = [UIBezierPath bezierPath];
//        [rain moveToPoint:pointH];
//        [rain addCurveToPoint:pointC controlPoint1:pointM controlPoint2:pointM2];
//        [rain addCurveToPoint:pointI controlPoint1:pointN3 controlPoint2: pointN2];
//        [rain addCurveToPoint:pointK controlPoint1:pointN4 controlPoint2:pointN];
//        [rain addCurveToPoint:pointH controlPoint1:pointM3 controlPoint2:pointM4];
//        if (offsetX >= 45) {
//            CGFloat alpha = 1 - (offsetX - 40) / 10;
//            if (alpha <=0) {
//                bezierView.alpha = 0;
//            }else {
//                bezierView.alpha = alpha;
//            }
//        }
//    }else {
////        [lake addQuadCurveToPoint:pointB controlPoint:pointF];
//        [lake addQuadCurveToPoint:pointH controlPoint:pointM];
//        [lake addQuadCurveToPoint:pointI controlPoint:pointC];
//        [lake addQuadCurveToPoint:pointE controlPoint:pointN];
//    }
//
//    // 放置画布，避免error log
//    UIGraphicsBeginImageContext(self.bounds.size);
//    if (offsetX > 40) {
//        [rain stroke];
//
//        rainShapLayer.fillColor = [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:0.4].CGColor;;
//        rainShapLayer.path = rain.CGPath;
//        [bezierView.layer addSublayer:rainShapLayer];
//    }
//
////    [lake addQuadCurveToPoint:pointE controlPoint:pointG];
//    [lake addLineToPoint:pointA];
//
//    [lake stroke];
//
//    lakeShapLayer.fillColor = [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:0.4].CGColor;
//    lakeShapLayer.path = lake.CGPath;
//    lakeShapLayer.lineWidth = 2;
//    UIGraphicsEndImageContext();
//    [bezierView.layer addSublayer:lakeShapLayer];
//
//}

// 隐藏侧边栏
- (void)sideMenuHidden {
    WEAK_SELF;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.sideMenuView.frame = CGRectMake(-weakSelf.sideMenuView.frame.size.width, 0, weakSelf.sideMenuView.frame.size.width, weakSelf.sideMenuView.frame.size.height);
        animationImgV.frame =  CGRectMake(0, VIEW_Y(animationImgV), 60, 121);
    }completion:^(BOOL finished) {
        bezierView.hidden = YES;
        bezierView.alpha = 1;
        weakSelf.hidden = YES;
        lightView.hidden = NO;
    } ];
}

// 帧动画
- (void)startAnimation {
    self.hidden = NO;
    self.backgroundView.hidden = NO;
    NSMutableArray<UIImage *> *imageArr = [NSMutableArray array];
    for (int i=0; i<51; i++) {
        // 获取图片的名称
        NSString *imageName;
        if (i < 10) {
            imageName = [NSString stringWithFormat:@"td2__0000%d", i];
        }else {
            imageName = [NSString stringWithFormat:@"td2__000%d", i];
        }
        // 创建UIImage对象
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];

        UIImage *image = [UIImage imageWithData:data];
        // 加入数组
        [imageArr addObject:image];
    }

    animationImgV.animationImages = imageArr;
    animationImgV.animationRepeatCount = 1;
    animationImgV.animationDuration = 1;
    [animationImgV startAnimating];
    WEAK_SELF;
    [UIView animateWithDuration:1 animations:^{
        animationImgV.frame = CGRectMake(VIEW_WIDTH(weakSelf.sideMenuView), VIEW_Y(animationImgV),60, 121);
        weakSelf.sideMenuView.frame = CGRectMake(0, 0, weakSelf.sideMenuView.frame.size.width, weakSelf.sideMenuView.frame.size.height);

        bezierView.alpha = 0;

    } completion:^(BOOL finished) {
        [weakSelf stopAnimation];
    }];
}

- (void)stopAnimation {
    [animationImgV stopAnimating];
    animationImgV.animationImages = nil;
}
@end

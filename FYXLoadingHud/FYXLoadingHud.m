//
//  FYXLoadingHud.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/12.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "FYXLoadingHud.h"

#define NormalColor [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f]

@implementation FYXLoadingHud

{
    CADisplayLink *_link;
    CAShapeLayer *_animationLayer;

    CGFloat _startAngle;
    CGFloat _endAngle;
    CGFloat _progress; // 进度状态
}

+(FYXLoadingHud*)showIn:(UIView*)view{
    [self hideIn:view];
    FYXLoadingHud *hud = [[FYXLoadingHud alloc] initWithFrame:view.bounds];
    [hud start];
    [view addSubview:hud];
    return hud;
}

+(FYXLoadingHud *)hideIn:(UIView *)view{
    FYXLoadingHud *hud = nil;
    for (FYXLoadingHud *subView in view.subviews) {
        if ([subView isKindOfClass:[FYXLoadingHud class]]) {
            [subView hide];
            [subView removeFromSuperview];
            hud = subView;
        }
    }
    return hud;
}

-(void)start{
    _link.paused = false;
}

-(void)hide{
    _link.paused = true;
    _progress = 0;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    // 添加渐变
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[
                             (id)[UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f].CGColor,
                             (id)[UIColor colorWithRed:11.0 / 255 green:171.0 / 255 blue:254.0 / 255 alpha:1.0f].CGColor,
                             (id)[UIColor blueColor].CGColor
                             ];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    [self.layer addSublayer:gradientLayer];

    _animationLayer = [CAShapeLayer layer];
    _animationLayer.frame = CGRectMake(self.bounds.size.width/2.0f - 30, self.bounds.size.height/2.0 - 30, 80, 80);
    _animationLayer.fillColor = [UIColor clearColor].CGColor;
    _animationLayer.strokeColor = NormalColor.CGColor;
    _animationLayer.lineWidth = 5.0;
    _animationLayer.lineCap = kCALineCapRound;
    [gradientLayer setMask:_animationLayer];

    // 动画循环
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _link.paused = true;

}

-(void)displayLinkAction{
    _progress += [self speed];
    if (_progress >= 1) {
        _progress = 0;
    }
    [self updateAnimationLayer];
}

-(void)updateAnimationLayer{
    // 开始角度
    _startAngle = -M_PI_2;
    // 结束角度
    _endAngle = -M_PI_2 +_progress * M_PI * 2;
    // 判断角度，当角度大于180时开始缩减
    if (_endAngle > M_PI) {
        CGFloat progress1 = 1 - (1 - _progress)/0.25;
        _startAngle = -M_PI_2 + progress1 * M_PI * 2;
    }
    CGFloat radius = _animationLayer.bounds.size.width/2.0f - 5/2.0;
    CGFloat centerX = _animationLayer.bounds.size.width/2.0f;
    CGFloat centerY = _animationLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;

    _animationLayer.path = path.CGPath;
}

-(CGFloat)speed{
    if (_endAngle > M_PI) {
        return 0.3/60.0f;
    }
    return 2/60.0f;
}


@end

//
//  FYXToast.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/23.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "FYXToast.h"

@implementation FYXToast

- (id)initWithText:(NSString *)text_ imageName:(NSString *)imageName{
    if (self = [super init]) {

        text = [text_ copy];

        // 文字部分
        UIFont *font = [UIFont boldSystemFontOfSize:14];
        NSDictionary *attrs = @{NSFontAttributeName : font};
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;                    // 随字数，字体扩展大小
        UILabel *textLabel = [[UILabel alloc]init];

        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        if ([text length] > 20) {
            textLabel.textAlignment = NSTextAlignmentLeft;
        }
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;

        // 显示view
        contentView = [[UIButton alloc] init];
        if (imageName != nil) {
            // 设置图片
            textLabel.frame = CGRectMake(30, 50, textSize.width + 12, textSize.height + 12);
            contentView.frame = CGRectMake(0, 0, textLabel.frame.size.width + 60, textLabel.frame.size.height + 70);

            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(contentView.center.x - 13, 15, 26, 26)];
            imageView.image = [UIImage imageNamed:imageName];
            [contentView addSubview:imageView];
        }else {
            textLabel.frame = CGRectMake(20, 15, textSize.width + 12, textSize.height + 12);
            contentView.frame = CGRectMake(0, 0, textLabel.frame.size.width + 40, textLabel.frame.size.height + 30);
        }
        contentView.layer.cornerRadius = 5.0f;
        contentView.layer.borderWidth = 1.0f;
        contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        contentView.backgroundColor = [UIColor colorWithRed:0.0f
                                                      green:0.0f
                                                       blue:0.0f
                                                      alpha:0.7f];
        [contentView addSubview:textLabel];
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;         // 自适应
        [contentView addTarget:self
                        action:@selector(toastTaped:)
              forControlEvents:UIControlEventTouchDown];
        contentView.alpha = 0.0f;

        duration = DEFAULT_DISPLAY_DURATION;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
    }
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)notify_{
    [self hideAnimation];
}

-(void)toastTaped:(UIButton *)sender_{
    [self hideAnimation];
}

-(void)hideAnimation{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.userInteractionEnabled = YES;
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    contentView.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void)setDuration:(CGFloat) duration_{
    duration = duration_;
}

-(void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    contentView.alpha = 1.0f;
    [UIView commitAnimations];
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    contentView.center = window.center;         // 始终中间显示
    [window  addSubview:contentView];
    if (window.subviews.count > 0) {
        [window bringSubviewToFront:contentView];
    }
    window.userInteractionEnabled = NO;
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];
}

- (void)showAct{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    contentView.center = window.center;
    [window  addSubview:contentView];
    window.userInteractionEnabled = NO;
    if (window.subviews.count > 0) {
        [window bringSubviewToFront:contentView];
    }
    [self showAnimation];
}

- (void)sepecialShow:  (CGRect)frame {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *v = [[UIView alloc]init];
    v.frame = frame;
    [window addSubview: v];

    NSLog(@"%@",NSStringFromCGPoint(v.center) );
    contentView.frame = CGRectMake(v.center.x - contentView.frame.size.width / 2, 0, contentView.frame.size.width, contentView.frame.size.height);         // 始终中间显示
    [v addSubview:contentView];

    if (window.subviews.count > 0) {
        [window bringSubviewToFront:v];
    }
    window.userInteractionEnabled = NO;
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];

}

- (void)imageSepecialShow: (CGRect)frame {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *v = [[UIView alloc]init];
    v.frame = frame;
    [window addSubview: v];

    NSLog(@"%@",NSStringFromCGPoint(v.center) );
    contentView.frame = CGRectMake(v.center.x - contentView.frame.size.width / 2, 0, contentView.frame.size.width, contentView.frame.size.height);         // 始终中间显示
    [v addSubview:contentView];
    if (window.subviews.count > 0) {
        [window bringSubviewToFront:v];
    }
    window.userInteractionEnabled = NO;
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];
}

-(void)dismissToast{
    [contentView removeFromSuperview];
}

#pragma -mark show
+ (void)showWithText:(NSString *)text{
    [FYXToast showWithText:text duration:DEFAULT_DISPLAY_DURATION];
}

+ (void)showWithText:(NSString *)text duration:(CGFloat)duration{
    FYXToast *toast = [[FYXToast alloc] initWithText:text imageName:nil];
    [toast setDuration:duration];
    [toast show];
}

+ (void)showWithTextImage:(NSString *)text imageName:(NSString *)imageName{
    [FYXToast showwithTextImage:text imageName:imageName duration:DEFAULT_DISPLAY_DURATION];
}

+ (void)showwithTextImage:(NSString *)text imageName:(NSString *)imageName duration:(CGFloat)duration{
    FYXToast *toast = [[FYXToast alloc] initWithText:text imageName:imageName];
    [toast setDuration: duration];
    [toast show];
}

+ (void)showWithImageFrame: (NSString *)text imageName: (NSString *)imageName frame: (CGRect)frame {
    [FYXToast showWithImageFrame:text imageName:imageName frame:frame duration:DEFAULT_DISPLAY_DURATION];
}

+ (void)showWithImageFrame: (NSString *)text imageName: (NSString *)imageName frame: (CGRect)frame duration: (CGFloat)duration {
    FYXToast *toast = [[FYXToast alloc] initWithText:text imageName:imageName];
    [toast setDuration:duration];
    [toast sepecialShow:frame];
}

+ (void)showWithFrame:(NSString *)text frame: (CGRect)frame {
    [FYXToast showWithFrame:text frame:frame duration:DEFAULT_DISPLAY_DURATION];
}
+ (void)showWithFrame:(NSString *)text frame: (CGRect)frame duration:(CGFloat)duration {
    FYXToast *toast = [[FYXToast alloc] initWithText:text imageName:nil];
    [toast setDuration:duration];
    [toast sepecialShow:frame];
}
@end

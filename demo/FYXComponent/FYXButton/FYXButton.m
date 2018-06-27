//
//  FYXButton.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/2/23.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "FYXButton.h"

@implementation FYXButton

- (id)initWithFrame: (CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor getMainGradientColor:frame];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:18 ];
    }
    return self;
}


@end

#pragma -mark 扩展颜色（渐变色）
@implementation UIColor (BtnBGColor)
+ (UIColor *)getMainGradientColor:(CGRect)frame{
    return [UIColor colorWithPatternImage:[UIColor BgImageFromColorswithFrame:frame]];
}

+ (UIImage*) BgImageFromColorswithFrame: (CGRect)frame

{
    // 渐变色值范围
    NSMutableArray *colorArray = [@[[UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f],
                                    [UIColor colorWithRed:11.0 / 255 green:171.0 / 255 blue:254.0 / 255 alpha:1.0f]] mutableCopy];

    NSMutableArray *ar = [NSMutableArray array];

    for(UIColor *c in colorArray) {

        [ar addObject:(id)c.CGColor];

    }

    UIGraphicsBeginImageContextWithOptions(frame.size, YES, 1);

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSaveGState(context);

    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colorArray lastObject] CGColor]);

    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);

    CGPoint start;

    CGPoint end;



    start = CGPointMake(0.0, frame.size.height);

    end = CGPointMake(frame.size.width, 0.0);



    CGContextDrawLinearGradient(context, gradient, start, end,kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    CGGradientRelease(gradient);

    CGContextRestoreGState(context);

    CGColorSpaceRelease(colorSpace);

    UIGraphicsEndImageContext();

    return image;

}
@end

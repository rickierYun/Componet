//
//  FYXPageFlowLayout.h
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/8.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FYXPageFlowLayoutDelegate <NSObject>

- (void)scrollToPageIndex:(NSInteger)index;

@end

@interface FYXPageFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) int pageNum;
@property (nonatomic, assign) CGFloat previousOffsetX;
@property (nonatomic, assign) CGFloat pageCardWidth;
@property (nonatomic, assign) CGFloat pageCardHeight;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, weak) id<FYXPageFlowLayoutDelegate> delegate;
@end

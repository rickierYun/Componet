//
//  FYXPageFlow.h
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/6.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYXPageFlowLayout.h"

@class FYXPageFlow;

@protocol FYXPageFlowDataSource <NSObject>
@optional
/**
 * 卡片数量
 */
- (NSInteger)numberOfPageFlow: (FYXPageFlow *)pageFlow;
/**
 * 自定义cell
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface FYXPageFlow : UIView <UICollectionViewDelegate,UICollectionViewDataSource,FYXPageFlowLayoutDelegate>

/**
 *  滑动主体
 */
@property (nonatomic, weak) UICollectionView *collectionView;
/**
 * flowLayout
 */
@property (nonatomic, strong) FYXPageFlowLayout *flowLayout;
/**
 * pageControl
 */
@property (nonatomic, weak) UIPageControl *pageControl;
/**
 * sectionCount
 */
@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, weak) id<FYXPageFlowDataSource>dataSource;

/**
 *  设置每个卡片的大小和间距
 */
- (void)setPageSize: (CGFloat)width height:(CGFloat)height lineSpace:(CGFloat)lineSpace;
@end



@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) UIView *cellView;
@end

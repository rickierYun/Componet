//
//  FYXPageFlowLayout.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/8.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "FYXPageFlowLayout.h"


@implementation FYXPageFlowLayout {
    NSMutableArray *insertIndexPathArr;
}

- (void)prepareLayout{

    [super prepareLayout];
    //滑动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //两个cell的间距
    self.minimumLineSpacing = _lineSpace;
    //计算cell超出显示的宽度
//    CGFloat width = ((self.collectionView.frame.size.width - kPageCardWidth)-(kLineSpace*2))/2;
    //每个section的间距
    self.sectionInset = UIEdgeInsetsMake(0, _lineSpace, 0, 0);
    //每个cell实际的大小
    self.itemSize = CGSizeMake(_pageCardWidth,_pageCardHeight);

}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *superAttributes = [super layoutAttributesForElementsInRect:rect];
    NSArray *attributes = [[NSArray alloc] initWithArray:superAttributes copyItems:YES];

    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x,
                                    self.collectionView.contentOffset.y,
                                    self.collectionView.frame.size.width,
                                    self.collectionView.frame.size.height);
    CGFloat offset = CGRectGetMidX(visibleRect);

    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat distance = offset - attribute.center.x;
        // 越往中心移动，值越小，那么缩放就越小，从而显示就越大
        // 同样，超过中心后，越往左、右走，缩放就越大，显示就越小
        CGFloat scaleForDistance = distance / self.itemSize.width;
        // 0.1可调整，值越大，显示就越大
        CGFloat scaleForCell = 1 + 0.09 * (1 - fabs(scaleForDistance));
        
        //只在Y轴方向做缩放
        attribute.transform3D =  CATransform3DMakeScale(1, scaleForCell, 1);
        attribute.zIndex = 1;

        //渐变
        CGFloat scaleForAlpha = 1 - fabs(scaleForDistance)*0.6;
        attribute.alpha = scaleForAlpha;
    }];

    return attributes;
}

- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems {
    [super prepareForCollectionViewUpdates:updateItems];
    insertIndexPathArr = [NSMutableArray array];
    for (UICollectionViewUpdateItem *item in updateItems) {
        switch (item.updateAction) {
            case UICollectionUpdateActionInsert:
                [insertIndexPathArr addObject:item.indexPathAfterUpdate];
                break;
            default:
                break;
        }
    }
}


- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *attributes = [[super layoutAttributesForItemAtIndexPath:itemIndexPath] copy];
    if ([insertIndexPathArr containsObject:itemIndexPath]) {
        attributes.alpha = 0;
    }
    attributes.transform = CGAffineTransformMakeScale(0, 0);

    return attributes;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *attributes = [[self layoutAttributesForItemAtIndexPath:itemIndexPath] copy];
    attributes.frame = [self frameWithIndexPath:[NSIndexPath indexPathForRow:itemIndexPath.row inSection:itemIndexPath.section +1] selectIndexPath:itemIndexPath];
    return attributes;

}

- (CGRect)frameWithIndexPath: (NSIndexPath *)indexPath selectIndexPath: (NSIndexPath *)selectIndexPath {
    CGFloat left;
    CGFloat width;
    if (indexPath.section < selectIndexPath.section) {
        left = indexPath.section * (self.itemSize.width + self.minimumInteritemSpacing);
        width = self.itemSize.width;
    }else if (indexPath.section == selectIndexPath.section) {
        left = indexPath.section * (self.itemSize.width + self.minimumInteritemSpacing) + self.minimumInteritemSpacing;
        width = self.itemSize.width * 2;
    }else {
        left = (indexPath.section + 1)* (self.itemSize.width) + self.minimumInteritemSpacing;
        NSLog(@"%f",left);
        width = self.itemSize.width  ;
    }
    CGRect frame = CGRectMake(left, (self.collectionView.frame.size.height - _pageCardHeight ) / 2, width, self.itemSize.height);

    return frame;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    // 分页以1/3处
    if (proposedContentOffset.x > self.previousOffsetX + self.itemSize.width / 3.0) {
        self.previousOffsetX += _pageCardWidth+_lineSpace ;
        self.pageNum = ((int)self.previousOffsetX) / ((int)_pageCardWidth+(int)_lineSpace);
        if ([self.delegate respondsToSelector:@selector(scrollToPageIndex:)]) {
            [self.delegate scrollToPageIndex:self.pageNum];
        }
    } else if (proposedContentOffset.x < self.previousOffsetX  - self.itemSize.width / 3.0) {
        self.previousOffsetX -= _pageCardWidth+_lineSpace;
        self.pageNum = ((int)self.previousOffsetX) / ((int)_pageCardWidth+(int)_lineSpace);
        if ([self.delegate respondsToSelector:@selector(scrollToPageIndex:)]) {
            [self.delegate scrollToPageIndex:self.pageNum];
        }
    }
    //将当前cell移动到屏幕中间位置
    proposedContentOffset.x = self.previousOffsetX;

    return proposedContentOffset;
}

@end

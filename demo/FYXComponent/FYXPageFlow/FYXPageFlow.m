//
//  FYXPageFlow.m
//  FYXComponent
//
//  Created by 欧阳云慧 on 2018/3/6.
//  Copyright © 2018年 欧阳云慧. All rights reserved.
//

#import "FYXPageFlow.h"

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

#define displayScale  (nativScales() / 2)

CGFloat nativScales(void) {
    static CGFloat scale = 0.0f;
    if (scale == 0.0f) {
        CGFloat width = SCREEN_WIDTH;
        scale = width / 375.0f;
    }
    return scale * 2;
}

@implementation FYXPageFlow {
    bool addCell;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        _sectionCount = 5;
        addCell = NO;

        // colletion显示设置
        _flowLayout = [[FYXPageFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; // 滑动方向
        _flowLayout.pageCardWidth = VIEW_WIDTH(self) - 60 * displayScale * 2;
        _flowLayout.pageCardHeight = VIEW_HEIGHT(self) - 10 * displayScale;
        _flowLayout.lineSpace = 30 * displayScale;
        _flowLayout.delegate = self;

        double collectionHeigt;
        collectionHeigt = 495 * displayScale;

        UICollectionView *colletionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40 * displayScale, VIEW_WIDTH(self), collectionHeigt) collectionViewLayout:_flowLayout];

        colletionView.dataSource = self;
        colletionView.delegate = self;
        colletionView.backgroundColor = [UIColor whiteColor];
        colletionView.showsHorizontalScrollIndicator = NO;
        [colletionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:colletionView];
        self.collectionView = colletionView;

        // 页数
        UIPageControl *_pageControl = [[UIPageControl alloc]init];
        _pageControl.frame = CGRectMake(0, VIEW_HEIGHT(self) - 60 * displayScale, VIEW_WIDTH(self), 30 * displayScale);
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:1.0f];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:20.0 / 255 green:206.0 / 255 blue:1 alpha:0.5f];
        [self addSubview:_pageControl];
        self.pageControl = _pageControl;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.dataSource respondsToSelector:@selector(numberOfPageFlow:)] && addCell == NO) {
        _sectionCount = [self.dataSource numberOfPageFlow:self];
    }
    _pageControl.numberOfPages = _sectionCount;
    return _sectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [[UICollectionViewCell alloc]init];
    if ([self.dataSource respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)]) {
        cell = [self.dataSource collectionView:collectionView cellForItemAtIndexPath:indexPath];

    }else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == _sectionCount - 1) {
        addCell = YES;
        _sectionCount ++;
        [collectionView performBatchUpdates:^{
            [self.collectionView.viewForFirstBaselineLayout.layer setSpeed:0.2];
            [self.collectionView insertSections:[[NSIndexSet alloc] initWithIndex: indexPath.section]];
        } completion:nil];


    }

}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat width = ((collectionView.frame.size.width - _flowLayout.pageCardWidth)-(_flowLayout.lineSpace*2))/2;
    CGFloat height = _flowLayout.pageCardHeight;
    if (section == 0) {
        return UIEdgeInsetsMake((VIEW_HEIGHT(collectionView) - height) / 2, width + _flowLayout.lineSpace, (VIEW_HEIGHT(collectionView) - height) / 2, 0);//分别为上、左、下、右
    }
    else if(section == (_sectionCount - 1)){
        return UIEdgeInsetsMake((VIEW_HEIGHT(collectionView) - height) / 2, _flowLayout.lineSpace, (VIEW_HEIGHT(collectionView) - height) / 2, width + _flowLayout.lineSpace);//分别为上、左、下、右
    }
    else{
        return UIEdgeInsetsMake((VIEW_HEIGHT(collectionView) - height) / 2, _flowLayout.lineSpace, (VIEW_HEIGHT(collectionView) - height) / 2, 0);//分别为上、左、下、右
    }
}

- (void)scrollToPageIndex:(NSInteger)index {
    _pageControl.currentPage = index;
}

- (void)setPageSize: (CGFloat)width height:(CGFloat)height lineSpace:(CGFloat)lineSpace {
    _flowLayout.pageCardWidth = width;
    _flowLayout.pageCardHeight = height;
    _flowLayout.lineSpace = lineSpace;

}

@end


@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *cellView = [[UIView alloc]init];
        cellView.frame = self.bounds;
        cellView.backgroundColor = [UIColor orangeColor];
        cellView.layer.cornerRadius = 10;
        cellView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        cellView.layer.shadowOffset = CGSizeMake(1, 1);
        cellView.layer.shadowOpacity = 0.4;
        [self addSubview:cellView];
//        self.layer.speed = 0.2;
    }
    return self;
}



@end


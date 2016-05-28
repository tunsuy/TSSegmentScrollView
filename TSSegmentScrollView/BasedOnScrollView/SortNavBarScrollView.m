//
//  SortNavBarScrollView.m
//  TSSegmentScrollView
//
//  Created by tunsuy on 13/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "SortNavBarScrollView.h"
#import "SortButton.h"
#import "ReusedScrollView.h"
#import "ReusedScrollViewCell.h"

#define kItemsViewToBarScrollViewPaddingTop 5
#define kItemsViewToBarScrollViewPaddingBottom 5
#define kItemsViewToBarScrollViewPaddingLeft 10
#define kItemsViewToBarScrollViewPaddingRight 10

@interface SortNavBarScrollView ()<ReusedScrollViewDataSource, ReusedScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *itemTitlesArr;
@property (nonatomic, copy) NSArray *itemViewControllers;
@property (nonatomic, strong) NSMutableArray *itemsArr;

@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat itemSpace;

@end

@implementation SortNavBarScrollView

- (instancetype)initWithFrame:(CGRect)frame itemView:(SortButton *)itemView itemSpace:(CGFloat)itemSpace itemViewControllers:(NSArray<UIViewController *> *)itemViewControllers {
    
    if (self = [super initWithFrame:frame]) {
        self.itemViewControllers = [itemViewControllers copy];
        self.itemTitlesArr = [self itemTitlesWithItemViewControllers:itemViewControllers];
        
        self.itemWidth = itemView.ts_width;
        self.itemHeight = itemView.ts_height;
        NSUInteger itemCount = [itemViewControllers count];
        self.itemSpace = itemSpace;
        
        /** 初始化itemsBarScrollView */
        self.itemsBarScrollView.ts_height = self.itemHeight + kItemsViewToBarScrollViewPaddingTop +kItemsViewToBarScrollViewPaddingBottom;
        self.itemsBarScrollView.contentSize = CGSizeMake((self.itemWidth + itemSpace) * itemCount - itemSpace, self.itemsBarScrollView.ts_height);
        [self setUpItemViewForBarScrollView:itemView itemSpace:itemSpace];
        [self addSubview:self.itemsBarScrollView];
        
        /** 初始化reusedScrollView */
        _reusedScrollView = [[ReusedScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.itemsBarScrollView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.itemsBarScrollView.frame))];
        _reusedScrollView.pageViews = [self pageViewsWithItemViewControllers:itemViewControllers];
        _reusedScrollView.reusedScrollViewDataSource = self;
        _reusedScrollView.reusedScrollViewDelegate = self;
        [self addSubview:_reusedScrollView];
    }
    return self;
}

- (NSMutableArray *)itemsArr {
    if (!_itemsArr) {
        _itemsArr = [NSMutableArray array];
    }
    return _itemsArr;
}

#pragma mark - itemsBarScrollView handler
- (UIScrollView *)itemsBarScrollView {
    if (!_itemsBarScrollView) {
        _itemsBarScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    }
    return _itemsBarScrollView;
}

- (void)setUpItemViewForBarScrollView:(SortButton *)itemView itemSpace:(CGFloat)itemSpace {
    for (NSUInteger i=0; i<[self.itemTitlesArr count]; i++) {
        SortButton *sortBtn = [itemView copy];
        sortBtn.ts_originX = kItemsViewToBarScrollViewPaddingLeft + (self.itemWidth + itemSpace) * i;
        sortBtn.ts_originY = kItemsViewToBarScrollViewPaddingTop;
        [sortBtn setTitle:self.itemTitlesArr[i] forState:UIControlStateNormal];
        sortBtn.tag = i;
        [sortBtn addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.itemsArr addObject:sortBtn];
        [self.itemsBarScrollView addSubview:sortBtn];
    }
}

- (NSMutableArray *)itemTitlesWithItemViewControllers:(NSArray<UIViewController *> *)itemViewControllers {
    NSMutableArray *itemTitlesArr = [NSMutableArray array];
    for (UIViewController *viewController in itemViewControllers) {
        [itemTitlesArr addObject:viewController.title];
    }
    return itemTitlesArr;
}

#pragma mark - ReusedScrollView handler
- (NSMutableArray *)pageViewsWithItemViewControllers:(NSArray<UIViewController *> *)itemViewControllers {
    NSMutableArray *pageViews = [NSMutableArray array];
    for (UIViewController *viewController in itemViewControllers) {
        [pageViews addObject:viewController.view];
    }
    return pageViews;
}

#pragma mark - ReusedScrollViewDataSource
- (NSUInteger)numberofCellInScrollView:(ReusedScrollView *)scrollView {
    return [self.itemTitlesArr count];
}

- (ReusedScrollViewCell *)scrollView:(ReusedScrollView *)scrollView cellAtIndex:(NSUInteger)index {
    static NSString *cellID = @"reusedScrollView";
    ReusedScrollViewCell *cell = [scrollView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ReusedScrollViewCell alloc] initWithReuseIdentifier:cellID];
    }
    UIView *pageView = self.reusedScrollView.pageViews[index];
    [cell setPageViewInCell:pageView];
    return cell;
}

#pragma mark - Button click method
- (void)sortBtnClick:(SortButton *)button {
    UIColor *color = [button titleColorForState:UIControlStateNormal];
    UIFont *font = button.titleLabel.font;
    for (SortButton *btn in self.itemsArr) {
        if (btn.tag == button.tag) {
            btn.titleLabel.font = [UIFont systemFontOfSize:30];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
        else {
            btn.titleLabel.font = font;
            [btn setTitleColor:color forState:UIControlStateNormal];
        }
        [btn autoWidthForTitleFont];
        [self autoOriginForSortButton:button];
    }
    CGFloat offsetX = button.tag * self.ts_width;
    [self.reusedScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)autoOriginForSortButton:(SortButton *)selectedBtn {
//    CGFloat maxHeight = selectedBtn.ts_height;
    for (NSUInteger i=1; i<[self.itemsArr count]; i++) {
        SortButton *btn = self.itemsArr[i];
        btn.ts_originX = CGRectGetMaxX(((SortButton *)self.itemsArr[i-1]).frame) + self.itemSpace;
//        if (btn.tag != selectedBtn.tag) {
//            btn.ts_originY += (maxHeight - btn.ts_height) / 2;
//        }
    }
}

@end

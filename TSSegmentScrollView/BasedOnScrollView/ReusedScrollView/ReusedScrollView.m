//
//  ReusedScrollView.m
//  TSSegmentScrollView
//
//  Created by tunsuy on 14/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "ReusedScrollView.h"
#import "ReusedScrollViewCell.h"

@interface ReusedScrollView ()

@property (nonatomic, strong) NSMutableArray *pageViewFrames;
@property (nonatomic, strong) NSMutableDictionary *displayingPageViews;
@property (nonatomic, strong) NSMutableSet *reusedPageViews;

@end

@implementation ReusedScrollView

#pragma mark - 懒加载
- (NSMutableArray *)pageViewFrames {
    if (!_pageViewFrames) {
        _pageViewFrames = [NSMutableArray array];
    }
    return _pageViewFrames;
}

- (NSMutableDictionary *)displayingPageViews {
    if (!_displayingPageViews) {
        _displayingPageViews = [NSMutableDictionary dictionary];
    }
    return _displayingPageViews;
}

- (NSMutableSet *)reusedPageViews {
    if (!_reusedPageViews) {
        _reusedPageViews = [NSMutableSet set];
    }
    return _reusedPageViews;
}

- (void)cleanData {
    [self.displayingPageViews.allValues makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayingPageViews removeAllObjects];
    [self.pageViewFrames removeAllObjects];
    [self.reusedPageViews removeAllObjects];
}

- (void)reloadPageViews {
    [self cleanData];
    
    NSUInteger numberofCells = [self.reusedScrollViewDataSource numberofCellInScrollView:self];
    if (numberofCells == 0) {
        return;
    }
    
    for (NSUInteger i=0; i<numberofCells; i++) {
        CGRect frame = CGRectMake(self.ts_width*i, self.ts_originY, self.ts_width, self.ts_height);
        [self.pageViewFrames addObject:[NSValue valueWithCGRect:frame]];
    }
    
    self.contentSize = CGSizeMake(self.ts_width * numberofCells, 0);
}

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    __block ReusedScrollViewCell *reusableCell = nil;
    [self.reusedPageViews enumerateObjectsUsingBlock:^(ReusedScrollViewCell *cell, BOOL * _Nonnull stop) {
        if ([cell.reuseIdentifier isEqualToString:identifier]) {
            reusableCell = cell;
            *stop = YES;
        }
    }];
    if (reusableCell) {
        [self.reusedPageViews removeObject:reusableCell];
    }
    return reusableCell;
}

- (BOOL)isInScreen:(CGRect)frame {
    return CGRectGetMaxX(frame) > self.contentOffset.x && CGRectGetMinX(frame) < self.contentOffset.x + self.ts_width;
 }

- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger numberofCells = [self.pageViewFrames count];
    
    for (NSUInteger i=0; i<numberofCells; i++) {
        CGRect cellFrame = [self.pageViewFrames[i] CGRectValue];
        ReusedScrollViewCell *cell = self.displayingPageViews[@(i)];
        
        if ([self isInScreen:cellFrame]) {
            if (!cell) {
                cell = [self.reusedScrollViewDataSource scrollView:self cellAtIndex:i];
                cell.frame = cellFrame;
                [self addSubview:cell];
                
                self.displayingPageViews[@(i)] = cell;
            }
        }
        else {
            if (cell) {
                [cell removeFromSuperview];
                [self.displayingPageViews removeObjectForKey:@(i)];
                
                [self.reusedPageViews addObject:cell];
            }
        }
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self reloadPageViews];
}

@end

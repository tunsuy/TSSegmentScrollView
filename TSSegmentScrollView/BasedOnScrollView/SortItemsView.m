//
//  SortItemsView.m
//  TSSegmentScrollView
//
//  Created by tunsuy on 12/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "SortItemsView.h"
#import "SortButton.h"

#define kSubViewPaddingTop 10
#define kSubViewPaddingBottom 10
#define kSubViewPaddingLeft 5
#define kSubViewPaddingRight 5

@implementation SortItemsView

- (instancetype)initWithFrame:(CGRect)frame items:(SortButton *)item horizontalSpace:(CGFloat)horizontalSpace verticalSpace:(CGFloat)verticalSpace itemValues:(NSArray *)itemValues {
    if (self = [super initWithFrame:frame]) {
        NSUInteger verticalIndex = 0;
        
        CGFloat itemWidth = item.ts_width;
        CGFloat itemHeight = item.ts_height;
        NSUInteger horizontalItemsCountMax = (SCREEN_WIDTH - self.ts_originX - kSubViewPaddingLeft - kSubViewPaddingRight) / itemWidth;
        
        for (NSInteger horizontalIndex=0; horizontalIndex<[itemValues count]; horizontalIndex++) {
            SortButton *sortBtn = [item copy];
            sortBtn.ts_originX = kSubViewPaddingLeft + (itemWidth + horizontalSpace) * (horizontalIndex % horizontalItemsCountMax);
            sortBtn.ts_originY = kSubViewPaddingTop + (itemHeight + verticalIndex) * verticalIndex;
            if (sortBtn.ts_originX == kSubViewPaddingLeft && horizontalIndex != 0) {
                verticalIndex++;
                sortBtn.ts_originY = kSubViewPaddingTop + (itemHeight + verticalSpace) * verticalIndex;
            }
            [sortBtn setTitle:itemValues[horizontalIndex] forState:UIControlStateNormal];
            [self addSubview:sortBtn];
        
        }
        
        self.ts_width = [itemValues count] * (itemWidth + horizontalSpace) - horizontalSpace > (SCREEN_WIDTH - self.ts_originX - kSubViewPaddingLeft - kSubViewPaddingRight) ? SCREEN_WIDTH - self.ts_originX - kSubViewPaddingLeft - kSubViewPaddingRight : [itemValues count] * (itemWidth + horizontalSpace) - horizontalSpace;
 
        self.ts_height = (itemHeight + verticalSpace) * (verticalIndex + 1) - verticalSpace + kSubViewPaddingTop + kSubViewPaddingBottom;
    }
    return self;
}


@end

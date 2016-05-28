//
//  ReusedScrollViewCell.m
//  TSSegmentScrollView
//
//  Created by tunsuy on 14/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "ReusedScrollViewCell.h"

@implementation ReusedScrollViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super init];
    if (self) {
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}

- (void)setPageViewInCell:(UIView *)pageView {
    if ([self.subviews count]) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [self addSubview:pageView];
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    UIView *pageView = self.subviews[0];
    pageView.frame = self.bounds;
}

@end

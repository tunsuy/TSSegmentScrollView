//
//  SortItemsView.h
//  TSSegmentScrollView
//
//  Created by tunsuy on 12/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SortButton;

@interface SortItemsView : UIView

- (instancetype)initWithFrame:(CGRect)frame items:(SortButton *)item horizontalSpace:(CGFloat)horizontalSpace verticalSpace:(CGFloat)verticalSpace itemValues:(NSArray *)itemValues;

@end

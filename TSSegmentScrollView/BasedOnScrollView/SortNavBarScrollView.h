//
//  SortNavBarScrollView.h
//  TSSegmentScrollView
//
//  Created by tunsuy on 13/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SortButton;
@class ReusedScrollView;

@interface SortNavBarScrollView : UIView

@property (nonatomic, strong) UIScrollView *itemsBarScrollView;
@property (nonatomic, strong) ReusedScrollView *reusedScrollView;

- (instancetype)initWithFrame:(CGRect)frame itemView:(SortButton *)itemView itemSpace:(CGFloat)itemSpace itemViewControllers:(NSArray<UIViewController *> *)itemViewControllers;

@end

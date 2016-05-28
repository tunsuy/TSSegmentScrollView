//
//  ReusedScrollView.h
//  TSSegmentScrollView
//
//  Created by tunsuy on 14/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReusedScrollView;
@class ReusedScrollViewCell;

@protocol ReusedScrollViewDataSource <NSObject>

- (NSUInteger)numberofCellInScrollView:(ReusedScrollView *)scrollView;
- (ReusedScrollViewCell *)scrollView:(ReusedScrollView *)scrollView cellAtIndex:(NSUInteger)index;

@end

@protocol ReusedScrollViewDelegate <NSObject>

@optional
- (void)scrollView:(ReusedScrollView *)scrollView didSelectAtIndex:(NSUInteger)index;

@end

@interface ReusedScrollView : UIScrollView

@property (nonatomic, weak) id<ReusedScrollViewDataSource> reusedScrollViewDataSource;
@property (nonatomic, weak) id<ReusedScrollViewDelegate> reusedScrollViewDelegate;

@property (nonatomic, strong) NSMutableArray *pageViews;

- (void)reloadPageViews;
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@end

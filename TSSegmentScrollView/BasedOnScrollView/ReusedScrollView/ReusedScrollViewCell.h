//
//  ReusedScrollViewCell.h
//  TSSegmentScrollView
//
//  Created by tunsuy on 14/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReusedScrollViewCell : UIView

@property (nonatomic, copy) NSString *reuseIdentifier;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)setPageViewInCell:(UIView *)pageView;

@end

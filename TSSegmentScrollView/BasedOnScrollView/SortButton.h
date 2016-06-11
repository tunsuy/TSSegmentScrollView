//
//  SortButton.h
//  TSSegmentScrollView
//
//  Created by tunsuy on 12/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortButton : UIButton

@property (nonatomic, assign) BOOL scaring;

- (void)itemShake;
- (void)itemStop;
- (void)itemShakeWithItem;
- (void)itemStopWithItem;
- (void)itemlittleScare;

- (void)autoWidthForTitle;

@end

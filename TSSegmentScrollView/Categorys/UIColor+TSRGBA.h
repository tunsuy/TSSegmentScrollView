//
//  UIColor+TSRGBA.h
//  TSSegmentScrollView
//
//  Created by tunsuy on 12/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
}RGBA;

@interface UIColor (TSRGBA)

- (RGBA)ts_RGBAFromUIColor:(UIColor *)color;

@end

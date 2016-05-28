//
//  UIView+TSExtension.m
//  TSSegmentScrollView
//
//  Created by tunsuy on 12/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "UIView+TSExtension.h"

@implementation UIView (TSExtension)

- (CGFloat)ts_originX {
    return self.frame.origin.x;
}

- (void)setTs_originX:(CGFloat)originX {
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}

- (CGFloat)ts_originY {
    return self.frame.origin.y;
}

- (void)setTs_originY:(CGFloat)originY {
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}

- (CGFloat)ts_centerX {
    return self.center.x;
}

- (void)setTs_centerX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)ts_centerY {
    return self.center.y;
}

- (void)setTs_centerY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)ts_width {
    return self.bounds.size.width;
}

- (void)setTs_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)ts_height {
    return self.bounds.size.height;
}

- (void)setTs_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGSize)ts_size {
    return self.bounds.size;
}

- (void)setTs_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end

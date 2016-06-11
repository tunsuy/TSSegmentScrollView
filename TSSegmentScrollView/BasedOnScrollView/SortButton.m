//
//  SortButton.m
//  TSSegmentScrollView
//
//  Created by tunsuy on 12/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "SortButton.h"

#define kDeleteItemWidth 15

#define angleToRadian(angle) (angle / 180.0 * M_PI)

@interface SortButton ()<NSCopying>

@property (nonatomic, strong) UIImageView *deleteIcon;

@end

@implementation SortButton

- (UIImageView *)deleteIcon {
    if (!_deleteIcon) {
        _deleteIcon = [[UIImageView alloc] init];
        _deleteIcon.image = [UIImage imageNamed:@"icon_delet"];
        _deleteIcon.layer.cornerRadius = kDeleteItemWidth/2;
        _deleteIcon.alpha = 0;
    }
    return _deleteIcon;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        /** 默认配置 */
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithRed:126/255.0 green:222/255.0 blue:184/255.0 alpha:0.6].CGColor;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.backgroundColor = [UIColor colorWithRed:31/255.0 green:192/255.0 blue:120/255.0 alpha:0.6];
        [self addSubview:self.deleteIcon];
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.deleteIcon.frame = CGRectMake(0, 0, kDeleteItemWidth, kDeleteItemWidth);
    self.deleteIcon.ts_centerX = 2;
    self.deleteIcon.ts_centerY = 2;
    self.deleteIcon.userInteractionEnabled = YES;
    
    /** 自适应titleLabel文字大小 */
//    CGRect frame = self.titleLabel.frame;
//    frame.size = [self titleLabelTitleSize];
//    self.titleLabel.frame = frame;
}

- (void)itemlittleScare{
    self.scaring = NO;
    CAKeyframeAnimation  *keyAnima = [CAKeyframeAnimation animation];
    keyAnima.keyPath = @"transform.rotation";
    // 度数 / 180 * M_PI
    keyAnima.values = @[@(-angleToRadian(5)), @(angleToRadian(5)), @(-angleToRadian(5)),@(angleToRadian(0))];
    keyAnima.removedOnCompletion = NO;
    keyAnima.fillMode = kCAFillModeForwards;
    keyAnima.duration = 0.1;
    // 设置动画重复的次数
    keyAnima.repeatCount = 6;
    
    // 2.添加核心动画
    [self.layer addAnimation:keyAnima forKey:nil];
}

- (void)itemStopWithItem{
    [self itemStop];
    [UIView animateWithDuration:0.3 animations:^{
        self.deleteIcon.alpha = 0;
    }];
}

- (void)itemShake{
    self.scaring = YES;
    // 1.创建核心动画
    CAKeyframeAnimation  *keyAnima = [CAKeyframeAnimation animation];
    keyAnima.keyPath = @"transform.rotation";
    // 度数 / 180 * M_PI
    keyAnima.values = @[@(-angleToRadian(5)), @(angleToRadian(5)), @(-angleToRadian(5))];
    
    keyAnima.removedOnCompletion = NO;
    keyAnima.fillMode = kCAFillModeForwards;
    keyAnima.duration = 0.1;
    
    // 设置动画重复的次数
    keyAnima.repeatCount = MAXFLOAT;
    // 2.添加核心动画
    [self.layer addAnimation:keyAnima forKey:nil];
}

- (void)itemStop{
    self.scaring = NO;
    CAKeyframeAnimation  *keyAnima = [CAKeyframeAnimation animation];
    keyAnima.keyPath = @"transform.rotation";
    // 度数 / 180 * M_PI
    keyAnima.values = @[@(-angleToRadian(5)), @(angleToRadian(5)), @(-angleToRadian(5)),@(angleToRadian(0))];
    keyAnima.removedOnCompletion = NO;
    keyAnima.fillMode = kCAFillModeForwards;
    keyAnima.duration = 0.1;
    // 设置动画重复的次数
    keyAnima.repeatCount = 4;
    
    // 2.添加核心动画
    [self.layer addAnimation:keyAnima forKey:nil];
}

- (void)itemShakeWithItem{
    [self itemShake];
    [UIView animateWithDuration:0.3 animations:^{
        self.deleteIcon.alpha = 1;
    }];
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    SortButton *copy = [[[self class] allocWithZone:zone] init];
    copy.ts_size = self.ts_size;
    copy.scaring = self.scaring;
    return copy;
}

//- (CGSize)titleLabelTitleSize {
//    NSDictionary *attributes = @{NSFontAttributeName: self.titleLabel.font};
//    CGSize size = [self.titleLabel.text sizeWithAttributes:attributes];
//    return size;
//}

- (void)autoWidthForTitle {
    NSDictionary *attributes = @{NSFontAttributeName: self.titleLabel.font};
    CGSize size = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    self.ts_size = CGSizeMake(size.width + 5, size.height + 5);
}

@end

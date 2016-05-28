//
//  ViewController.m
//  TSSegmentScrollView
//
//  Created by tunsuy on 12/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "ViewController.h"
#import "SortButton.h"
#import "SortItemsView.h"
#import "SortNavBarScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
//    test sortBtn
//    SortButton *sortBtn = [[SortButton alloc] initWithFrame:CGRectMake(30, 80, 50, 30)];
//    [sortBtn itemlittleScare];
//    [sortBtn itemShake];
//    [sortBtn itemShakeWithItem];
//    [self.view addSubview:sortBtn];
    
//    test sortItemsView
//    SortButton *sortBtn = [[SortButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
//    NSArray *itemValues = @[@"独家", @"社会", @"历史", @"军事", @"跑步", @"健康"];
//    SortItemsView *sortItemsView = [[SortItemsView alloc] initWithFrame:CGRectMake(30, 80, 0, 0) items:sortBtn horizontalSpace:5 verticalSpace:5 itemValues:itemValues];
//    sortItemsView.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:sortItemsView];
    
//    test SortNavBarScrollView
    SortButton *sortBtn = [[SortButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    NSArray *itemValues = @[@"独家", @"社会", @"历史", @"军事", @"跑步", @"健康"];
    NSMutableArray *viewControllersArr = [NSMutableArray array];
    for (NSUInteger i=0; i<[itemValues count]; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = itemValues[i];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        label.center = CGPointMake(vc.view.ts_width/2, vc.view.ts_height/2);
        label.text = itemValues[i];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:25];
        [vc.view addSubview:label];
        
        [viewControllersArr addObject:vc];
    }
    SortNavBarScrollView *navBarScrollView = [[SortNavBarScrollView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT) itemView:sortBtn itemSpace:5 itemViewControllers:viewControllersArr];
    [self.view addSubview:navBarScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

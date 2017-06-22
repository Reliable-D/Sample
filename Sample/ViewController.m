//
//  ViewController.m
//  Sample
//
//  Created by 邓乐 on 2016/11/29.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

__weak NSArray *array_weak_ = nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    // 场景 1
//    NSArray *array = [NSArray arrayWithObjects:@"12", @"23", nil];
//    array_weak_ = array;
    // 场景 2
//    @autoreleasepool {
//        NSArray *array = [NSArray arrayWithObjects:@"12", @"23", nil];
//        array_weak_ = array;
//    }
    // 场景 3
    NSArray *array = nil;
    @autoreleasepool {
        array = [NSArray arrayWithObjects:@"12", @"23", nil];
        array_weak_ = array;
    }
    NSLog(@"array: %@", array_weak_);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"array: %@", array_weak_);
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"array: %@", array_weak_);
}

@end

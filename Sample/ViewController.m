//
//  ViewController.m
//  Sample
//
//  Created by 邓乐 on 2016/11/29.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "DLCurveViewController.h"
#import "WDPLaunchCurveView.h"
#import "WDSDCitySelectPickView.h"

@interface DLPerson : NSObject

@end

@implementation DLPerson

@end

@interface DLStudent : DLPerson

@end

@implementation DLStudent

@end

@interface ViewController ()

@property (nonatomic, strong) WDPLaunchCurveView* orangeView;

@property (nonatomic) CFTimeInterval firstTimestamp;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic) NSUInteger loopCount;

@property (nonatomic, strong) UIScrollView* scroll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    [self.view addSubview:scrollView];
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 100)];
    
    UITextView* text = [[UITextView alloc] initWithFrame:view.bounds];
    text.backgroundColor = [UIColor lightTextColor];
    [view addSubview:text];
    
    [scrollView addSubview:view];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"Submit" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(15, CGRectGetMaxY(text.frame)+20, CGRectGetWidth(self.view.frame)-30, 44);
    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    UIView* blockView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(button.frame)+500, CGRectGetWidth(self.view.frame)-30, 300)];
    blockView.backgroundColor = [UIColor purpleColor];
    [scrollView addSubview:blockView];
    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(blockView.frame)+10);
    
    self.scroll = scrollView;
    
    NSLog(@"123");
}

- (void)clickBtn:(UIButton*)sender
{
    NSLog(@"contentInset: %@",NSStringFromUIEdgeInsets(self.scroll.contentInset));
}

@end

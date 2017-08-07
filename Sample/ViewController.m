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
    
//    CGSize screenSize = [UIScreen mainScreen].bounds.size;
//    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
//    [self.view addSubview:scrollView];
//    
//    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 100)];
//    
//    UITextView* text = [[UITextView alloc] initWithFrame:view.bounds];
//    text.backgroundColor = [UIColor lightTextColor];
//    [view addSubview:text];
//    
//    [scrollView addSubview:view];
//    
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.backgroundColor = [UIColor lightGrayColor];
//    [button setTitle:@"Submit" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    button.frame = CGRectMake(15, CGRectGetMaxY(text.frame)+20, CGRectGetWidth(self.view.frame)-30, 44);
//    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:button];
//    
//    UIView* blockView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(button.frame)+500, CGRectGetWidth(self.view.frame)-30, 300)];
//    blockView.backgroundColor = [UIColor purpleColor];
//    [scrollView addSubview:blockView];
//    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(blockView.frame)+10);
    
    //self.scroll = scrollView;
}

- (void)clickBtn:(UIButton*)sender
{
    NSLog(@"contentInset: %@",NSStringFromUIEdgeInsets(self.scroll.contentInset));
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//   // [self.orangeView startDisplayLink];
//    
////    DLCurveViewController* vc = [DLCurveViewController new];
////    [self.navigationController pushViewController:vc animated:YES];
//    [WDSDCitySelectPickView showCitySelectPickViewWithCode:nil];
//}


/*
void findSubString(){
    NSString *filename = @".";
    NSString *escapedPath = @"4.5";
    
    //在escapedPath中查找filename
    //NSRange iStart = [escapedPath rangeOfString :filename];
    NSRange iStart = [escapedPath rangeOfString: filename options:NSCaseInsensitiveSearch];
    // NSLog(@"iStart length is %@:",iStart.length);
    // NSLog(@"iStart location is %@:",iStart.location);
    if (iStart.length > 0){
        //获取从escapedPath开始位置到iStart.location-1长度的子字符串
        NSString *subStr = [escapedPath  substringToIndex:iStart.location+1];
        NSLog(@"subStr:%@",subStr);
        
        //获取从escapedPath从iStart.location+1开始到末尾的子字符串
        NSString *extension  = [escapedPath  substringFromIndex:iStart.location];
        NSLog(@"extension:%@",extension);
        
        NSString *url = @"http://www.sevenuc.com";
        NSRange range = NSMakeRange(3,7);
        NSString* prefix = [url substringWithRange:range];
        NSLog(@"prefix is:%@",prefix);
        if([prefix isEqualToString:@"p://www"])
        {
            NSLog(@"prefix is equal %@",prefix);
        }
        else {
            NSLog(@"prefix is not equal %@",prefix);
        }
        //获取url从0开始共7个字符的子字符串
        if ( [prefix isEqualToString:@"http://"] )
            NSLog(@"http prefix found");
    }
}

void TestMetaClass(id self, SEL _cmd) {
    
    NSLog(@"This objcet is %p", self);
    NSLog(@"Class is %@, super class is %@", [self class], [self superclass]);
    
    Class currentClass = [self class];
    for (int i = 0; i < 4; i++) {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = objc_getClass((__bridge void *)currentClass);
    }
    
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", objc_getClass((__bridge void *)[NSObject class]));
}*/

@end

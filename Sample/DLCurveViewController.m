//
//  DLCurveViewController.m
//  Sample
//
//  Created by 邓乐 on 2017/7/10.
//  Copyright © 2017年 Wanda. All rights reserved.
//

#import "DLCurveViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DLCurveViewController ()

@property (nonatomic, strong) UIView* orangeView;

@property (nonatomic) CFTimeInterval firstTimestamp;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic) NSUInteger loopCount;

@end

static CGFloat const kSeconds = 5.0;

@implementation DLCurveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.orangeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.orangeView.backgroundColor = [UIColor purpleColor];
    self.orangeView.center = self.view.center;
    [self.view addSubview:self.orangeView];
    
    [self addShapeLayer];
    [self startDisplayLink];
}

- (void)addShapeLayer
{
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.path = [[self pathAtInterval:0.0] CGPath];
//    self.shapeLayer.fillColor = [[UIColor clearColor] CGColor];
//    self.shapeLayer.lineWidth = 3.0;
//    self.shapeLayer.strokeColor = [[UIColor redColor] CGColor];
//    [self.view.layer addSublayer:self.shapeLayer];
    self.orangeView.layer.mask = self.shapeLayer;
}

- (void)startDisplayLink
{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)stopDisplayLink
{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)handleDisplayLink:(CADisplayLink *)displayLink
{
    if (!self.firstTimestamp)
        self.firstTimestamp = displayLink.timestamp;
    
    self.loopCount++;
    
    NSTimeInterval elapsed = (displayLink.timestamp - self.firstTimestamp);
    
    self.shapeLayer.path = [[self pathAtInterval:elapsed] CGPath];
    
    if (elapsed >= kSeconds)
    {
        [self stopDisplayLink];
        self.shapeLayer.path = [[self pathAtInterval:kSeconds] CGPath];
        
        NSLog(@"%@",[NSString stringWithFormat:@"loopCount = %.1f frames/sec", self.loopCount / kSeconds]);
        
        //self.statusLabel.text = [NSString stringWithFormat:@"loopCount = %.1f frames/sec", self.loopCount / kSeconds];
    }
}

- (UIBezierPath *)pathAtInterval:(NSTimeInterval) interval
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, 0)];
    
    CGFloat fractionOfSecond = interval / kSeconds;
    [path addQuadCurveToPoint:CGPointMake(self.orangeView.bounds.size.width, 0) controlPoint:CGPointMake(self.orangeView.bounds.size.width/2.0f, self.orangeView.bounds.size.height / 3.0*fractionOfSecond)];
    
    [path addLineToPoint:CGPointMake(self.orangeView.bounds.size.width, self.orangeView.bounds.size.height)];
    [path addLineToPoint:CGPointMake(0, self.orangeView.bounds.size.height)];
    [path addLineToPoint:CGPointMake(0, 0)];
    

    
   // UIBezierPath *path = [UIBezierPath bezierPath];
    
//    [path moveToPoint:CGPointMake(0, self.view.bounds.size.height / 2.0)];
//    
//    CGFloat fractionOfSecond = interval - floor(interval);
//    
//    CGFloat yOffset = self.view.bounds.size.height * sin(fractionOfSecond * M_PI * 2.0);
//    
//    [path addCurveToPoint:CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height / 2.0)
//            controlPoint1:CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0 - yOffset)
//            controlPoint2:CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0 + yOffset)];
    
    return path;
}
@end


//
//  WDPLaunchCurveView.m
//  Sample
//
//  Created by 邓乐 on 2017/7/10.
//  Copyright © 2017年 Wanda. All rights reserved.
//

#import "WDPLaunchCurveView.h"

@interface WDPLaunchCurveView ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic) CFTimeInterval firstTimestamp;
@property (nonatomic) CFTimeInterval displayLinkTimestamp;
@property (nonatomic) NSUInteger loopCount;

@end

static CGFloat const kSeconds = 2.00;

@implementation WDPLaunchCurveView


+ (instancetype)curveView {
    WDPLaunchCurveView* view = [[WDPLaunchCurveView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    return view;
}

- (void)startDisplayLink
{
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
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
    
    self.displayLinkTimestamp = displayLink.timestamp;
    
    self.loopCount++;
    
    [self setNeedsDisplayInRect:self.bounds];
    
    NSTimeInterval elapsed = (displayLink.timestamp - self.firstTimestamp);
    
    if (elapsed >= kSeconds)
    {
        [self stopDisplayLink];
        self.displayLinkTimestamp = self.firstTimestamp + kSeconds;
        [self setNeedsDisplayInRect:self.bounds];
        NSLog(@"loopCount = %.1f frames/sec", self.loopCount / kSeconds);
    }
}

- (UIBezierPath *)pathAtInterval:(NSTimeInterval) interval
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, 0)];
    
    CGFloat fractionOfSecond = interval / kSeconds;
    
    [path addQuadCurveToPoint:CGPointMake(self.bounds.size.width, 0) controlPoint:CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height / 3.0*fractionOfSecond)];
    
    [path moveToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    
    [path moveToPoint:CGPointMake(0, self.bounds.size.height)];
    
    return path;
}


- (void)drawRect:(CGRect)rect
{
    NSTimeInterval elapsed = (self.displayLinkTimestamp - self.firstTimestamp);
    UIBezierPath *path = [self pathAtInterval:elapsed];
    [[UIColor clearColor] setFill];
    [path fill];
}


@end

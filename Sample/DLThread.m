//
//  DLThread.m
//  Sample
//
//  Created by 邓乐 on 2017/6/26.
//  Copyright © 2017年 Wanda. All rights reserved.
//

#import "DLThread.h"
#import <pthread.h>

@implementation DLThread

- (void)testPThread {
    pthread_t thread;
    /*
     第一个参数&thread是线程对象
     第二个和第四个是线程属性，可赋值NULL
     第三个run表示指向函数的指针(run对应函数里是需要在新线程中执行的任务)
     */
    pthread_create(&thread, NULL, run, NULL);
}

void * run() {
    NSLog(@"hello pthread:%@",[NSThread currentThread]);
    return NULL;
}

- (void)testGCD {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"----------1------------");
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"------------2--------------");
        });
    });
    NSLog(@"-------------3-----------------");
}

- (void)testNSThread {
    NSThread* thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [thread start];
}

@end

//
//  WDSDAreaDataModel.h
//  WDPubLib
//
//  Created by 邓乐 on 16/6/20.
//  Copyright © 2016年 wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WDSDAreaDataModel <NSObject>

@end

@interface WDSDAreaDataModel : NSObject
@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSString* postcode;
@end

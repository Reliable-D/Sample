//
//  WDSDCityDataModel.h
//  WDPubLib
//
//  Created by 邓乐 on 16/6/14.
//  Copyright © 2016年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDSDAreaDataModel.h"

@protocol WDSDCityDataModel <NSObject>

@end

@interface WDSDCityDataModel : NSObject

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSString* postcode;

@property (nonatomic, strong) NSArray<WDSDAreaDataModel>* area;


@end

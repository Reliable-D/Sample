//
//  WDSDProvinceDataModel.h
//  WDPubLib
//
//  Created by 邓乐 on 16/6/14.
//  Copyright © 2016年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDSDCityDataModel.h"

@protocol WDSDProvinceDataModel <NSObject>

@end

@interface WDSDProvinceDataModel : NSObject

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSString* postcode;

@property (nonatomic, strong) NSArray<WDSDCityDataModel>* city;

@end

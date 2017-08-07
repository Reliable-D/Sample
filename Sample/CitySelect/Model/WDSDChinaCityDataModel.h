//
//  WDSDChinaCityDataModel.h
//  WDPubLib
//
//  Created by 邓乐 on 16/6/24.
//  Copyright © 2016年 wanda. All rights reserved.
//

#import "WDSDProvinceDataModel.h"

@interface WDSDChinaCityDataModel : NSObject

@property (nonatomic, copy) NSString* version;

@property (nonatomic, strong) NSArray<WDSDProvinceDataModel>* provinces;

@end

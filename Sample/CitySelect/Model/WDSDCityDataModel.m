//
//  WDSDCityDataModel.m
//  WDPubLib
//
//  Created by 邓乐 on 16/6/14.
//  Copyright © 2016年 wanda. All rights reserved.
//

#import "WDSDCityDataModel.h"

@implementation WDSDCityDataModel
//
//+ (instancetype)cityDataWithDict:(NSDictionary *)dict
//{
//    WDSDCityDataModel* cityData = [WDSDCityDataModel new];
//    
//    cityData.name = [dict objectForKey:@"name"];
//    cityData.code = [dict objectForKey:@"code"];
//    
//    NSArray* districtDict = [dict objectForKey:@"district"];
//    
//    NSMutableArray* tempArray = [NSMutableArray arrayWithCapacity:districtDict.count];
//    
//    [districtDict enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [tempArray addObject:[WDSDDistrictDataModel districtDataWithDict:obj]];
//    }];
//    
//    cityData.district = tempArray;
//    
//    return cityData;
//}

@end

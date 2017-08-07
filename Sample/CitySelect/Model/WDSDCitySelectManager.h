//
//  WDSDCitySelectManager.h
//  WDPubLib
//
//  Created by 邓乐 on 16/6/15.
//  Copyright © 2016年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDSDChinaCityDataModel.h"

@interface WDSDCitySelectManager : NSObject

@property (nonatomic, strong) NSString* destinationPath;

@property (nonatomic, strong) NSString* originFilePath;

@property (nonatomic, strong) WDSDChinaCityDataModel* cityDataModel;

+ (instancetype)defaultManager;

+ (void)updateCityPlistWithJson:(NSString*)json;

@end

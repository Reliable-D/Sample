//
//  WDSDCitySelectPickView.h
//  WDPubLib
//
//  Created by 邓乐 on 16/6/14.
//  Copyright © 2016年 wanda. All rights reserved.
//


//#import "WDSDChinaCityDataModel.h"
#import <UIKit/UIKit.h>

#define kCitySelectPickViewDoneBtn 100
#define kCitySelectPickViewCancelBtn 101

@interface WDSDCitySelectPickView : UIView

+ (instancetype)showCitySelectPickViewWithCode:(NSString*)cityCode;

@end

@interface WDSDCitySelectLastCityIndexData : NSObject

@property (nonatomic,assign) NSInteger provinceIndex;

@property (nonatomic,assign) NSInteger cityIndex;

@property (nonatomic,assign) NSInteger areaIndex;

@end

//
//  WDSDCitySelectManager.m
//  WDPubLib
//
//  Created by 邓乐 on 16/6/15.
//  Copyright © 2016年 wanda. All rights reserved.
//

#import "WDSDCitySelectManager.h"
#import <YYModel/YYModel.h>

static WDSDCitySelectManager* __instance = nil;

@implementation WDSDCitySelectManager

- (WDSDChinaCityDataModel *)cityDataModel
{
    if (!_cityDataModel) {
        
        NSData* data = [NSData dataWithContentsOfFile:[WDSDCitySelectManager defaultManager].originFilePath];
        NSError* error = nil;
        
        _cityDataModel = [WDSDChinaCityDataModel yy_modelWithJSON:data];
        
        if (error) {
            NSLog(@"failed");
        }
    }
    return _cityDataModel;
}

- (NSString *)destinationPath
{
    if (!_destinationPath) {
        NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *cachesDirectoryPath=[pathsArray objectAtIndex:0];
        
        _destinationPath = [cachesDirectoryPath stringByAppendingPathComponent:@"WDSDChinaCity.json"];
        //DebugBlueLog(@"WDSDChinaCity.json destination path:%@",_destinationPath);
        
        return _destinationPath;
    }
    return _destinationPath;
}

- (NSString *)originFilePath
{
    if (!_originFilePath) {
        _originFilePath = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"WDSDChinaCity.json"];
        //DebugBlueLog(@"WDSDChinaCity.json origin path:%@",_originFilePath);
        return _originFilePath;
    }
    return _originFilePath;
}

+ (instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[WDSDCitySelectManager alloc] init];
    });
    return __instance;
}

+ (void)updateCityPlistWithJson:(NSString*)json
{
    NSFileManager *fileManger=[NSFileManager defaultManager];
    NSError *error;
    
    NSString *destinationPath= [WDSDCitySelectManager defaultManager].destinationPath;
    
    if (![fileManger fileExistsAtPath:destinationPath]){//不存在plist
        NSString *sourcePath=[WDSDCitySelectManager defaultManager].originFilePath;
        //拷贝plist
        [fileManger copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        return;
    }

    if (json.length > 0) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        [array writeToFile:destinationPath atomically:YES];
    }
}

@end

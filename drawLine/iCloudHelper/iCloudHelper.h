//
//  iCloudHelper.h
//  drawLine
//
//  Created by Chinalife on 2018/1/8.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^uploadBlock)(NSError *error);
typedef void(^downloadBlock)(id obj);
@interface iCloudHelper : NSObject


+ (BOOL)iCloudEnable;

+ (NSString *)localFilePath:(NSString *)name;

+ (void)uploadToiCloud:(NSString *)name file:(id)file resultBlock:(uploadBlock)block;

+ (void)uploadToiCloud:(id)file resultBlock:(uploadBlock)block iCloudNam:(NSString *)fileName;

+ (void)downloadFromiCloud:(NSString *)name responsBlock:(downloadBlock)block;

+ (void)uploadToiCloud:(id)file iCloudNam:(NSString *)fileName resultBlock:(uploadBlock)block;

+ (void)downloadFromiCloudWithBlock:(downloadBlock)block iCloudName:(NSString *)fileName;

+ (void)deleteiCloudFile:(NSString *)name resultBlock:(uploadBlock)block;
@end



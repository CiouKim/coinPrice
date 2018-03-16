//
//  iCloudHelper.h
//  drawLine
//
//  Created by Chinalife on 2018/1/8.
//  Copyright © 2018年 qwe. All rights reserved.
//


#import "iCloudHelper.h"

@implementation iCloudHelper


+ (BOOL)iCloudEnable {
    
    // 获得文件管理器
    NSFileManager *manager = [NSFileManager defaultManager];
    
    // 判断iCloud是否可用
    // 参数传nil表示使用默认容器
    NSURL *url = [manager URLForUbiquityContainerIdentifier:nil];
    // 如果URL不为nil, 则表示可用
    if (url != nil) {
        return YES;
    }
    
    NSLog(@"iCloud 不可用");
    return NO;
}

+ (NSURL *)iCloudFilePathByName:(NSString *)name {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    // 判断iCloud是否可用
    // 参数传nil表示使用默认容器
    NSURL *url = [manager URLForUbiquityContainerIdentifier:nil];
    if (url == nil) {
        return nil;
    }
    // 获取Documents目录
    url = [url URLByAppendingPathComponent:@"Documents"];
    NSURL *iCloudPath = [NSURL URLWithString:name relativeToURL:url];
    
    return iCloudPath;
}

+ (NSString *)localFilePath:(NSString *)name {
    
    // 得到本程序沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filePath = [[paths firstObject] stringByAppendingPathComponent:name];
    
    return filePath;
}

+ (void)uploadToiCloud:(id)file iCloudNam:(NSString *)fileName resultBlock:(uploadBlock)block {
    
    [self uploadToiCloud:fileName file:file resultBlock:block];
}

+ (void)uploadToiCloud:(NSString *)name file:(id)file resultBlock:(uploadBlock)block {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        if ([file isKindOfClass:[NSString class]]) {
            [self uploadToiCloud:name localFile:file resultBlock:block];
        } else {
            NSString *path = [self localFilePath:@"temp.data"];
            NSError *error = nil;
            if ([file writeToFile:path options:NSDataWritingAtomic error:&error]) {
                [self uploadToiCloud:name localFile:path resultBlock:block];
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(error);
                });
            }
        }
    });
}

+ (void)uploadToiCloud:(NSString *)name localFile:(NSString *)file resultBlock:(uploadBlock)block {
    NSURL *iCloudUrl = [self iCloudFilePathByName:[name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *localFilePath = file;
    if ([file componentsSeparatedByString:@"/"].count < 2) {
        
        localFilePath = [self localFilePath:file];
    }
    
    NSFileManager *manager  = [NSFileManager defaultManager];
    // 判断本地文件是否存在
    if ([manager fileExistsAtPath:localFilePath]) {
        NSData *data = [NSData dataWithContentsOfFile:localFilePath];
        // 判断iCloud里该文件是否存在
        //        if ([manager isUbiquitousItemAtURL:iCloudUrl]) {
        //            NSError *error = nil;
        //            [data writeToURL:iCloudUrl options:NSDataWritingAtomic error:&error];
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //                block(error);
        //            });
        //        } else {
        //            NSURL *fileUrl = [NSURL fileURLWithPath:localFilePath];
        //            NSError *error = nil;
        //            [manager setUbiquitous:YES itemAtURL:fileUrl destinationURL:iCloudUrl error:&error]; //API_AVAILABLE(macos(10.7), ios(5.0), watchos(2.0), tvos(9.0)
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //                block(error);
        //            });
        //        }
        NSError *error = nil;
        [data writeToURL:iCloudUrl options:NSDataWritingAtomic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(error);
        });
    }
}

+ (void)downloadFromiCloudWithBlock:(downloadBlock)block iCloudName:(NSString *)fileName {
    [self downloadFromiCloud:fileName responsBlock:block];
}

+ (void)downloadFromiCloud:(NSString *)name responsBlock:(downloadBlock)block {
    NSURL *iCloudUrl = [self iCloudFilePathByName:[name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        if ([self downloadFileIfNotAvailable:iCloudUrl]) {
            NSArray *array = [[NSArray alloc]initWithContentsOfURL:iCloudUrl];
            if (array != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(array);
                });
            } else {
                NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfURL:iCloudUrl];
                if (dic != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(dic);
                    });
                } else {
                    NSData *data = [[NSData alloc]initWithContentsOfURL:iCloudUrl];
                    if (data != nil) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(data);
                        });
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(nil);
                        });
                    }
                }
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(nil);
            });
        }
    });
}

// // 此方法是官方文档提供,用来检查文件状态并下载
+ (BOOL)downloadFileIfNotAvailable:(NSURL*)file {
    NSNumber* isIniCloud = nil;
    
    if ([file getResourceValue:&isIniCloud forKey:NSURLIsUbiquitousItemKey error:nil]) {
        // If the item is in iCloud, see if it is downloaded.
        if ([isIniCloud boolValue]) {
            NSNumber* isDownloaded = nil;
            if ([file getResourceValue:&isDownloaded forKey:NSURLUbiquitousItemDownloadingStatusKey error:nil]) {
                if ([isDownloaded boolValue])
                    return YES;
                // Download the file.
                NSFileManager* fm = [NSFileManager defaultManager];
                if (![fm startDownloadingUbiquitousItemAtURL:file error:nil]) {
                    return NO;
                }
                return YES;
            }
        }
    }
    // Return YES as long as an explicit download was not started.
    return YES;
}

+ (void)deleteiCloudFile:(NSString *)name resultBlock:(uploadBlock)block {
    NSURL *iCloudUrl = [self iCloudFilePathByName:[name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSFileManager *manager  = [NSFileManager defaultManager];
    //         判断iCloud里该文件是否存在
    if ([manager isUbiquitousItemAtURL:iCloudUrl]) {
        NSError *error = nil;
        [manager removeItemAtURL:iCloudUrl error: &error];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(error);
        });
    }
}

@end


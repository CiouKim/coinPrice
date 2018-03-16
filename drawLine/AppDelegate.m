//
//  AppDelegate.m
//  drawLine
//
//  Created by Chinalife on 2018/1/2.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "iCloudHelper.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    viewController = [[ViewController alloc] init];
    
#pragma mark - Check Profile Expired Date
    NSString *profilePath = [[NSBundle mainBundle] pathForResource:@"embedded.mobileprovision" ofType:nil];

    if (profilePath)
    {
        // Get hex representation
        NSData *profileData = [NSData dataWithContentsOfFile:profilePath];
        NSString *profileString = [NSString stringWithFormat:@"%@", profileData];

        // Remove brackets at beginning and end
        profileString = [profileString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
        profileString = [profileString stringByReplacingCharactersInRange:NSMakeRange(profileString.length - 1, 1) withString:@""];

        // Remove spaces
        profileString = [profileString stringByReplacingOccurrencesOfString:@" " withString:@""];


        // Convert hex values to readable characters
        NSMutableString *profileText = [NSMutableString new];
        for (int i = 0; i < profileString.length; i += 2)
        {
            NSString *hexChar = [profileString substringWithRange:NSMakeRange(i, 2)];
            int value = 0;
            sscanf([hexChar cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
            [profileText appendFormat:@"%c", (char)value];
        }

        // Remove whitespaces and new lines characters
        NSArray *profileWords = [profileText componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

        //There must be a better word to search through this as a structure! Need 'date' sibling to <key>ExpirationDate</key>, or use regex
        BOOL sibling = false;
        for (NSString* word in profileWords){
            if ([word isEqualToString:@"<key>ExpirationDate</key>"]){
                NSLog(@"Got to the key, now need the date!");
                sibling = true;
            }
            if (sibling && ([word rangeOfString:@"<date>"].location != NSNotFound)) {
                NSLog(@"Found it, you win!");
                NSLog(@"Expires: %@",word);
            }
        }
    }
#pragma mark -iCloud iCloud upload test
//    NSString *iCloudfilekey = @"apple36";
//    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"apple" ofType:@"png"];
//    [self updataTOiCloud:iCloudfilekey filePath:imgPath];
    
#pragma mark -iCloud iCloud download test
//    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/userData"];
//    [self downloadFromiCloud:@"apple36" filePath:[NSString stringWithFormat:@"%@/%@", path, @"test.png"]];
    
 #pragma mark -iCloud iCloud fileList test
//    [self loadiCloudData];

    rootViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    rootViewController.delegate = (id)self;
    rootViewController.navigationBar.translucent = NO;
    rootViewController.navigationBar.hidden = NO;
    [self.window setRootViewController:rootViewController];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//从iCloud上加载所有文档信息
- (void)loadiCloudData {
    if (!self.query) {
        self.query = [[NSMetadataQuery alloc] init];
        self.query.searchScopes = @[NSMetadataQueryUbiquitousDocumentsScope];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(metadataQueryFinish:)
                                                     name:NSMetadataQueryDidFinishGatheringNotification
                                                   object:self.query];//数据获取完成通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(metadataQueryFinish:)
                                                     name:NSMetadataQueryDidUpdateNotification
                                                   object:self.query];//查询更新通知
    }
    //getData
    [self.query startQuery];
}
//查詢取得data
- (void)metadataQueryFinish:(NSNotification *)notification {
    NSLog(@"iCloud get data scuessful");
    NSArray *items = self.query.results;
    self.files = [NSMutableDictionary dictionary];
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMetadataItem *item = obj;
        NSString *fileName = [item valueForAttribute:NSMetadataItemFSNameKey];
        NSDate *date = [item valueForAttribute:NSMetadataItemFSContentChangeDateKey];
        NSDateFormatter *dateformate = [[NSDateFormatter alloc] init];
        dateformate.dateFormat = @"YY-MM-dd HH:mm";
        NSString *dateString = [dateformate stringFromDate:date];
        [self.files setObject:dateString forKey:fileName];
    }];
    NSLog(@"files:%@" ,self.files);
}

- (void)updataTOiCloud:(NSString *)iCloudfilekey filePath:(NSString *)filePath {
    if ([iCloudHelper iCloudEnable]) {
        NSLog(@"%s", __func__);

        NSLog(@"iCloud enable");
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSLog(@"img exist");
            [iCloudHelper uploadToiCloud:filePath iCloudNam:iCloudfilekey resultBlock:^(NSError *err) {
                if (err == nil) {
                    NSLog(@"iCLoud Sync scuessful");
                } else {
                    NSLog(@"iCLoud Sync fail");
                }
            }];
        } else {
            NSLog(@"img no exist");
        }
    } else {
        NSLog(@"iCloud unenable");
    }
}

- (void)downloadFromiCloud:(NSString *)iCloudfilekey filePath:(NSString *)filePath {
    if ([iCloudHelper iCloudEnable]) {
        NSLog(@"%s", __func__);
        NSLog(@"iCloud enable");
        [iCloudHelper downloadFromiCloudWithBlock:^(id obj) {
            if (obj != nil) {
                NSData *data = (NSData *)obj;
                NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
                if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
                    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
                }
                [data writeToFile:filePath atomically:YES];
                NSLog(@"sync download Scuessful");
            } else {
                NSLog(@"Sync download fail");
            }
        } iCloudName:iCloudfilekey];
    } else {
        NSLog(@"iCloud unenable");
    }
}

@end

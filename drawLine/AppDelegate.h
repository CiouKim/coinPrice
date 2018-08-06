//
//  AppDelegate.h
//  drawLine
//
//  Created by Chinalife on 2018/1/2.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@import Firebase;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UINavigationController *rootViewController;
    ViewController *viewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableDictionary *files;
@property (strong, nonatomic) NSMetadataQuery *query;



@end


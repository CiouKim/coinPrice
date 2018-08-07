//
//  ViewController.m
//  drawLine
//
//  Created by Chinalife on 2018/1/2.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import "ViewController.h"
#import "oneViewController.h"
#import "profView.h"

@import FirebaseDatabase;

@interface ViewController ()
@property(strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    oneView *view = [[oneView alloc] initWithFrame:self.view.bounds];
//    view.controller = self;
//    self.oneView = view;
//    [self.view addSubview:view];

    pView = [[profView alloc] initWithFrame:self.view.bounds];
    pView.controller = self;
    self.view = pView;
}

- (void)viewWillAppear:(BOOL)animated {
    self.ref = [[FIRDatabase database] reference];
    [[FIRAuth auth] signInWithEmail:@"test03@gmail.com"
                           password:@"1234567"
                         completion:^(FIRUser *user, NSError *error) {
                             if (error) {
                                 NSLog(@"%@",error);
                             }
                             
                             if (user) {
#pragma mark -firebase user change password
//                                 [[FIRAuth auth].currentUser updatePassword:@"1234567" completion:^(NSError *_Nullable error) {
//                                     // ...
//                                 }];
//                                 [[[_ref child:@"Version"] child:@"Ver"] setValue:@"4.4"];
#pragma mark -firebase data updata or insert
//                                 [[[_ref child:@"Version"] child:@"Ver"] setValue:@"8.4" withCompletionBlock:^(NSError *error, FIRDatabaseReference *ref) {
//                                     if (error) {
//                                         NSLog(@"Data could not be saved: %@", error);
//                                     } else {
//                                         NSLog(@"Data saved successfully.");
//                                     }
//                                 }];
                             }
                         }];
    
////監聽節點變更資料
//
//    [[_ref child:@"User"] observeEventType:FIRDataEventTypeChildChanged
//     withBlock:^(FIRDataSnapshot *snapshot) {
//         NSLog(@"snap = %@",snapshot.value );//取資料
//     } withCancelBlock:^(NSError * _Nonnull error) {
//        NSLog(@"%@", error.localizedDescription);
//    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  oneViewController.m
//  drawLine
//
//  Created by Chinalife on 2018/1/4.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import "oneViewController.h"
#import "oneView.h"

@interface oneViewController ()

@end

@implementation oneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (oView == nil) {
        oView = [[oneView alloc] initWithFrame:self.view.bounds];
    }
    
    [oView getData];
    
    [self.view addSubview:oView];
    self.navigationItem.title = @"Assume Income";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(UIBarButtonItem *)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end

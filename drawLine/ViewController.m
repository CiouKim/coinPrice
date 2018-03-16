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


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    oneView *view = [[oneView alloc] initWithFrame:self.view.bounds];
//    view.controller = self;
//    self.oneView = view;
//    [self.view addSubview:view];

    pView = [[profView alloc] initWithFrame:self.view.bounds];
    self.view = pView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

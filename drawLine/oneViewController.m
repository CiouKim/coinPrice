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
    
    if(view == nil) {
        view = [[LineView alloc] initWithFrame:self.view.bounds];
    }

    view.type = self.cointype;
    self.lineView = view;
    [view setDrawData];
    [self.view addSubview:view];
    
    UIBarButtonItem *BackBtn = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = BackBtn;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(UIBarButtonItem *)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end

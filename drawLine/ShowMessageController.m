//
//  ShowMessageController.m
//  drawLine
//
//  Created by Chinalife on 2018/5/28.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import "ShowMessageController.h"

@interface ShowMessageController ()

@end

@implementation ShowMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)setMessage:(NSString *)message {
//    self.messageTitle.text = message;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnClick:(id)sender {
    NSLog(@"%@", self.messageTitle.text);
}
@end

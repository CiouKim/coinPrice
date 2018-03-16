//
//  LineView.h
//  drawLine
//
//  Created by Chinalife on 2018/1/2.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@class oneViewController;
@class ViewController;

@interface LineView : UIView <UIScrollViewDelegate>{
    UIScrollView *scrollView;
    NSNumber *maxNumber;
}

@property(nonatomic, strong)  oneViewController * oneCtr;
@property(nonatomic, strong)  ViewController* controller;
@property(nonatomic, assign) int type;

-(void)setDrawData;
@end

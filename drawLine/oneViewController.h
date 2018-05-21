//
//  oneViewController.h
//  drawLine
//
//  Created by Chinalife on 2018/1/4.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import "ViewController.h"
#import "LineView.h"
#import "oneView.h"
@class LineView;

@interface oneViewController : UIViewController {
    LineView *view;
    oneView *oView;
}

@property (nonatomic) LineView * lineView;
@property(nonatomic ,assign) int cointype;
@end

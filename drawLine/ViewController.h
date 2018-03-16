//
//  ViewController.h
//  drawLine
//
//  Created by Chinalife on 2018/1/2.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineView.h"
#import "oneView.h"
#import "profView.h"

@class LineView;
@class oneView;
@class profView;

@interface ViewController : UIViewController {
    
    profView *pView;
}

@property (nonatomic) LineView * lineView;
@property (nonatomic) oneView *oneView;


@end


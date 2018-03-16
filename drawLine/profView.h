//
//  profView.h
//  drawLine
//
//  Created by Chinalife on 2018/3/15.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface profView : UIView <UITableViewDelegate, UITableViewDataSource > {
    UILabel *laBTCValue;
    UITableView *tTableView;
    UIButton *refreshBtn;
    UIButton *bestBtn;

}

@property (nonatomic, strong)  ViewController* controller;
@property (nonatomic, readonly) NSMutableArray *gpuGroups;
@property (nonatomic, readonly) NSMutableArray *gpuProf;

@property float currentBTCPrice;


@end

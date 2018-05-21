//
//  profView.h
//  drawLine
//
//  Created by Chinalife on 2018/3/15.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Popup.h"
#import "oneViewController.h"


@interface profView : UIView <UITableViewDelegate, UITableViewDataSource, PopupDelegate> {
    UILabel *laBTCValue;
    UITableView *tTableView;
    UIButton *refreshBtn;
    UIButton *bestBtn;
    UIButton *profitBtn;
    UIButton *assumeBtn;

    UIActivityIndicatorView *spinner;
    Popup *popper;
    
    oneViewController *oneVC;
    
    PopupBackGroundBlurType blurType;
    PopupIncomingTransitionType incomingType;
    PopupOutgoingTransitionType outgoingType;
}

@property (nonatomic, strong)  ViewController* controller;
@property (nonatomic, readonly) NSMutableArray *gpuGroups;
@property (nonatomic, readonly) NSMutableArray *gpuProf;

@property float currentBTCPrice;
@property float currentETHPrice;
@property float currentLTCPrice;
@property float currentSCPrice;


@end

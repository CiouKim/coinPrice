//
//  oneView.h
//  drawLine
//
//  Created by Chinalife on 2018/1/4.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class oneViewController;
@class ViewController;


typedef enum {
    btcType = 0,
    ethType,
    ltcType
} CoinType;


@interface oneView : UIView <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    UIButton *ethBtn;
    UIButton *btcBtn;
    UIButton *ltcBtn;
    UIImageView *imgLogo;
    UITableView *tTableView;
    UITextField *iCloudKeyfield;
    UIButton *iCloudUploadBtn;
    UIActivityIndicatorView *spinner;
    UILabel *label;
}

@property (nonatomic, strong)  oneViewController * oneCtr;
@property (nonatomic, strong)  ViewController* controller;
@property (strong, nonatomic) NSMetadataQuery *query;
@property (strong, nonatomic) NSMutableArray *fileList;
@property (strong, nonatomic) NSArray *filedateArray;
@property (nonatomic, assign) CoinType coinType;


@end

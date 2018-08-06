//
//  oneView.h
//  drawLine
//
//  Created by Chinalife on 2018/1/4.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Popup.h"

@class oneViewController;
@class ViewController;


@interface oneView : UIView <UITextFieldDelegate, PopupDelegate>{
    UILabel *nv1063;
    UILabel *nv1070ti;
    UILabel *nv1080;
    UILabel *amd570;
    
    UILabel *nv1063a;
    UILabel *nv1070tia;
    UILabel *nv1080a;
    UILabel *amd570a;

    UITextField *nv1063Field;
    UITextField *nv1070tiField;
    UITextField *nv1080Field;
    UITextField *amd570Field;
    
    UIButton *calcularBtn;
    UIButton *reloadDataBtn;
    
    UILabel *assumeIcomeLab;
    
    UIActivityIndicatorView *spinner;
    
    Popup *popper;
    
    PopupBackGroundBlurType blurType;
    PopupIncomingTransitionType incomingType;
    PopupOutgoingTransitionType outgoingType;
}

@property (nonatomic, readonly) NSMutableArray *gpuGroups;
@property (nonatomic, readonly) NSMutableArray *gpuProf;

@property float currentBTCPrice;

- (void) getData;
- (void) initWithFrame:(CGRect)frame controller:(UIViewController *)vc;

@end

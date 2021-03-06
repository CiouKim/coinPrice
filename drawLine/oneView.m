//
//  oneView.m
//  drawLine
//
//  Created by Chinalife on 2018/1/4.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import "oneView.h"
#import "oneViewController.h"
#import "LineView.h"
#import "RTLabel.h"
#import "iCloudHelper.h"
#import "GpuType.h"


#define coinPriceUrl @"https://api.nicehash.com/api?method=simplemultialgo.info"
#define balanceUrl @"https://auto-mover.firebaseio.com/balance.json"
#define currentCoinPrice @"https://api.coinmarketcap.com/v1/ticker/?limit=50"

@implementation oneView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    int edge = 5;
    int gap = 55;
    int labelWidth = 150;
    int labelHeight = 30;
    int edgeField = 285;
    int aField = 130;
    int labeloriginalY = 40;
    int fieldWidth = 50;
    
    nv1063 = [[UILabel alloc] initWithFrame:CGRectMake(edge, labeloriginalY, labelWidth, labelHeight)];
    [self setGPUCardNameStyle:nv1063 CardName:@"Nvidia-1063"];
    [self addSubview:nv1063];
    
    nv1063a = [[UILabel alloc] initWithFrame:CGRectMake(aField, labeloriginalY, labelWidth, labelHeight)];
    [self setGPUCardBestAlgorithmStyle:nv1063a];
    [self addSubview:nv1063a];
    
    nv1063Field = [[UITextField alloc] initWithFrame:CGRectMake(edgeField, labeloriginalY, fieldWidth, labelHeight)];
    nv1063Field.tag = 1063;
    [self setFieldStyle:nv1063Field];
    [self addSubview:nv1063Field];
    
    labeloriginalY += gap;
    
    nv1070ti = [[UILabel alloc] initWithFrame:CGRectMake(edge, labeloriginalY, labelWidth, labelHeight)];
    [self setGPUCardNameStyle:nv1070ti CardName:@"Nvidia-1070ti"];
    nv1070ti.text = @"Nvidia-1070ti";
    [self addSubview:nv1070ti];
    
    nv1070tia = [[UILabel alloc] initWithFrame:CGRectMake(aField, labeloriginalY, labelWidth, labelHeight)];
    [self setGPUCardBestAlgorithmStyle:nv1070tia];
    [self addSubview:nv1070tia];
    
    nv1070tiField = [[UITextField alloc] initWithFrame:CGRectMake(edgeField, labeloriginalY, fieldWidth, labelHeight)];
    nv1070tiField.tag = 1071;
    [self setFieldStyle:nv1070tiField];
    [self addSubview:nv1070tiField];
    
    labeloriginalY += gap;
    
    
    nv1080 = [[UILabel alloc] initWithFrame:CGRectMake(edge, labeloriginalY, labelWidth, labelHeight)];
    [self setGPUCardNameStyle:nv1080 CardName:@"Nvidia-1080"];
    [self addSubview:nv1080];
    
    nv1080a = [[UILabel alloc] initWithFrame:CGRectMake(aField, labeloriginalY, labelWidth, labelHeight)];
    [self setGPUCardBestAlgorithmStyle:nv1080a];
    [self addSubview:nv1080a];
    
    nv1080Field = [[UITextField alloc] initWithFrame:CGRectMake(edgeField, labeloriginalY, fieldWidth, labelHeight)];
    nv1080Field.tag = 1080;
    [self setFieldStyle:nv1080Field];
    [self addSubview:nv1080Field];
    
    labeloriginalY += gap;
    
    amd570 = [[UILabel alloc] initWithFrame:CGRectMake(edge, labeloriginalY, labelWidth, labelHeight)];
    [self setGPUCardNameStyle:amd570 CardName:@"AMD-570"];
    [self addSubview:amd570];
    
    amd570a = [[UILabel alloc] initWithFrame:CGRectMake(aField, labeloriginalY, labelWidth, labelHeight)];
    [self setGPUCardBestAlgorithmStyle:amd570a];
    [self addSubview:amd570a];
    
    amd570Field = [[UITextField alloc] initWithFrame:CGRectMake(edgeField, labeloriginalY, fieldWidth, labelHeight)];
    amd570Field.tag = 570;
    [self setFieldStyle:amd570Field];
    [self addSubview:amd570Field];
    
    reloadDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadDataBtn.layer.opacity = .70;
    reloadDataBtn.layer.cornerRadius = 25.0;
    reloadDataBtn.backgroundColor = [UIColor colorWithRed:0.57 green:0.62 blue:0.90 alpha:1.0];
    [reloadDataBtn addTarget:self action:@selector(getData) forControlEvents:UIControlEventTouchUpInside];
    [reloadDataBtn setTitle:@"ReGetData" forState:UIControlStateNormal];
    reloadDataBtn.frame = CGRectMake(self.frame.size.width/2 - 75, self.frame.size.height -  330, 150, 50);
    [self addSubview:reloadDataBtn];
    
    calcularBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    calcularBtn.layer.opacity = .70;
    calcularBtn.layer.cornerRadius = 25.0;
    calcularBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:6.0/255.0 blue:40.0/255.0 alpha:1.0];
    [calcularBtn addTarget:self action:@selector(calcularBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [calcularBtn setTitle:@"Calcular" forState:UIControlStateNormal];
    calcularBtn.frame = CGRectMake(self.frame.size.width/2 - 75, self.frame.size.height -  250, 150, 50);
    [self addSubview:calcularBtn];
    
    assumeIcomeLab = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 75, self.frame.size.height -  150, 150, 50)];
    assumeIcomeLab.text = @"Total:0 USDT";
    [assumeIcomeLab setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [assumeIcomeLab setAdjustsFontSizeToFitWidth:YES];
    [assumeIcomeLab setTextAlignment:NSTextAlignmentCenter];
    [assumeIcomeLab setTextColor:[UIColor colorWithRed:0.329 green:0.396 blue:0.584 alpha:1]];
    [self addSubview:assumeIcomeLab];
    
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 100);
    spinner.hidesWhenStopped = YES;
    [self addSubview:spinner];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tapGesture];//removed keyboard

#pragma mark - Setup test targetDataArray
    self.targetDataArray = @[@"2050006053", @"2050006026", @"2050006050"];
//    self.targetDataArray = @[@"2050004053", @"2050006026", @"2050006050"];

    [self getRuleData:[[NSBundle mainBundle] pathForResource:@"Rule" ofType:@"json"]];
        
    return self;
}

- (void)tap:(id)sender {
    [self endEditing:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (NSDictionary *)jsonFromFile:(NSString *)path {
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)readJsonfileToDictionary:(NSString *)urlString Completion:(void (^) (NSDictionary *result, NSError *err))completion {
    [spinner startAnimating];
    NSURL *JSONURL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:JSONURL];
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession]
                                       dataTaskWithRequest:request
                                       completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                           if (data == nil) {
                                               completion(nil, error);
                                               return;
                                           }
                                           NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                           NSData* jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
                                           NSError *errDic;
                                           NSDictionary *jsonDataDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                                                       options:0
                                                                                                         error:&errDic];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               [spinner stopAnimating];
                                           });
                                           
                                           completion(jsonDataDic, errDic);
                                       }];
    [dataTask resume];
}

- (void)getInitGPUData:(NSString *)url {
    if (_gpuGroups == nil) {
        _gpuGroups = [[NSMutableArray alloc] init];
    }
    
    [_gpuGroups removeAllObjects];
    NSArray *arr = [[[self jsonFromFile:url] valueForKey:@"GPUData"] allObjects];
    
    for (NSDictionary *gpuDic in arr) {
        GpuType *gpu = [[GpuType alloc] init];
        gpu.gpuName = [NSString stringWithFormat:@"%@", [gpuDic valueForKey:@"GPU"]];
        gpu.daggerhashimoto = [[gpuDic valueForKey:@"daggerhashimoto"] intValue];
        gpu.equihash = [[gpuDic valueForKey:@"equihash"] intValue];
        gpu.lyra2rev2 = [[gpuDic valueForKey:@"lyra2rev2"] intValue];
        gpu.neoscrypt = [[gpuDic valueForKey:@"neoscrypt"] intValue];
        gpu.nist5 = [[gpuDic valueForKey:@"nist5"] intValue];
        gpu.costWatt = [[gpuDic valueForKey:@"CostWatt"] intValue];
        [_gpuGroups addObject:gpu];
    }
}

- (void)setGPUCardBestAlgorithmStyle:(UILabel *)label {
    label.text = @"";
    [label setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setTextColor:[UIColor colorWithRed:0.64 green:0.90 blue:0.57 alpha:1.0]];
}

- (void)setGPUCardNameStyle:(UILabel *)label CardName:(NSString *)cardName {
    label.text = cardName;
    [label setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor colorWithRed:0.329 green:0.396 blue:0.584 alpha:1]];
}

- (void)setFieldStyle:(UITextField *)field {
    field.delegate = self;
    [field setKeyboardType:UIKeyboardTypeDefault];
    [field setBorderStyle:UITextBorderStyleNone];
    [field setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]];
    [field setTextColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.9]];
    [field setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
    [field setSpellCheckingType:UITextSpellCheckingTypeNo];
    [field setAutocorrectionType:UITextAutocorrectionTypeNo];
    [field setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [field setKeyboardAppearance:UIKeyboardAppearanceDark];
    [field.layer setBorderColor:[UIColor colorWithWhite:0.8 alpha:1.0].CGColor];
    [field.layer setBorderWidth:1.0];
    [field.layer setCornerRadius:4.0];
    [field setTextAlignment:NSTextAlignmentCenter];
    [field setPlaceholder:@"片"];
    [field setDelegate:self];
    [field.layer setMasksToBounds:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(string.length > 0) {
        NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:string];
        
        BOOL stringIsValid = [numbersOnly isSupersetOfSet:characterSetFromTextField];
        return stringIsValid;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)getCoinPrice:(NSString *)url {
    [self readJsonfileToDictionary:url Completion:^(NSDictionary *result, NSError *err) {
        if (err != nil) {
            [self showMsg:@"ErrorMessage" subTitle:err.description];
            return;
        }
        
        for (NSDictionary *dic in result) {
            if ([[dic valueForKey:@"id"] isEqualToString:@"bitcoin"]) {//btc
                self.currentBTCPrice = [[dic valueForKey:@"price_usd"] floatValue];
            }
        }
    }];
}

- (void)getCurrentCoinPrice:(NSString *)url {
    [spinner startAnimating];
    [self readJsonfileToDictionary:url Completion:^(NSDictionary *result, NSError *err) {
        if (err != nil) {
            [self showMsg:@"ErrorMessage" subTitle:err.description];
            [spinner stopAnimating];
            return;
        }
        
        NSArray *arr = [[result valueForKey:@"result"] valueForKey:@"simplemultialgo"];
        float equihashValue = [[arr[24] valueForKey:@"paying"] floatValue] / 1000 / 1000 / 1000;
        float neoscryptValue = [[arr[8] valueForKey:@"paying"] floatValue] / 1000 / 1000 / 1000;
        float nist5Value = [[arr[7] valueForKey:@"paying"] floatValue] / 1000 / 1000 / 1000;
        float lyra2rev2Value = [[arr[14] valueForKey:@"paying"] floatValue] / 1000 / 1000 / 1000;
        float daggerhashimotoValue = [[arr[20] valueForKey:@"paying"] floatValue] / 1000 / 1000 / 1000;
        
        if (_gpuProf == nil) {
            _gpuProf = [[NSMutableArray alloc] init];
        }
        [_gpuProf removeAllObjects];
        
        for (GpuType *gCard in self.gpuGroups) {
            NSMutableArray *arrData = [[NSMutableArray alloc] init];
            NSString *name = gCard.gpuName;
            float electricCostFee = gCard.costWatt * 24 * 0.085 * 0.001;//default ele fee w * 24h *0.085usd *0.001
            float euq = gCard.equihash * equihashValue * _currentBTCPrice - electricCostFee;
            float neo = gCard.neoscrypt * neoscryptValue * _currentBTCPrice - electricCostFee;
            float nist5 = gCard.nist5 * nist5Value * _currentBTCPrice - electricCostFee;
            float lyra2rev2 = gCard.lyra2rev2 * lyra2rev2Value * _currentBTCPrice - electricCostFee;
            float dag = gCard.daggerhashimoto * daggerhashimotoValue * _currentBTCPrice - electricCostFee;
            
            [arrData addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%1.3f", euq], @"profValue",
                                @"equihash", @"algorithm", nil]];
            [arrData addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%1.3f", neo], @"profValue",
                                @"neoscrypt", @"algorithm", nil]];
            [arrData addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%1.3f", nist5], @"profValue",
                                @"nist5", @"algorithm", nil]];
            [arrData addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%1.3f", lyra2rev2], @"profValue",
                                @"lyra2rev2", @"algorithm", nil]];
            [arrData addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%1.3f", dag], @"profValue",
                                @"daggerhashimoto", @"algorithm", nil]];
            
            NSString *fAlgorithmValue = [NSString stringWithFormat:@"%.3f", [self getBestAlgorithmValue:arrData]];
            [_gpuProf addObject:[NSDictionary dictionaryWithObjectsAndKeys:arrData, @"Data", name, @"Key", fAlgorithmValue, @"bestAlgorithmValue", nil]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            nv1063a.text = [NSString stringWithFormat:@"%@", [self getBestAlgorithm:@"1063"]];
            nv1070tia.text = [NSString stringWithFormat:@"%@", [self getBestAlgorithm:@"1070TI"]];
            nv1080a.text = [NSString stringWithFormat:@"%@", [self getBestAlgorithm:@"1080"]];
            amd570a.text = [NSString stringWithFormat:@"%@", [self getBestAlgorithm:@"RX570"]];
            
            [spinner stopAnimating];
        });
    }];
}

- (void)showMsg:(NSString *)title subTitle:(NSString *)subTitle {
    popper = [[Popup alloc] initWithTitle:title subTitle:subTitle cancelTitle:@"" successTitle:@"確定"];
    [popper setDelegate:self];
    [popper setBackgroundBlurType:blurType];
    [popper setIncomingTransition:incomingType];
    [popper setOutgoingTransition:outgoingType];
    [popper setRoundedCorners:YES];
    [popper showPopup];
}

- (void)calcularBtnClick {
    int nv1063num = nv1063Field.text == nil ? 0 : [nv1063Field.text intValue];
    int nv1070tinum = nv1070tiField.text == nil ? 0 : [nv1070tiField.text intValue];
    int nv1080num = nv1080Field.text == nil ? 0 : [nv1080Field.text intValue];
    int amd570num = amd570Field.text == nil ? 0 : [amd570Field.text intValue];
    float total = 0.0;
    for (NSDictionary *dic in self.gpuProf) {
        if ([[dic valueForKey:@"Key"] isEqualToString:@"RX570"]) {
            total += amd570num* [[dic valueForKey:@"bestAlgorithmValue"] floatValue];
        }
        
        if ([[dic valueForKey:@"Key"] isEqualToString:@"1063"]) {
            total += nv1063num* [[dic valueForKey:@"bestAlgorithmValue"] floatValue];
        }
        
        if ([[dic valueForKey:@"Key"] isEqualToString:@"1070TI"]) {
            total += nv1070tinum* [[dic valueForKey:@"bestAlgorithmValue"] floatValue];
        }
        
        if ([[dic valueForKey:@"Key"] isEqualToString:@"1080"]) {
            total += nv1080num* [[dic valueForKey:@"bestAlgorithmValue"] floatValue];
        }
    }
    assumeIcomeLab.text = [NSString stringWithFormat:@"Total:%.3f USDT", total];
}

- (void)getData {
    [self getInitGPUData:[[NSBundle mainBundle] pathForResource:@"GpuGroup" ofType:@"json"]];
    [self getCoinPrice:currentCoinPrice];
    [self getCurrentCoinPrice:coinPriceUrl];
}

- (float)getBestAlgorithmValue:(NSArray *)data {
    float maxValue = 0;
    for (NSDictionary *dic in data) {
        if ([[dic valueForKey:@"profValue"] floatValue] > maxValue) {
            maxValue = [[dic valueForKey:@"profValue"] floatValue];
        }
    }
    return maxValue;
}

- (NSString *)getBestAlgorithm:(NSString *)str {
    float maxValue = 0;
    NSString *stirng = @"";
    for (NSDictionary *dic in _gpuProf) {
        if ([[dic valueForKey:@"Key"] isEqualToString:str]) {
            for (NSDictionary *d in [[dic valueForKey:@"Data"] allObjects]) {
                if ([[d valueForKey:@"profValue"] floatValue] > maxValue) {
                    maxValue = [[d valueForKey:@"profValue"] floatValue];
                    stirng = [d valueForKey:@"algorithm"];
                }
            }
        }
    }
    return stirng;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self calcularBtnClick];
}

#pragma mark - testRuleMethod
- (void)getRuleData:(NSString *)path {
    BOOL hasError = NO;
    NSArray *arr = [[[self jsonFromFile:path] valueForKey:@"Rule"] allObjects];//get all ProductRule
    
    for (NSDictionary *dic in arr) {
        if ([self isContainMainRule:[dic valueForKey:@"mainRoleProductID"]] && [self isContainDenyRoles:[dic valueForKey:@"denyRoleProduces"]] == [[dic valueForKey:@"isPHeqIO"] boolValue]) {
            NSLog(@"rule crash need show message");
            hasError = YES;
        }
    }
    
    if (hasError == NO) {
         NSLog(@"rule pass");
    }
}

#pragma mark - checkDenyRoles
- (BOOL)isContainDenyRoles:(id<NSFastEnumeration>)ruleArray {
    for (id denyRole in ruleArray) {
        if ([self.targetDataArray containsObject:denyRole] == YES) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - checkRule
- (BOOL)isContainMainRule:(NSString *)mainRuleStr {
    if ([self.targetDataArray containsObject:mainRuleStr] == YES) {
        return YES;
    }
    return NO;
}

@end


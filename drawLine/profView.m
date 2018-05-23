//
//  profView.m
//  drawLine
//
//  Created by Chinalife on 2018/3/15.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import "profView.h"
#import "oneViewController.h"
#import "GpuType.h"

#define coinPriceUrl @"https://api.nicehash.com/api?method=simplemultialgo.info"
#define balanceUrl @"https://auto-mover.firebaseio.com/balance.json"
#define currentCoinPrice @"https://api.coinmarketcap.com/v1/ticker/?limit=50"

@implementation profView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    
    laBTCValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.frame.size.width -20, 50)];
    laBTCValue.backgroundColor = [UIColor clearColor];
    laBTCValue.textColor = [UIColor blackColor];
    laBTCValue.textAlignment = NSTextAlignmentCenter;
    laBTCValue.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:laBTCValue];
    
    tTableView = [[UITableView alloc]init];
    tTableView.showsVerticalScrollIndicator = NO;
    tTableView.delegate = self;
    tTableView.dataSource = self;
    tTableView.frame = CGRectMake(20, 80, self.frame.size.width - 40, 300);
    tTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self addSubview:tTableView];
    
    refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.layer.opacity = .70;
    refreshBtn.layer.cornerRadius = 25.0;
    refreshBtn.backgroundColor = [UIColor colorWithRed:10/255.0 green:107/255.0 blue:171/255.0 alpha:1.0];
    [refreshBtn addTarget:self action:@selector(refeeshClick) forControlEvents:UIControlEventTouchUpInside];
    [refreshBtn setTitle:@"R" forState:UIControlStateNormal];
    refreshBtn.frame = CGRectMake(7, 420, 50, 50);
    [self addSubview:refreshBtn];
    
    bestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bestBtn.layer.opacity = .70;
    bestBtn.layer.cornerRadius = 25.0;
    bestBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:6.0/255.0 blue:40.0/255.0 alpha:1.0];
    [bestBtn addTarget:self action:@selector(getBestAlgorithmForGPU) forControlEvents:UIControlEventTouchUpInside];
    [bestBtn setTitle:@"B" forState:UIControlStateNormal];
    bestBtn.frame = CGRectMake(77, 420, 50, 50);
    [self addSubview:bestBtn];
    
    profitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    profitBtn.layer.opacity = .70;
    profitBtn.layer.cornerRadius = 25.0;
    profitBtn.backgroundColor = [UIColor colorWithRed:64.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1.0];
    [profitBtn addTarget:self action:@selector(getProfit) forControlEvents:UIControlEventTouchUpInside];
    [profitBtn setTitle:@"P" forState:UIControlStateNormal];
    profitBtn.frame = CGRectMake(157, 420, 50, 50);
    [self addSubview:profitBtn];
    
    priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    priceBtn.layer.opacity = .70;
    priceBtn.layer.cornerRadius = 25.0;
    priceBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:102.0/255.0 blue:217.0/255.0 alpha:1.0];
    [priceBtn addTarget:self action:@selector(priceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [priceBtn setTitle:@"L" forState:UIControlStateNormal];
    priceBtn.frame = CGRectMake(237, 420, 50, 50);
    [self addSubview:priceBtn];

    assumeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    assumeBtn.layer.opacity = .70;
    assumeBtn.layer.cornerRadius = 25.0;
    assumeBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:184.0/255.0 blue:77.0/255.0 alpha:1.0];
    [assumeBtn addTarget:self action:@selector(assumeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [assumeBtn setTitle:@"A" forState:UIControlStateNormal];
    assumeBtn.frame = CGRectMake(317, 420, 50, 50);
    [self addSubview:assumeBtn];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 100);
    spinner.hidesWhenStopped = YES;
    [self addSubview:spinner];
    
    
    [self getInitGPUData:[[NSBundle mainBundle] pathForResource:@"GpuGroup" ofType:@"json"]];

    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    
    [self refeeshClick];
    
    return self;
}

- (void)refeeshClick {
    [self getCoinPrice:currentCoinPrice];
    [self getCurrentCoinPrice:coinPriceUrl];
}

- (void)updateTime:(NSTimer *)timer {
    [self refeeshClick];
}

- (void)getInitGPUData:(NSString *)url {
    if (_gpuGroups == nil) {
        _gpuGroups = [[NSMutableArray alloc] init];
    }
    
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
            if ([[dic valueForKey:@"id"] isEqualToString:@"ethereum"]) {//eth
                self.currentETHPrice = [[dic valueForKey:@"price_usd"] floatValue];
            }
            if ([[dic valueForKey:@"id"] isEqualToString:@"litecoin"]) {//ltc
                self.currentLTCPrice = [[dic valueForKey:@"price_usd"] floatValue];
            }
            if ([[dic valueForKey:@"id"] isEqualToString:@"siacoin"]) {//sc
                self.currentSCPrice = [[dic valueForKey:@"price_usd"] floatValue];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            laBTCValue.text = [NSString stringWithFormat:@"BTC:%1.3f$ ETH:%1.3f$ LTC:%1.3f$", self.currentBTCPrice, self.currentETHPrice, self.currentLTCPrice];
        });
    }];
}

- (void)getCurrentCoinPrice:(NSString *)url {
    [spinner startAnimating];
    [self readJsonfileToDictionary:url Completion:^(NSDictionary *result, NSError *err) {
        if (err != nil) {
            [self showMsg:@"ErrorMessage" subTitle:err.description];
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
            float costEfee = gCard.costWatt * 24 * 0.085 * 0.001;//default ele fee w * 24h *0.085usd *0.001
            float euq = gCard.equihash * equihashValue * _currentBTCPrice - costEfee;
            float neo = gCard.neoscrypt * neoscryptValue * _currentBTCPrice - costEfee;
            float nist5 = gCard.nist5 * nist5Value * _currentBTCPrice - costEfee;
            float lyra2rev2 = gCard.lyra2rev2 * lyra2rev2Value * _currentBTCPrice - costEfee;
            float dag = gCard.daggerhashimoto * daggerhashimotoValue * _currentBTCPrice - costEfee;
            
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
            [_gpuProf addObject:[NSDictionary dictionaryWithObjectsAndKeys:arrData, @"Data", name, @"Key", nil]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner stopAnimating];
            [tTableView reloadData];
        });
    }];
}

- (NSDictionary *)jsonFromFile:(NSString *)path {
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)readJsonfileToDictionary:(NSString *)urlString Completion:(void (^) (NSDictionary * result, NSError * err))completion {
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.gpuProf.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.gpuProf[section] valueForKey:@"Data"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_gpuProf[section] valueForKey:@"Key"];
}

#pragma -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12];
    
    NSString *profValue = [[self.gpuProf[indexPath.section] valueForKey:@"Data"][indexPath.row] valueForKey:@"profValue"];
    NSString *algorithm = [[self.gpuProf[indexPath.section] valueForKey:@"Data"][indexPath.row] valueForKey:@"algorithm"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ => %@ $", algorithm, profValue];
    return cell;
}

- (void)getBestAlgorithmForGPU {
    NSMutableString *msg = [[NSMutableString alloc] init];
    for (NSDictionary *dic in _gpuProf) {
        NSString *gpuName = [dic valueForKey:@"Key"];
        NSString *betteralg = [self findMaxValue:[[dic valueForKey:@"Data"] allObjects]];
        [msg appendFormat: @"%@  %@$ \n", gpuName, betteralg];
    }
    [self showMsg:@"Best Algorithm" subTitle:msg];
}

- (void)getProfit {
    [spinner startAnimating];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:balanceUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
          float btc = 0.0;
          float eth = 0.0;
          float ltc = 0.0;
          float sc = 0.0;
          NSArray *arr = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] allObjects];
          for (NSDictionary *dic in arr) {
              if ([dic valueForKey:@"BTC"] != nil) {
                  btc = btc + [[dic valueForKey:@"BTC"] floatValue];
              }
              if ([dic valueForKey:@"ETH"] != nil) {
                  eth = eth + [[dic valueForKey:@"ETH"] floatValue];
              }
              if ([dic valueForKey:@"LTC"] != nil) {
                  ltc = ltc + [[dic valueForKey:@"LTC"] floatValue];
              }
              if ([dic valueForKey:@"SC"] != nil) {
                  sc = sc + [[dic valueForKey:@"SC"] floatValue];
              }
          }
          NSString *msg = [NSString stringWithFormat:@"BTC:%1.5f\n ETH:%1.3f\n LTC:%1.3f\n SC:%1.3f\n Profit:%1.3f$", btc, eth, ltc, sc, btc*_currentBTCPrice + eth*_currentETHPrice + ltc*_currentLTCPrice + sc *_currentSCPrice];
          dispatch_async(dispatch_get_main_queue(), ^{
              [spinner stopAnimating];
              [self showMsg:@"Ｐroperty" subTitle:msg];
          });
      }] resume];
}

- (void)assumeBtnClick {
    if (oneVC == nil) {
        oneVC = [[oneViewController alloc] init];
    }
    [self.controller.navigationController pushViewController:oneVC animated:NO];
}

- (void)priceBtnClick {
    NSMutableString *msg = [[NSMutableString alloc] init];
    [msg appendFormat: @"BTC:%.4f\n", self.currentBTCPrice];
    [msg appendFormat: @"ETH:%.4f\n", self.currentETHPrice];
    [msg appendFormat: @"LTC:%.4f\n", self.currentLTCPrice];
    [msg appendFormat: @"SC:%.4f\n", self.currentSCPrice];
    [self showMsg:@"Coin Price" subTitle:msg];
}

- (NSString *)findMaxValue:(NSArray *)dataArray {
    float MaxValue = 0;
    NSString *algorithmType = @"";
    for (NSDictionary *d in dataArray) {
        if ([[d valueForKey:@"profValue"] floatValue] > MaxValue) {
            MaxValue = [[d valueForKey:@"profValue"] floatValue];
            algorithmType = [d valueForKey:@"algorithm"];
        }
    }
    return  [NSString stringWithFormat:@"%@:%1.2f", algorithmType, MaxValue];
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

@end


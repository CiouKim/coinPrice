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

#define btcToEth @"https://bittrex.com/api/v1.1/public/getmarketsummary?market=btc-eth"
#define checkJsonURL @"https://clifeuat.s3.hicloud.net.tw/test/check.json"
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"//英文
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"//英文數字


@implementation oneView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor clearColor];
    
    imgLogo = [[UIImageView alloc] init];
    imgLogo.image = [UIImage imageNamed: @"apple"];
    imgLogo.frame = CGRectMake(20, 470, 50, 50);
    [self addSubview:imgLogo];
    
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documentsPath = paths.firstObject;
    //    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"fileVersion.plist"];
    
    //    if file no exist fileVersion.plist means app is launch fist time write all json
    //    else write unwrite or version change datas to fileVersion.plist
    
    //    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath] == NO) {
    //        [self readJsonfileToDictionary:checkJsonURL];
    ////        [self readJsonfileToDictionary:[[NSBundle mainBundle] pathForResource:@"jsonData" ofType:@"json"]];
    //        //        sample jsaonData.json =>> replace server all file data json file
    //    } else {
    //         [self readJsonfileToDictionary:checkJsonURL];
    ////        [self readJsonfileToDictionary:[[NSBundle mainBundle] pathForResource:@"jsonDataNew" ofType:@"json"]];
    //        //        sample jsonDataNew.jason =>> replace server new file data json file
    //    }
    
    
    ////    test get url json
    //    NSString *str = [self getDataFrom:checkJsonURL];
    //
    //    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    //    NSArray *jasonDataArray = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] valueForKey:@"files"];
    //
    //
    //    NSLog(@"str:%@", jasonDataArray);
    
    
#pragma mark -test HTML to label
    //    RTLabel *label = [[RTLabel alloc] init];
    //    [label setParagraphReplacement:@""];
    //
    //    NSString *dbstring = @"<@B>保單借款利率屬短期利率且具變動性，通常高於保單預定利率。另外，保戶辦理保單借款必須支付高於按保單預定利率計算之利息、中途解約亦可能有損失或無法獲得複利增值。</B><br><@B>保單借款利率屬短期利率且具變動性，通常高於保單預定利率。另外，保戶辦理保單借款必須支付高於按保單預定利率計算之利息、中途解約亦可能有損失或無法獲得複利增值。</B><br><@B>保單借款利率屬短期利率且具變動性，通常高於保單預定利率。另外，保戶辦理保單借款必須支付高於按保單預定利率計算之利息、中途解約亦可能有損失或無法獲得複利增值。</B><br><@B>保單借款利率屬短期利率且具變動性，通常高於保單預定利率。另外，保戶辦理保單借款必須支付高於按保單預定利率計算之利息、中途解約亦可能有損失或無法獲得複利增值。</B><br><@B>保單借款利率屬短期利率且具變動性，通常高於保單預定利率。另外，保戶辦理保單借款必須支付高於按保單預定利率計算之利息、中途解約亦可能有損失或無法獲得複利增值。</B><br><@B>保單借款利率屬短期利率且具變動性，通常高於保單預定利率。另外，保戶辦理保單借款必須支付高於按保單預定利率計算之利息、中途解約亦可能有損失或無法獲得複利增值。</B><br><@B>保單借款利率屬短期利率且具變動性，通常高於保單預定利率。另外，保戶辦理保單借款必須支付高於按保單預定利率計算之利息、中途解約亦可能有損失或無法獲得複利增值。</B><br><@B>保單借款利率屬短期利率且具變動性，通常高於保單預定利率。另外，保戶辦理保單借款必須支付高於按保單預定利率計算之利息、中途解約亦可能有損失或無法獲得複利增值。</B><br><@B>保單借款利率屬短期利率且具變動性，通常高於保單預定利率。另外，保戶辦理保單借款必須支付高於按保單預定利率計算之利息、中途解約亦可能有損失或無法獲得複利增值。</B><br><@B>保單借款利率屬短期利率且具變動性，通常高於保單預定利率。另外，保戶辦理保單借款必須支付高於按保單預定利率計算之利息、中途解約亦可能有損失或無法獲得複利增值。</B><br>";
    //    [label setText:dbstring];
    //
    //    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:dbstring];
    //    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    //    style.lineSpacing = 12;
    //    UIFont *font = [UIFont systemFontOfSize:14];
    //    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, dbstring.length)];
    //    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, dbstring.length)];
    //    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    //    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(self.frame.size.width - 60, CGFLOAT_MAX) options:options context:nil];
    //
    //    [label setFrame:CGRectMake(30, 10, rect.size.width, rect.size.width)];
    //    [self addSubview:label];
    
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(self.frame.size.width/4, self.frame.size.height/4);
    spinner.hidesWhenStopped = YES;
    [spinner setColor: [UIColor grayColor]];
    [self addSubview:spinner];
    
    iCloudKeyfield = [[UITextField alloc] init];
    iCloudKeyfield.backgroundColor = [UIColor whiteColor];
    iCloudKeyfield.layer.borderWidth = .5;
    iCloudKeyfield.layer.cornerRadius = 5.0;
    iCloudKeyfield.layer.opacity = .64;
    iCloudKeyfield.frame = CGRectMake(20, 80, 140, 40);
    iCloudKeyfield.delegate = self;
    [self addSubview:iCloudKeyfield];
    
    iCloudUploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [iCloudUploadBtn setTitle:@"iCloud上傳" forState:UIControlStateNormal];
    iCloudUploadBtn.layer.opacity = .64;
    iCloudUploadBtn.layer.cornerRadius = 5.0;
    iCloudUploadBtn.backgroundColor = [UIColor blueColor];
    [iCloudUploadBtn addTarget:self action:@selector(iCloudUploadBtnClick) forControlEvents:UIControlEventTouchUpInside];
    iCloudUploadBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    iCloudUploadBtn.frame = CGRectMake(200, 80, 100, 40);
    [self addSubview:iCloudUploadBtn];
    
    tTableView = [[UITableView alloc]init];
    tTableView.showsVerticalScrollIndicator = NO;
    tTableView.delegate = self;
    tTableView.dataSource = self;
    tTableView.frame = CGRectMake(20, 160, 420, 260);
    tTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [self addSubview:tTableView];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(150, 470, 120, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
//    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    label.adjustsFontSizeToFitWidth = YES;
    label.text = @"11111";
    [self addSubview:label];

    
    
#pragma mark -iCloud iCloud fileList test
    [self loadiCloudData];
//    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(backgroundaSync) userInfo:nil repeats:YES];
    
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - read json data to Dictionary
- (void)readJsonfileToDictionary:(NSString *)filePathUrl {
    if (filePathUrl) {
        NSString *str = [self getDataFrom:filePathUrl];
        NSData* jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *jsondataDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                    options:0
                                                                      error:&error];
        if (error) {
            NSLog(@"error:%@", error.localizedDescription);
        } else {
            NSDictionary *response = [jsondataDic valueForKey:@"iShareData"];
            NSArray *objects = [response allValues];
            NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsPath = paths.firstObject;
            NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"fileVersion.plist"];
            NSError *writeError = nil;
            if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath] == NO) {
                NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:objects format:NSPropertyListXMLFormat_v1_0 options:NSPropertyListImmutable error:&writeError];
                if (plistData) {
                    [plistData writeToFile:plistPath atomically:YES];
                } else {
                    NSLog(@"Error in saveData: %@", error);
                }
            } else {
                for (NSDictionary *dic in objects) {
                    [self setFileNameAndVersion:[dic valueForKey:@"fileName"] fileVersion:[dic valueForKey:@"Version"] urlPath:[dic valueForKey:@"url"] fileID:[dic valueForKey:@"id"] fileType:[dic valueForKey:@"type"]];
                }
            }
        }
    } else {
        NSLog(@"file no exist");
    }
}

#pragma mark - write json data to fileVersion.plist
- (void)setFileNameAndVersion:(NSString*)fileName fileVersion:(NSString*)fileVersion urlPath:(NSString *)urlStr fileID:(NSString *)fileID fileType:(NSString *)fileType {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = paths.firstObject;
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"fileVersion.plist"];
    
    //    prevent
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"fileVersion" ofType:@"plist"];
    }
    
    NSData *plistData = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    //    convert static property list into dictionary object
    NSArray *plistDataArray = [NSPropertyListSerialization propertyListFromData:plistData mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    NSMutableArray *newData = [plistDataArray mutableCopy];
    if (!plistDataArray) {
        NSLog(@"Error reading: %@, format: %lu", errorDesc, (unsigned long)format);
    }
    
    BOOL isNewFile = YES;
    NSMutableDictionary *newDataDictionary = [[NSMutableDictionary alloc] init];
    for (NSDictionary *dic in plistDataArray) {
        if ([[dic valueForKey:@"name"] isEqualToString:fileName]) {
            if ([[dic valueForKey:@"Version"] isEqualToString:fileVersion] == NO) {
                NSLog(@"Version change");
                [newDataDictionary setValue:fileName forKey:@"fileName"];
                [newDataDictionary setValue:fileVersion forKey:@"Version"];
                //            find  file version be need be edit
                NSUInteger index = [newData indexOfObjectPassingTest:^BOOL (id obj, NSUInteger idx, BOOL *stop) {
                    return [[(NSDictionary *)obj objectForKey:@"fileName"] isEqualToString:fileName];
                }];
                if (index != NSNotFound) {
                    [newData removeObjectAtIndex:index];
                }
                [newData addObject:newDataDictionary];
            }
            isNewFile = NO;
            break;
        }
    }
    if (isNewFile == YES) {
        [newDataDictionary setValue:fileName forKey:@"fileName"];
        [newDataDictionary setValue:fileVersion forKey:@"Version"];
        [newDataDictionary setValue:urlStr forKey:@"url"];
        [newDataDictionary setValue:fileID forKey:@"id"];
        [newDataDictionary setValue:fileType forKey:@"type"];
        [newData addObject:newDataDictionary];
    }
    
    [newData writeToFile:plistPath atomically:YES];
}

- (NSString *)getDataFrom:(NSString *)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    if ([responseCode statusCode] != 200) {
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
        return nil;
    }
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return [self.fileList count];
    return [_filedateArray count];
}

#pragma mark -UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellStyle style = UITableViewCellStyleDefault;
    UITableViewCell *tCell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"testCell"];;
    if (!tCell) {
        
        tCell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"testCell"];
        tCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    tCell.textLabel.text = [NSString stringWithFormat:@"%@--Date:%@", [self.fileList[indexPath.row] valueForKey:@"fileName"] ,[self.fileList[indexPath.row] valueForKey:@"time"]];
    
    tCell.textLabel.text = [NSString stringWithFormat:@"%@--Date:%@", [self.filedateArray[indexPath.row] valueForKey:@"fileName"] ,[self.filedateArray[indexPath.row] valueForKey:@"time"]];
    
    return tCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#pragma mark -iCloud iCloud download from iCloud Box test
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //    [self downloadFromiCloud:[self.fileList[indexPath.row] valueForKey:@"fileName"] filePath:[NSString stringWithFormat:@"%@/%@.png", path, [self.fileList[indexPath.row] valueForKey:@"fileName"]]];
    
    [self downloadFromiCloud:[self.filedateArray[indexPath.row] valueForKey:@"fileName"] filePath:[NSString stringWithFormat:@"%@/%@.png", path, [self.filedateArray[indexPath.row] valueForKey:@"fileName"]]];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
#pragma mark -iCloud iCloud delete from iCloud Box test
    if (spinner == nil) {
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.center = CGPointMake(self.frame.size.width/4, self.frame.size.height/4);
        spinner.hidesWhenStopped = YES;
        [spinner setColor: [UIColor grayColor]];
        [self addSubview:spinner];
    }
    [spinner startAnimating];
    dispatch_async(dispatch_get_main_queue(), ^{
        [iCloudHelper deleteiCloudFile:[self.filedateArray[indexPath.row] valueForKey:@"fileName"] resultBlock:^(id obj) {
            if (obj != nil) {
                NSError *err = (NSError *)obj;
                NSLog(@"iCloudError:%@", err);
            }
        }];
        [spinner stopAnimating];
    });
    NSLog(@"deleteFileKey:%@", [self.filedateArray[indexPath.row] valueForKey:@"fileName"]);
}

#pragma loadiCloudData form iCloud Box
- (void)loadiCloudData {
    if (!self.query) {
        self.query = [[NSMetadataQuery alloc] init];
        self.query.searchScopes = @[NSMetadataQueryUbiquitousDocumentsScope];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(metadataQueryFinish:)
                                                     name:NSMetadataQueryDidFinishGatheringNotification
                                                   object:self.query];//数据获取完成通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(metadataQueryFinish:)
                                                     name:NSMetadataQueryDidUpdateNotification
                                                   object:self.query];//查询更新通知
    }
    //getData
    [self.query startQuery];
}

#pragma mark - iCloud get data from box
- (void)metadataQueryFinish:(NSNotification *)notification {
    NSLog(@"iCloud get data scuessful");
    NSArray *items = self.query.results;
    if (self.fileList == nil) {
        self.fileList = [[NSMutableArray alloc] init];
    } else {
        [self.fileList removeAllObjects];
    }
    
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMetadataItem *item = obj;
        NSString *fileName = [item valueForAttribute:NSMetadataItemFSNameKey];
        NSDate *date = [item valueForAttribute:NSMetadataItemFSContentChangeDateKey];
        NSDateFormatter *dateformate = [[NSDateFormatter alloc] init];
        dateformate.dateFormat = @"YYYY/MM/dd HH:mm";
        NSString *dateString = [dateformate stringFromDate:date];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:dateString forKey:@"time"];
        [dict setObject:fileName forKey:@"fileName"];
        [self.fileList addObject:dict];
    }];
    
    if (_filedateArray == nil) {
        _filedateArray = [[NSArray alloc] init];
    }
    
    _filedateArray = [self.fileList sortedArrayUsingComparator:^(id obj1, id obj2) {
        NSDateFormatter *dateformate = [[NSDateFormatter alloc] init];
        dateformate.dateFormat = @"YYYY/MM/dd HH:mm";
        NSDictionary *data1 = obj1;
        NSDictionary *data2 = obj2;
        NSDate *date1 = [dateformate dateFromString:[data1 valueForKey:@"time"]];
        NSDate *date2 = [dateformate dateFromString:[data2 valueForKey:@"time"]];
        
        if (date1 > date2) {
            return (NSComparisonResult)NSOrderedAscending;
        } else if (date1 < date2) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    [tTableView reloadData];
    
    //    switch (_coinType) {
    //        case btcType:
    //            break;
    //        case ethType:
    //            break;
    //        case ltcType:
    //            break;
    //        default:
    //            break;
    //    }
}

#pragma mark -download file From iCloud box
- (void)downloadFromiCloud:(NSString *)iCloudfilekey filePath:(NSString *)filePath {
    if ([iCloudHelper iCloudEnable]) {
        NSLog(@"%s", __func__);
        NSLog(@"iCloud enable");
        if (spinner == nil) {
            spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            spinner.center = CGPointMake(self.frame.size.width/4, self.frame.size.height/4);
            spinner.hidesWhenStopped = YES;
            [spinner setColor: [UIColor grayColor]];
            [self addSubview:spinner];
        }
        
        [spinner startAnimating];
        dispatch_async(dispatch_get_main_queue(), ^{
            [iCloudHelper downloadFromiCloudWithBlock:^(id obj) {
                if (obj != nil) {
                    NSData *data = (NSData *)obj;
                    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
                    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
                        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
                    }
                    [data writeToFile:filePath atomically:YES];
                    NSLog(@"sync download Scuessful");
                } else {
                    NSLog(@"Sync download fail");
                }
            } iCloudName:iCloudfilekey];
            [spinner stopAnimating];
        });
    } else {
        NSLog(@"iCloud unenable");
    }
}

#pragma upload file to iCloud box
- (void)updataTOiCloud:(NSString *)iCloudfilekey filePath:(NSString *)filePath {
    if ([iCloudHelper iCloudEnable]) {
        NSLog(@"%s", __func__);
        NSLog(@"iCloud enable");
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSLog(@"img exist");
            if (spinner == nil) {
                spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                spinner.center = CGPointMake(self.frame.size.width/4, self.frame.size.height/4);
                spinner.hidesWhenStopped = YES;
                [spinner setColor: [UIColor grayColor]];
                [self addSubview:spinner];
            }
            
            [spinner startAnimating];
            dispatch_async(dispatch_get_main_queue(), ^{
                [iCloudHelper uploadToiCloud:filePath iCloudNam:iCloudfilekey resultBlock:^(NSError *err) {
                    if (err == nil) {
                        NSLog(@"iCLoud Sync scuessful");
                    } else {
                        NSLog(@"iCLoud Sync fail");
                    }
                }];
                [spinner stopAnimating];
            });
        } else {
            NSLog(@"img no exist");
        }
    } else {
        NSLog(@"iCloud unenable");
    }
}

#pragma mark -iCloud iCloud upload test
- (void)iCloudUploadBtnClick {
    NSString *iCloudfilekey = iCloudKeyfield.text;
    if ([iCloudfilekey isEqualToString:@""] == NO) {
        NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"apple13" ofType:@"png"];
        //    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"CkmainCRM_Cust" ofType:@"db"];
        [self updataTOiCloud:iCloudfilekey filePath:imgPath];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Enter file key Value" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Y" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
    }
    iCloudKeyfield.text = @"";
}

#pragma mark -UITextfieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //only English & Number
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString: @""];
    return [string isEqualToString:filtered];
}

- (void)backgroundaSync {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
            NSString *str = [self getDataFrom:btcToEth];
            NSData* jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            NSDictionary *jsondataDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                        options:0
                                                                          error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSNumber *lastValue = [[jsondataDic valueForKey:@"result"] valueForKey:@"Last"][0];
                label.text = [NSString stringWithFormat:@"%@", lastValue];
            });
    });
}

@end


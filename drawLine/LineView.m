//
//  LineView.m
//  drawLine
//
//  Created by Chinalife on 2018/1/2.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import "LineView.h"
#import "oneViewController.h"


#define pointSize 10
#define xGap 150
#define number 1
#define yDownPx 400
#define subtract 0
#define getDataURL @"https://www.cryptopia.co.nz/api/GetMarketHistory/eth_usdt/10"
#define getBTCDataURL @"https://www.cryptopia.co.nz/api/GetMarketHistory/btc_usdt/10"
#define getLTCDataURL @"https://www.cryptopia.co.nz/api/GetMarketHistory/ltc_usdt/10"

@implementation LineView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setDrawData {
    //ETH LINE
        NSString * jsonStr = @"";
        if (_type == 1) {
            jsonStr = [self getDataFrom:getDataURL];
        } else if (_type == 2) {
            jsonStr = [self getDataFrom:getBTCDataURL];
        } else if (_type == 3) {
            jsonStr = [self getDataFrom:getLTCDataURL];
        }
    NSData* data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *jasonDataArray = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] valueForKey:@"Data"];
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Timestamp"
                                                 ascending:NO];//Timestamp
    jasonDataArray = [jasonDataArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
//    NSLog(@"MAXData%@", [jasonDataArray valueForKeyPath:@"@max.Price"]);
    maxNumber = [jasonDataArray valueForKeyPath:@"@max.Price"];

    NSMutableArray *pointsArr = [[NSMutableArray alloc] init];
    
    //   randomLine
//    NSMutableArray *jasonDataArray = [[NSMutableArray alloc] init];
//    int value = 0;
//    for (int i = 0 ; i<= 40 ; i++) {
//        value = (arc4random() % 350) + 1;
//        [jasonDataArray addObject:[NSNumber numberWithInt:value]];
//
//    }
//    maxNumber = [jasonDataArray valueForKeyPath:@"@max.self"];
//    NSLog(@"maxNumber:%@", maxNumber);
    
    for (int i = 0; i < jasonDataArray.count - subtract; i++) {
//        [pointsArr addObject:[NSValue valueWithCGPoint:CGPointMake(xGap*(i+1), -(([jasonDataArray[i] floatValue] - [maxNumber floatValue]-yDownPx)/number))]];
        [pointsArr addObject:[NSValue valueWithCGPoint:CGPointMake(xGap*(i+1), -((([[jasonDataArray[i] valueForKey:@"Price"] floatValue] - [maxNumber floatValue])-yDownPx)))]];
        
    }
    
    if (scrollView == nil) {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width + 30, self.frame.size.height)];
        [self addSubview:scrollView];
    }
    
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(xGap*(jasonDataArray.count -subtract) + 50 , self.frame.size.height + 3);
    
    [self drawlineView:pointsArr];
    
}

- (void)drawlineView:(NSMutableArray *)arr {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for (int i = 0; i < arr.count-1; i++) {
        [path moveToPoint:[[arr objectAtIndex:i] CGPointValue]];
        [path addLineToPoint:[[arr objectAtIndex:i+1] CGPointValue]];
    }
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    if (_type == 1) {
        shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    } else if (_type ==2 ){
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
    } else {
        shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 10;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    [scrollView.layer addSublayer:shapeLayer];
    
    for (int i = 0; i < arr.count; i++) {
//        add taglab
        CGPoint point = [[arr objectAtIndex:i] CGPointValue];
        UILabel *taglab = [[UILabel alloc] initWithFrame:CGRectMake(point.x - 5 ,point.y - 30 ,180 ,20)];
        NSString *yValue = [NSString stringWithFormat:@"%.3f", ((-(point.y - [maxNumber floatValue]/number))+yDownPx)*number];
        taglab.text = [NSString stringWithFormat:@"%@", yValue];
        [scrollView addSubview:taglab];
//        add point View
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(point.x - pointSize/2 ,point.y - pointSize/2 ,pointSize ,pointSize)] CGPath]];
        [circleLayer setFillColor:[[UIColor blackColor] CGColor]];
        [scrollView.layer addSublayer:circleLayer];
    }
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

- (void)removeFromSuperview {
    [super removeFromSuperview];
}

@end


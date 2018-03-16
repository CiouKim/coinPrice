//
//  GpuType.m
//  drawLine
//
//  Created by Chinalife on 2018/3/15.
//  Copyright © 2018年 qwe. All rights reserved.
//

#import "GpuType.h"



@implementation GpuType

//@synthesize gpuName;
//@synthesize equihash;
//@synthesize neoscrypt;
//@synthesize nist5;
//@synthesize lyra2rev2;
//@synthesize daggerhashimoto;


//- (void)setEquihash:(int)equihash {
//    
//    _equihash = equihash*1000;
//}

- (void)setNeoscrypt:(int)neoscrypt {
    _neoscrypt = neoscrypt*1000;
}

- (void)setNist5:(int)nist5 {
    _nist5 = nist5*1000*1000;
}

- (void)setLyra2rev2:(int)lyra2rev2 {
    _lyra2rev2 = lyra2rev2*1000*1000;
}

- (void)setDaggerhashimoto:(int)daggerhashimoto {
    _daggerhashimoto = daggerhashimoto*1000*1000;
}

@end

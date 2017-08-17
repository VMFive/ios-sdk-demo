//
//  VASTSample.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2017/8/17.
//  Copyright © 2017年 DaidoujiChen. All rights reserved.
//

#import "VASTSample.h"
#import <objc/runtime.h>
#import <VMFiveAdNetwork.h>

@implementation VASTSample

#pragma mark - VANativeAdDelegate

+ (void)nativeAdDidLoad:(VANativeAd *)nativeAd {
    void (^block)(NSString *) = objc_getAssociatedObject(nativeAd, @selector(fetch:));
    if (block) {
        block(nativeAd.vastString);
    }
    objc_setAssociatedObject(self, @selector(fetch:), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)nativeAd:(VANativeAd *)nativeAd didFailedWithError:(NSError *)error {
    NSLog(@"===== LOAD FAIL : %@ =====", error);
    objc_setAssociatedObject(self, @selector(fetch:), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Class Method

+ (void)fetch:(void (^)(NSString *vastString))block {
    if (!objc_getAssociatedObject(self, _cmd)) {
        VANativeAd *nativeAd = [[VANativeAd alloc] initWithPlacement:@"Placement" adType:kVAAdTypeVideoCard];
        nativeAd.apiKey = @"Key";
        nativeAd.testMode = YES;
        nativeAd.delegate = (id<VANativeAdDelegate>)self;
        [nativeAd loadAd];
        objc_setAssociatedObject(nativeAd, _cmd, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, _cmd, nativeAd, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end

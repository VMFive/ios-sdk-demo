//
//  VASTSample.h
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2017/8/17.
//  Copyright © 2017年 DaidoujiChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VASTSample : NSObject

+ (void)fetch:(void (^)(NSString *vastString))block;

@end

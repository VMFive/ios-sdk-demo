//
//  SampleView4.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/6/16.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "SampleView4.h"

@implementation SampleView4

#pragma mark - VANativeAdViewRenderProtocol

+ (UINib *)nibForAd {
    return [UINib nibWithNibName:@"SampleView4" bundle:nil];
}

- (UIView *)nativeVideoView {
    return self.videoView;
}

@end

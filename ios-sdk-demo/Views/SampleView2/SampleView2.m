//
//  SampleView2.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/18.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "SampleView2.h"

@implementation SampleView2

#pragma mark - VANativeAdViewRenderProtocol

+ (UINib *)nibForAd {
    return [UINib nibWithNibName:@"SampleView2" bundle:nil];
}

- (UILabel *)nativeTitleTextLabel {
    return self.titleLabel;
}

- (UIView *)nativeVideoView {
    return self.videoView;
}

- (NSArray *)clickableViews {
    return @[ self.ctaLabel ];
}

#pragma mark - IBAction

- (IBAction)closeAction:(id)sender {
    if (self.onClose) {
        self.onClose();
    }
}

@end

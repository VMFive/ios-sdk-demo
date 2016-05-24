//
//  SampleView1.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/24.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "SampleView1.h"

@interface SampleView1 ()

@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@end

@implementation SampleView1

#pragma mark - VANativeAdViewRenderProtocol

+ (UINib *)nibForAd {
    return [UINib nibWithNibName:@"SampleView1" bundle:nil];
}

- (UIView *)nativeVideoView {
    return self.videoView;
}

- (UILabel *)nativeTitleTextLabel {
    return self.titleLabel;
}

- (UIImageView *)nativeMainImageView {
    return self.mainImageView;
}

@end

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
@property (weak, nonatomic) IBOutlet UIButton *ctaButton;

@property (nonatomic, strong) UILabel *ctaLabel;

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

- (UILabel *)nativeCallToActionTextLabel {
    return self.ctaLabel;
}

- (NSArray *)clickableViews {
    return @[ self.ctaButton ];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"ctaLabel.text"]) {
        [self.ctaButton setTitle:change[@"new"] forState:UIControlStateNormal];
    }
}

#pragma mark - Life Cycle

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.ctaLabel = [UILabel new];
        [self addObserver:self forKeyPath:@"ctaLabel.text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"ctaLabel.text"];
}

@end

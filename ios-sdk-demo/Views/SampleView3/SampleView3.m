//
//  SampleView3.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/25.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "SampleView3.h"

@interface SampleView3 ()

@property (nonatomic, weak) UIView *videoView;
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *ctaButton;

@property (nonatomic, strong) UILabel *ctaLabel;

@end

@implementation SampleView3

#pragma mark - VANativeAdViewRenderProtocol

- (UIView *)nativeVideoView {
    return self.videoView;
}

- (UIImageView *)nativeIconImageView {
    return self.iconImageView;
}

- (UILabel *)nativeTitleTextLabel {
    return self.titleLabel;
}

- (UILabel *)nativeCallToActionTextLabel {
    return self.ctaLabel;
}

- (NSArray *)clickableViews {
    return @[ self.ctaButton ];
}

#pragma mark - Private Instance Method

- (UIViewAutoresizing)defaultAutoresizingMask {
    return (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth);
}

- (void)defaultLayout {
    self.autoresizingMask = [self defaultAutoresizingMask];
    
    // 設定 Video View
    UIView *videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    videoView.autoresizingMask = [self defaultAutoresizingMask];
    [self addSubview:videoView];
    self.videoView = videoView;
    
    // 設定 Icon ImageView
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 180, 30, 30)];
    iconImageView.autoresizingMask = [self defaultAutoresizingMask];
    [self addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    // 設定 Title Label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 180, 200, 30)];
    titleLabel.autoresizingMask = [self defaultAutoresizingMask];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    // 設定 CallToAction Button
    UIButton *ctaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ctaButton.frame = CGRectMake(230, 180, 90, 30);
    ctaButton.autoresizingMask = [self defaultAutoresizingMask];
    ctaButton.titleLabel.font = [UIFont systemFontOfSize:15];
    ctaButton.titleLabel.textColor = [UIColor whiteColor];
    ctaButton.backgroundColor = [UIColor blackColor];
    [ctaButton setTitle:@"了解更多" forState:UIControlStateNormal];
    [self addSubview:ctaButton];
    self.ctaButton = ctaButton;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"ctaLabel.text"]) {
        [self.ctaButton setTitle:change[@"new"] forState:UIControlStateNormal];
    }
}

#pragma mark - Life Cycle

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 210)];
    if (self) {
        [self defaultLayout];
        self.ctaLabel = [UILabel new];
        [self addObserver:self forKeyPath:@"ctaLabel.text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"ctaLabel.text"];
}

@end

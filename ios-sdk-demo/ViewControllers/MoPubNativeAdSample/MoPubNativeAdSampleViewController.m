//
//  MoPubNativeAdSampleViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/6/23.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "MoPubNativeAdSampleViewController.h"
#import "MPNativeVideoView.h"

@interface MoPubNativeAdSampleViewController ()

@property (nonatomic, strong) MPNativeAd *nativeAd;

@end

@implementation MoPubNativeAdSampleViewController

#pragma mark - MPNativeAdDelegate

- (void)willPresentModalForNativeAd:(MPNativeAd *)nativeAd {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)didDismissModalForNativeAd:(MPNativeAd *)nativeAd {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)willLeaveApplicationFromNativeAd:(MPNativeAd *)nativeAd {
    NSLog(@"%s", sel_getName(_cmd));
}

- (UIViewController *)viewControllerForPresentingModalView {
    NSLog(@"%s", sel_getName(_cmd));
    return self;
}

#pragma mark - Private Instance Method

- (void)displayAd {
    UIView *adView = [self.nativeAd retrieveAdViewWithError:nil];
    [self.view addSubview:adView];
    
    // autolayout 設定, 固定大小, 水平垂直置中
    adView.translatesAutoresizingMaskIntoConstraints = NO;
    [adView addConstraint:[NSLayoutConstraint constraintWithItem:adView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:300]];
    [adView addConstraint:[NSLayoutConstraint constraintWithItem:adView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:313]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:adView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:adView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
    [self.view layoutIfNeeded];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Video configuration.
    // REMEMBER ADD "VMFiveNativeVideoCustomEvent" IN METHOD "rendererConfigurationWithRendererSettings:" AT "MOPUBNativeVideoAdRenderer.m"
    MOPUBNativeVideoAdRendererSettings *nativeVideoAdSettings = [[MOPUBNativeVideoAdRendererSettings alloc] init];
    nativeVideoAdSettings.renderingViewClass = [MPNativeVideoView class];
    nativeVideoAdSettings.viewSizeHandler = ^(CGFloat maximumWidth) {
        return CGSizeMake(maximumWidth, 312.0f);
    };
    MPNativeAdRendererConfiguration *nativeVideoConfig = [MOPUBNativeVideoAdRenderer rendererConfigurationWithRendererSettings:nativeVideoAdSettings];
    
    MPNativeAdRequest *adRequest = [MPNativeAdRequest requestWithAdUnitIdentifier:@"7091c47489aa4796a44ff0802098adb8" rendererConfigurations:@[ nativeVideoConfig ]];
    
    [adRequest startWithCompletionHandler:^(MPNativeAdRequest *request, MPNativeAd *response, NSError *error) {
        if (error) {
            NSLog(@"================> %@", error);
        }
        else {
            self.nativeAd = response;
            self.nativeAd.delegate = self;
            [self displayAd];
            NSLog(@"Received Native Ad");
        }
    }];
}

@end

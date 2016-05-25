//
//  BannerSampleViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/25.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "BannerSampleViewController.h"

@interface BannerSampleViewController ()

@property (weak, nonatomic) IBOutlet VAAdView *bannerView;

@end

@implementation BannerSampleViewController

#pragma mark - VAAdViewDelegate

- (void)adViewDidLoad:(VAAdView *)adView {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)adViewBeImpressed:(VAAdView *)adView {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)adView:(VAAdView *)adView didFailWithError:(NSError *)error {
    NSLog(@"%s %@", sel_getName(_cmd), error);
}

- (void)adViewDidClick:(VAAdView *)adView {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)adViewDidFinishHandlingClick:(VAAdView *)adView {
    NSLog(@"%s", sel_getName(_cmd));
}

- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (BOOL)shouldAdViewBeReload:(VAAdView *)adView {
    return YES;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bannerView.placement = @"VMFiveAdNetwork_BannerSample";
    self.bannerView.adType = kVAAdTypeVideoBanner;
    self.bannerView.testMode = YES;
    self.bannerView.apiKey = @"YOUR API KEY HERE";
    self.bannerView.delegate = self;
    [self.bannerView loadAd];
}

@end

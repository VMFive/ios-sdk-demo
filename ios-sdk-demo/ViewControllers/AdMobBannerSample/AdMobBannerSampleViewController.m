//
//  AdMobBannerSampleViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/6/22.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "AdMobBannerSampleViewController.h"

@interface AdMobBannerSampleViewController ()

@property (nonatomic, strong) GADBannerView *bannerView;

@end

@implementation AdMobBannerSampleViewController

#pragma mark - GADBannerViewDelegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    NSLog(@"%s", sel_getName(_cmd));

    if (!self.bannerView.superview) {
        [self.view addSubview:bannerView];
    }
    
    // autolayout 設定, 固定大小, 水平置中, 貼底
    self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bannerView addConstraint:[NSLayoutConstraint constraintWithItem:self.bannerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:CGRectGetWidth(self.bannerView.bounds)]];
    [self.bannerView addConstraint:[NSLayoutConstraint constraintWithItem:self.bannerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:CGRectGetHeight(self.bannerView.bounds)]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bannerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bannerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
    [self.view layoutIfNeeded];
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"%s %@", sel_getName(_cmd), error);
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // 建立Google AdMob Banner
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    self.bannerView.rootViewController = self;
    
    self.bannerView.adUnitID = @"ca-app-pub-4125394451256992/4139885266";
    self.bannerView.delegate = self;
    
    GADRequest *request = [GADRequest request];
    
    // 設定測試
    // forLabel後得字串必須與後台所設定的CustomEvent Label相同
    // testMode參數為非必要（此部份可跳過），若未設定testMode，後台需設定API Key
    GADCustomEventExtras *extra = [[GADCustomEventExtras alloc] init];
    [extra setExtras:@{ @"testMode": @YES, @"placement": @"yourplacement", @"apiKey": @"yourapikey" } forLabel:@"VMFCustomBanner"];
    [request registerAdNetworkExtras:extra];
    
    [self.bannerView loadRequest:request];
}

@end

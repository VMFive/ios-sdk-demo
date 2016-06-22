//
//  AdMobInterstitialSampleViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/6/22.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "AdMobInterstitialSampleViewController.h"

@interface AdMobInterstitialSampleViewController ()

@property (nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation AdMobInterstitialSampleViewController

#pragma mark - GADInterstitialDelegate

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    if (ad) {
        [ad presentFromRootViewController:self];
    }
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"%s %@", sel_getName(_cmd), error);
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 建立Google AdMob Interstitial
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-4125394451256992/6223564062"];
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    
    // 設定測試
    // Label必須與後台所設定的CustomEvent Label相同
    // testMode參數為非必要（此部份可跳過），若未設定testMode，後台需設定API Key
    GADCustomEventExtras *extra = [[GADCustomEventExtras alloc] init];
    [extra setExtras:@{ @"testMode": @YES } forLabel:@"VMFCustomInterstitial"];
    [request registerAdNetworkExtras:extra];
    [self.interstitial loadRequest:request];
}

@end

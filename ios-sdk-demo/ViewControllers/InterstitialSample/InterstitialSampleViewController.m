//
//  InterstitialSampleViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/25.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "InterstitialSampleViewController.h"

@interface InterstitialSampleViewController ()

@property (nonatomic, strong) VAAdInterstitial *interstitial;

@end

@implementation InterstitialSampleViewController

#pragma mark - VAAdInterstitialDelegate

- (void)interstitialAdDidLoad:(nonnull VAAdInterstitial *)interstitialAd {
    NSLog(@"%s", sel_getName(_cmd));
    [self.interstitial showAdFromViewController:self];
}

- (void)interstitialAdDidClick:(nonnull VAAdInterstitial *)interstitialAd {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)interstitialAdWillClose:(nonnull VAAdInterstitial *)interstitialAd {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)interstitialAdDidClose:(nonnull VAAdInterstitial *)interstitialAd {
    NSLog(@"%s", sel_getName(_cmd));
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)interstitialAd:(nonnull VAAdInterstitial *)interstitialAd didFailWithError:(nonnull NSError *)error {
    NSLog(@"%s %@", sel_getName(_cmd), error);
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interstitial = [[VAAdInterstitial alloc] initWithplacement:@"VMFiveAdNetwork_InterstitialSample" adType:kVAAdTypeVideoInterstitial];
    self.interstitial.testMode = YES;
    self.interstitial.apiKey = @"YOUR API KEY HERE";
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
}

@end

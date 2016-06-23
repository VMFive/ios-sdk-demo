//
//  MoPubInterstitialSampleViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/6/23.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "MoPubInterstitialSampleViewController.h"

@interface MoPubInterstitialSampleViewController ()

@property (nonatomic, strong) MPInterstitialAdController *interstitial;

@end

@implementation MoPubInterstitialSampleViewController

#pragma mark - MPInterstitialAdControllerDelegate

- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial {
    NSLog(@"%s", sel_getName(_cmd));
    if (interstitial) {
        [interstitial showFromViewController:self];
    }
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial {
    NSLog(@"%s", sel_getName(_cmd));
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Instantiate the interstitial using the class convenience method.
    self.interstitial = [MPInterstitialAdController interstitialAdControllerForAdUnitId:@"a50ce0f6fe844a78b7dfec85680ad603"];
    self.interstitial.delegate = self;
    
    // Fetch the interstitial ad.
    [self.interstitial loadAd];
}

@end

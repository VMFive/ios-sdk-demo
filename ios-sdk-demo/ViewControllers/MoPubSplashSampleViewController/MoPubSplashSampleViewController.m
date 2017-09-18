//
//  MoPubSplashSampleViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2017/9/15.
//  Copyright © 2017年 DaidoujiChen. All rights reserved.
//

#import "MoPubSplashSampleViewController.h"

@interface MoPubSplashSampleViewController ()

@property (nonatomic, strong) MPInterstitialAdController *splash;

@end

@implementation MoPubSplashSampleViewController

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
    [MPInterstitialAdController removeSharedInterstitialAdController:interstitial];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Instantiate the splash using the class convenience method.
    self.splash = [MPInterstitialAdController interstitialAdControllerForAdUnitId:@"b8f73dc866f741a3bb305d9723d3db47"];
    self.splash.delegate = self;
    
    // Fetch the splash ad.
    [self.splash loadAd];
}

@end

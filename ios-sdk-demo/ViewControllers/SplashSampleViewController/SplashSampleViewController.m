//
//  SplashSampleViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2017/9/15.
//  Copyright © 2017年 DaidoujiChen. All rights reserved.
//

#import "SplashSampleViewController.h"

@interface SplashSampleViewController ()

@property (nonatomic, strong) VAAdSplash *splash;

@end

@implementation SplashSampleViewController

#pragma mark - VAAdSplashDelegate

-(void)splashAdDidLoad:(VAAdSplash *)splashAd {
    NSLog(@"%s", sel_getName(_cmd));
    [self.splash showAdFromViewController:self];
}

- (void)splashAdDidClick:(VAAdSplash *)splashAd {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)splashAdWillClose:(VAAdSplash *)splashAd {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)splashAdDidClose:(VAAdSplash *)splashAd {
    NSLog(@"%s", sel_getName(_cmd));
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)splashAd:(VAAdSplash *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"%s %@", sel_getName(_cmd), error);
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.splash = [[VAAdSplash alloc] initWithplacement:@"VMFiveAdNetwork_InterstitialSample" adType:kVAAdTypeVideoSplash];
    self.splash.testMode = YES;
    self.splash.apiKey = @"YOUR API KEY HERE";
    self.splash.delegate = self;
    [self.splash loadAd];
}

@end

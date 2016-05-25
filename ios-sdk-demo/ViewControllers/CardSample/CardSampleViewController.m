//
//  CardSampleViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/25.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "CardSampleViewController.h"

@interface CardSampleViewController ()

@property (weak, nonatomic) IBOutlet VAAdView *cardView;

@end

@implementation CardSampleViewController

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
    
    self.cardView.placement = @"VMFiveAdNetwork_CardSample";
    self.cardView.adType = kVAAdTypeVideoCard;
    self.cardView.testMode = YES;
    self.cardView.apiKey = @"YOUR API KEY HERE";
    self.cardView.delegate = self;
    [self.cardView loadAd];
}

@end

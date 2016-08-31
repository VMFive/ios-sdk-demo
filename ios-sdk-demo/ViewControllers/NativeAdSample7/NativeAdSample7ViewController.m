//
//  NativeAdSample7ViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/6/29.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "NativeAdSample7ViewController.h"
#import "SampleView3.h"

@interface NativeAdSample7ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
@property (nonatomic, strong) VAAdView *adView;

@end

@implementation NativeAdSample7ViewController

#pragma mark - VAAdViewDelegate

- (void)adViewDidLoad:(VAAdView *)adView {
    NSLog(@"%s", sel_getName(_cmd));
    [self.adContainView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.adContainView addSubview:self.adView];
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

#pragma mark - Private Instance Method

- (void)loadNativaAd {
    self.adView = [[VAAdView alloc] initWithplacement:@"VMFiveAdNetwork_SampleApp_SingleCard" adType:kVAAdTypeVideoCard rootViewController:self];
    self.adView.frame = self.adContainView.bounds;
    self.adView.testMode = YES;
    self.adView.apiKey = @"YOUR API KEY HERE";
    self.adView.delegate = self;
    [self.adView loadAd];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NativeAdSample7";
    
    // init values
    self.imageView.image = [UIImage imageNamed:@"placeholder"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadNativaAd];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = CGRectGetMaxY(self.adContainView.frame) + 10;
    self.scrollView.contentSize = CGSizeMake(width, height);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

@end

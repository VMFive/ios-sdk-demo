//
//  NativeAdSample1ViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/24.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "NativeAdSample1ViewController.h"
#import "SampleView1.h"

@interface NativeAdSample1ViewController ()

@property (nonatomic) VANativeAd *nativeAd;
@property (nonatomic) UIView<VANativeAdViewRenderProtocol> *adView;

@end

@implementation NativeAdSample1ViewController

#pragma mark - VANativeAdDelegate

- (void)nativeAdDidLoad:(VANativeAd *)nativeAd {
    if (!self.adView) {
        VANativeAdViewRender *render = [[VANativeAdViewRender alloc] initWithNativeAd:nativeAd customizedAdViewClass:[SampleView1 class]];
        
        [render renderWithCompleteHandler: ^(UIView<VANativeAdViewRenderProtocol> *view, NSError *error) {
            
            if (!error) {
                self.adView = view;
                [self.view addSubview:self.adView];
                
                self.adView.translatesAutoresizingMaskIntoConstraints = NO;
                [self.adView addConstraint:[NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:CGRectGetWidth(self.adView.bounds)]];
                [self.adView addConstraint:[NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:CGRectGetHeight(self.adView.bounds)]];
                
                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
                [self.view layoutIfNeeded];
            }
            else {
                NSLog(@"Render did fail With error : %@", error);
            }
            
        }];
    }
    else {
        
        // AdView存在時，可以直接將AdView帶入進行Rendering
        VANativeAdViewRender *render = [[VANativeAdViewRender alloc] initWithNativeAd:nativeAd customAdView:self.adView];
        
        // 清除AdView上廣告素材並重新Rendering
        [render renderWithCompleteHandler: ^(UIView<VANativeAdViewRenderProtocol> *view, NSError *error) {
            if (error) {
                NSLog(@"Render did fail With error : %@", error);
            }
        }];
    }
}

- (void)nativeAd:(VANativeAd *)nativeAd didFailedWithError:(NSError *)error {
    NSLog(@"%s %@", sel_getName(_cmd), error);
}

- (void)nativeAdDidClick:(VANativeAd *)nativeAd {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)nativeAdDidFinishHandlingClick:(VANativeAd *)nativeAd {
    NSLog(@"%s", sel_getName(_cmd));
}

-(void)nativeAdBeImpressed:(VANativeAd *)nativeAd {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)nativeAdDidFinishImpression:(VANativeAd *)nativeAd {
    NSLog(@"%s", sel_getName(_cmd));
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NativeAdSample1";
    
    // 建立NativeAd物件做為Render的Ad資料來源
    self.nativeAd = [[VANativeAd alloc] initWithPlacement:@"VMFiveAdNetwork_NativeAdSample1" adType:kVAAdTypeVideoCard];
    self.nativeAd.testMode = YES;
    self.nativeAd.apiKey = @"YOUR API KEY HERE";
    self.nativeAd.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.nativeAd loadAd];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.nativeAd unloadAd];
}

@end

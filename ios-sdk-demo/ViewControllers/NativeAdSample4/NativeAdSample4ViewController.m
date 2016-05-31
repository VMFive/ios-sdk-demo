//
//  NativeAdSample3ViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/30.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "NativeAdSample4ViewController.h"
#import "SampleView1.h"
#import "VANativeAd+FullscreenIcon.h"

@interface NativeAdSample4ViewController ()

@property (nonatomic) VANativeAd *nativeAd;
@property (nonatomic) UIView<VANativeAdViewRenderProtocol> *adView;

@end

@implementation NativeAdSample4ViewController

#pragma mark - VANativeAdDelegate

- (void)nativeAdDidLoad:(VANativeAd *)nativeAd {
    if (!self.adView) {
        VANativeAdViewRender *render = [[VANativeAdViewRender alloc] initWithNativeAd:nativeAd customizedAdViewClass:[SampleView1 class]];
        
        __weak NativeAdSample4ViewController *weakSelf = self;
        [render renderWithCompleteHandler: ^(UIView<VANativeAdViewRenderProtocol> *view, NSError *error) {
            if (!error) {
                [weakSelf.view addSubview:view];
                
                // autolayout 設定, 固定大小, 水平垂直置中
                view.translatesAutoresizingMaskIntoConstraints = NO;
                [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:CGRectGetWidth(view.bounds)]];
                [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:CGRectGetHeight(view.bounds)]];
                
                [weakSelf.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:weakSelf.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
                [weakSelf.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:weakSelf.view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
                [weakSelf.view layoutIfNeeded];
                
                weakSelf.adView = view;
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
    
    self.title = @"NativeAdSample4";
    
    // 建立NativeAd物件做為Render的Ad資料來源
    self.nativeAd = [[VANativeAd alloc] initWithPlacement:@"VMFiveAdNetwork_NativeAdSample4" adType:kVAAdTypeVideoCard];
    self.nativeAd.testMode = YES;
    self.nativeAd.apiKey = @"YOUR API KEY HERE";
    self.nativeAd.delegate = self;
    
    // 改變 isNeedFullscreenIcon 設定值, 可控制 icon 是否出現
    // 需 #import "VANativeAd+FullscreenIcon.h" 之後
    // 可以出現這個設定值
    NSLog(@"===== will change isNeedFullscreenIcon from %@", self.nativeAd.isNeedFullscreenIcon ? @"YES" : @"NO");
    self.nativeAd.isNeedFullscreenIcon = NO;
    NSLog(@"===== did change isNeedFullscreenIcon to %@", self.nativeAd.isNeedFullscreenIcon ? @"YES" : @"NO");
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

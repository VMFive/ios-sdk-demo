//
//  NativeAdSample3ViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/25.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "NativeAdSample3ViewController.h"
#import "SampleView3.h"

@interface NativeAdSample3ViewController ()

@property (nonatomic) VANativeAd *nativeAd;
@property (nonatomic) UIView<VANativeAdViewRenderProtocol> *adView;

@end

@implementation NativeAdSample3ViewController

#pragma mark - VANativeAdDelegate

- (void)nativeAdDidLoad:(VANativeAd *)nativeAd {
    if (!self.adView) {
        VANativeAdViewRender *render = [[VANativeAdViewRender alloc] initWithNativeAd:nativeAd customizedAdViewClass:[SampleView3 class]];
        
        __weak NativeAdSample3ViewController *weakSelf = self;
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
    
    // 當影片播放完畢時, 加入這行可以取得下一則影音廣告
    [nativeAd loadAd];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NativeAdSample3";
    
    // 建立NativeAd物件做為Render的Ad資料來源
    self.nativeAd = [[VANativeAd alloc] initWithPlacement:@"VMFiveAdNetwork_NativeAdSample3" adType:kVAAdTypeVideoCard];
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

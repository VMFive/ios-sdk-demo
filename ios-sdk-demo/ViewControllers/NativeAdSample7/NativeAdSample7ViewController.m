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
@property (nonatomic, strong) VANativeAd *nativeAd;
@property (nonatomic, strong) SampleView3 *adView;

@end

@implementation NativeAdSample7ViewController

#pragma mark - VANativeAdDelegate

- (void)nativeAdDidLoad:(VANativeAd *)nativeAd {
    NSLog(@"%s", sel_getName(_cmd));
    
    VANativeAdViewRender *render = [[VANativeAdViewRender alloc] initWithNativeAd:nativeAd customizedAdViewClass:[SampleView3 class]];
    
    __weak NativeAdSample7ViewController *weakSelf = self;
    [render renderWithCompleteHandler: ^(UIView<VANativeAdViewRenderProtocol> *view, NSError *error) {
        if (!error) {
            weakSelf.adView = (SampleView3 *)view;
            weakSelf.adView.frame = weakSelf.adContainView.bounds;
            [weakSelf.adContainView addSubview:weakSelf.adView];
        }
        else {
            NSLog(@"Error : %@", error);
        }
    }];
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

#pragma mark - Private Instance Method

- (void)loadNativaAd {
    self.nativeAd = [[VANativeAd alloc] initWithPlacement:@"VMFiveAdNetwork_NativeAdSample7" adType:kVAAdTypeVideoCard];
    self.nativeAd.testMode = YES;
    self.nativeAd.apiKey = @"YOUR API KEY HERE";
    self.nativeAd.delegate = self;
    [self.nativeAd loadAd];
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
    [self.nativeAd unloadAd];
}

@end

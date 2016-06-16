//
//  NativeAdSample6ViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/6/16.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "NativeAdSample6ViewController.h"
#import "SampleView4.h"

@interface NativeAdSample6ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) VANativeAd *nativeAd;
@property (nonatomic, strong) SampleView4 *adView;
@property (nonatomic, strong) UIWindow *adWindow;
@property (nonatomic, assign) BOOL adShowing;

@end

@implementation NativeAdSample6ViewController

#pragma mark - VANativeAdDelegate

- (void)nativeAdDidLoad:(VANativeAd *)nativeAd {
    VANativeAdViewRender *render;
    if (!self.adView) {
        render = [[VANativeAdViewRender alloc] initWithNativeAd:nativeAd customizedAdViewClass:[SampleView4 class]];
    }
    else {
        render = [[VANativeAdViewRender alloc] initWithNativeAd:nativeAd customAdView:self.adView];
    }
    
    __weak NativeAdSample6ViewController *weakSelf = self;
    [render renderWithCompleteHandler: ^(UIView<VANativeAdViewRenderProtocol> *view, NSError *error) {
        
        if (!error) {
            weakSelf.adView = (SampleView4 *)view;
            [weakSelf showAd];
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
    [self hideAd];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"index : %td", indexPath.row];
    return cell;
}

#pragma mark - Private Instance Method

- (void)loadNativaAd {
    self.nativeAd = [[VANativeAd alloc] initWithPlacement:@"VMFiveAdNetwork_NativeAdSample2" adType:kVAAdTypeVideoCard];
    self.nativeAd.testMode = YES;
    self.nativeAd.apiKey = @"YOUR API KEY HERE";
    self.nativeAd.delegate = self;
    [self.nativeAd loadAd];
}

- (void)showAd {
    if (!self.adShowing) {
        self.adShowing = YES;
        
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat height = (self.nativeAd.mediaSize.height / self.nativeAd.mediaSize.width) * width;
        self.adWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
        [self.adWindow addSubview:self.adView];
        [self.adWindow makeKeyAndVisible];
        
        // autolayout 設定, 與 adWindow 等大, 水平垂直置中
        self.adView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.adWindow addConstraint:[NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.adWindow attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0]];
        [self.adWindow addConstraint:[NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.adWindow attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0]];
        
        [self.adWindow addConstraint:[NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.adWindow attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
        [self.adWindow addConstraint:[NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.adWindow attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
        [self.adWindow layoutIfNeeded];
        
        __weak NativeAdSample6ViewController *weakSelf = self;
        [UIView animateWithDuration:0.5f animations: ^{
            weakSelf.adWindow.frame = CGRectMake(0, 0, width, height);
            [weakSelf.adWindow layoutIfNeeded];
            
            CGRect newFrame = [UIScreen mainScreen].bounds;
            newFrame.origin.y = height;
            newFrame.size.height -= height;
            weakSelf.view.window.frame = newFrame;
            weakSelf.view.frame = weakSelf.view.window.bounds;
        }];
    }
}

- (void)hideAd {
    if (self.adShowing) {
        self.adShowing = NO;
        [self.nativeAd performSelector:@selector(loadAd) withObject:nil afterDelay:3.0f];
        
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
        __weak NativeAdSample6ViewController *weakSelf = self;
        [UIView animateWithDuration:0.5f animations: ^{
            weakSelf.adWindow.frame = CGRectMake(0, 0, width, 0);
            [weakSelf.adWindow layoutIfNeeded];
            
            weakSelf.view.window.frame = [UIScreen mainScreen].bounds;
        } completion: ^(BOOL finished) {
            [weakSelf.adWindow.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            weakSelf.adWindow.hidden = YES;
            weakSelf.adWindow = nil;
            [weakSelf.view.window makeKeyAndVisible];
        }];
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NativeAdSample6";
    
    // init values
    self.adShowing = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadNativaAd];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.adShowing) {
        [self hideAd];
    }
    else {
        [self.nativeAd unloadAd];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self.nativeAd selector:@selector(loadAd) object:nil];
}

@end

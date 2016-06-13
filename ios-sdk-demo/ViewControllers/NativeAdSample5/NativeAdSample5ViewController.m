//
//  NativeAdSample5ViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/6/8.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "NativeAdSample5ViewController.h"
#import "YourCollectionViewCell.h"
#import "SampleView1.h"

@interface NativeAdSample5ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) VANativeAd *nativeAd;
@property (nonatomic) UIView<VANativeAdViewRenderProtocol> *adView;
@property (nonatomic, assign) BOOL isAdReady;
@property (nonatomic, strong) NSMutableArray *titles;

@end

@implementation NativeAdSample5ViewController

#pragma mark - VANativeAdDelegate

- (void)nativeAdDidLoad:(VANativeAd *)nativeAd {
    VANativeAdViewRender *render;
    if (!self.adView) {
        render = [[VANativeAdViewRender alloc] initWithNativeAd:nativeAd customizedAdViewClass:[SampleView1 class]];
    }
    else {
        render = [[VANativeAdViewRender alloc] initWithNativeAd:nativeAd customAdView:self.adView];
    }
    
    __weak NativeAdSample5ViewController *weakSelf = self;
    [render renderWithCompleteHandler: ^(UIView<VANativeAdViewRenderProtocol> *view, NSError *error) {
        if (!error) {
            weakSelf.adView = (SampleView1 *)view;
        }
        else {
            NSLog(@"Error : %@", error);
        }
        weakSelf.isAdReady = (error == nil);
        [weakSelf.collectionView reloadData];
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

#pragma mark - UICollectionViewDataSource

#define adAtIndex 3

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count + self.isAdReady;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isAdReady && indexPath.row == adAtIndex) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
        [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self showAdInCell:cell];
        return cell;
    }
    NSInteger fixIndex = (indexPath.row < adAtIndex) ? indexPath.row : indexPath.row - self.isAdReady;
    YourCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YourCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    cell.textLabel.text = self.titles[fixIndex];
    cell.imageView.image = [UIImage imageNamed:@"placeholder"];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = CGRectGetWidth([UIScreen mainScreen].bounds) * 0.9f;
    return CGSizeMake(cellWidth, cellWidth);
}

#pragma mark - Private Instance Method

- (void)setupTitles {
    self.titles = [NSMutableArray array];
    for (NSInteger index = 0; index < 100; index++) {
        [self.titles addObject:[NSString stringWithFormat:@"I'm index : %td", index]];
    }
}

- (void)loadNativaAd {
    self.nativeAd = [[VANativeAd alloc] initWithPlacement:@"VMFiveAdNetwork_NativeAdSample5" adType:kVAAdTypeVideoCard];
    self.nativeAd.testMode = YES;
    self.nativeAd.apiKey = @"YOUR API KEY HERE";
    self.nativeAd.delegate = self;
    [self.nativeAd loadAd];
}

- (void)showAdInCell:(UICollectionViewCell *)cell {
    [cell addSubview:self.adView];
    
    // autolayout 設定, 固定大小, 水平垂直置中
    self.adView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.adView addConstraint:[NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:CGRectGetWidth(cell.bounds)]];
    [self.adView addConstraint:[NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:CGRectGetHeight(cell.bounds)]];
    
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:self.adView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
    [cell layoutIfNeeded];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NativeAdSample5";
    [self setupTitles];
    [self.collectionView registerClass:[YourCollectionViewCell class] forCellWithReuseIdentifier:@"YourCollectionViewCell"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadNativaAd];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.nativeAd unloadAd];
}

@end

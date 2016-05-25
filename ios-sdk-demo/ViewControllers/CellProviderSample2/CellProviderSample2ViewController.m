//
//  CellProviderSample2ViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/25.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "CellProviderSample2ViewController.h"
#import "SampleView3.h"

@interface CellProviderSample2ViewController ()

@property (nonatomic, strong) VAAdCellProvider *adCellProvider;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CellProviderSample2ViewController

#pragma mark - VAAdCellProviderDataSource

// 插入廣告數量
// kVAAdCellProviderNumberOfAdsUnlimited 無限多
// kVAAdCellProviderNumberOfAdsNotInsert 零個
// > 1 設定數量
- (NSInteger)tableView:(UITableView *)tableView numberOfAdsInSection:(NSUInteger)section {
    return kVAAdCellProviderNumberOfAdsUnlimited;
}

// 第一個 ad 會出現在哪一個 index
- (NSUInteger)tableView:(UITableView *)tableView adStartRowInSection:(NSUInteger)section {
    return 0;
}

// 之後的每個 ads 間隔
// kVAAdCellProviderAdOffsetInsertOnlyOne 只插入一個
- (NSUInteger)tableView:(UITableView *)tableView adOffsetInSection:(NSUInteger)section {
    return 4;
}

#pragma mark - VAAdCellProviderDelegate

- (void)adCellProvider:(VAAdCellProvider *)adCellProvider didLoadAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s %@", sel_getName(_cmd), indexPath);
}

- (void)adCellProvider:(VAAdCellProvider *)adCellProvider didFailWithError:(NSError *)error {
    NSLog(@"%s %@", sel_getName(_cmd), error);
}

- (void)adCellProvider:(VAAdCellProvider *)adCellProvider didFailAtIndexPath:(NSIndexPath *)indexPath withError:(NSError *)error {
    NSLog(@"%s %@, %@", sel_getName(_cmd), indexPath, error);
}

- (void)adCellProviderDidClick:(VAAdCellProvider *)adCellProvider {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)adCellProviderDidFinishHandlingClick:(VAAdCellProvider *)adCellProvider {
    NSLog(@"%s", sel_getName(_cmd));
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:[self.adCellProvider transformToWithAdAtIndexPath:indexPath]];
    cell.textLabel.text = [NSString stringWithFormat:@"index : %td", indexPath.row];
    return cell;
}

#pragma mark - Private Instance Method

- (VANativeAdViewAttributeObject *)retrieveSampleView1Attributes {
    VANativeAdViewAttributeObject *attribute = [VANativeAdViewAttributeObject new];
    attribute.customAdViewClass = [SampleView3 class];
    attribute.customAdViewSizeHandler = ^(CGFloat width, CGFloat ratio) {
        if (width * (210.0f / 320.0f) > 250.0f) {
            return CGSizeMake(250.0 * (320.0f / 210.0f), 250.0f);
        }
        else {
            return CGSizeMake(width, width * (210.0f / 320.0f));
        }
    };
    return attribute;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CellProviderSample1";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    // 建立AdCellProvider
    self.adCellProvider = [[VAAdCellProvider alloc] initWithPlacement:@"VMFiveAdNetwork_CellProviderSample1" adType:kVAAdTypeVideoCard tableView:self.tableView forAttributes:[self retrieveSampleView1Attributes]];
    self.adCellProvider.testMode = YES;
    self.adCellProvider.apiKey = @"YOUR API KEY";
    [self.adCellProvider loadAds];
}

@end

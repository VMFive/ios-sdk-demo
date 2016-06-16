//
//  RewardedVideoSampleViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/6/17.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "RewardedVideoSampleViewController.h"

@interface RewardedVideoSampleViewController ()

@property (nonatomic, strong) VAAdRewardedVideo *rewardedVideo;
@property (nonatomic, assign) BOOL successRewarded;

@end

@implementation RewardedVideoSampleViewController

#pragma mark - VAAdRewardedVideoDelegate

- (void)rewardedVideoDidLoad:(VAAdRewardedVideo *)rewardedVideo {
    NSLog(@"%s", sel_getName(_cmd));
    [self.rewardedVideo show];
}

- (void)rewardedVideoWillShow:(VAAdRewardedVideo *)rewardedVideo {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)rewardedVideoDidShow:(VAAdRewardedVideo *)rewardedVideo {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)rewardedVideoWillClose:(VAAdRewardedVideo *)rewardedVideo {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)rewardedVideoDidClose:(VAAdRewardedVideo *)rewardedVideo {
    NSLog(@"%s", sel_getName(_cmd));
    if (self.successRewarded) {
        [[[UIAlertView alloc] initWithTitle:@"成功獲得獎勵" message:nil delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil] show];
    }
}

- (void)rewardedVideoDidClick:(VAAdRewardedVideo *)rewardedVideo {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)rewardedVideoDidFinishHandlingClick:(VAAdRewardedVideo *)rewardedVideo {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)rewardedVideo:(VAAdRewardedVideo *)rewardedVideo shouldReward:(VAAdRewarded *)rewarded {
    NSLog(@"%s", sel_getName(_cmd));
    self.successRewarded = YES;
}

- (void)rewardedVideo:(VAAdRewardedVideo *)rewardedVideo didFailWithError:(NSError *)error {
    NSLog(@"%s", sel_getName(_cmd));
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.successRewarded = NO;
    
    self.rewardedVideo = [[VAAdRewardedVideo alloc] initWithplacement:@"VMFiveAdNetwork_RewardedVideoSample"];
    self.rewardedVideo.testMode = YES;
    self.rewardedVideo.apiKey = @"YOUR API KEY HERE";
    self.rewardedVideo.delegate = self;
    [self.rewardedVideo loadAd];
}

@end

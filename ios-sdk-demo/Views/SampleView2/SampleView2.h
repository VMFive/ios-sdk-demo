//
//  SampleView2.h
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/18.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VMFiveAdNetwork/VMFiveAdNetwork.h>

@interface SampleView2 : UIView <VANativeAdViewRenderProtocol>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *ctaLabel;

@property (nonatomic, copy) void (^onClose)(void);

@end

//
//  YourCollectionViewCell.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/6/8.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "YourCollectionViewCell.h"

@implementation YourCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        self = arrayOfViews[0];
    }
    return self;
}

@end

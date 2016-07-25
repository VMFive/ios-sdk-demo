//
//  AppDelegate.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/24.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface DemoNavigationController : UINavigationController

@end

@implementation DemoNavigationController

- (BOOL)shouldAutorotate {
    return NO;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[DemoNavigationController alloc] initWithRootViewController:[MainViewController new]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end

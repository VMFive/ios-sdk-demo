//
//  MainViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/24.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "MainViewController.h"
#import <VMFiveAdNetwork/VMFiveAdNetwork.h>
#import "CellProviderSample1ViewController.h"
#import "NativeAdSample1ViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"SDK Information";
            
        case 1:
            return @"Add ads in your tableview";
            
        case 2:
            return @"Use nativeAd fit your design";
            
        default:
            return @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            
        case 1:
            return 1;
            
        case 2:
            return 1;
            
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = [VANativeAd version];
                    break;
                    
                default:
                    break;
            }
            break;
        }
            
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"CellProviderSample1";
                    break;
                    
                default:
                    break;
            }
            break;
        }
            
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"NativeAdSample1";
                    break;
                    
                default:
                    break;
            }
            break;
        }
            
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                    [self.navigationController pushViewController:[CellProviderSample1ViewController new] animated:YES];
                    break;
                    
                default:
                    break;
            }
            break;
        }
            
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                    [self.navigationController pushViewController:[NativeAdSample1ViewController new] animated:YES];
                    break;
                    
                default:
                    break;
            }
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Hello Demos";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

@end

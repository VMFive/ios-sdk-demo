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

@property (nonatomic, strong) NSArray *items;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.items[section][@"sectionTitle"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items[section][@"rows"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *rowText = self.items[indexPath.section][@"rows"][indexPath.row][@"rowText"];
    cell.textLabel.text = [rowText isEqualToString:@"version"] ? [VANativeAd version] : rowText;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class aClass = NSClassFromString(self.items[indexPath.section][@"rows"][indexPath.row][@"action"]);
    if (aClass) {
        [self.navigationController pushViewController:[aClass new] animated:YES];
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Hello Demos";
    self.items = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DemoList" ofType:@"plist"]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

@end

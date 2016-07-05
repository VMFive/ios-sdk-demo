//
//  CellProviderSample1ViewController.m
//  ios-sdk-demo
//
//  Created by DaidoujiChen on 2016/5/24.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

#import "CellProviderSample1ViewController.h"
#import "SampleView1.h"
#import "PetImageTableViewCell.h"
#import "NoteTableViewCell.h"

@interface UITableViewCell (IndexPath)

@property (nonatomic, readonly) NSIndexPath *indexPath;

@end

@implementation UITableViewCell (IndexPath)

- (NSIndexPath *)indexPath {
    return [[self dependTableView] indexPathForCell:self];
}

#pragma mark - Private Instance Method

- (UITableView *)dependTableView {
    UIView *findView = self.superview;
    while (![findView isKindOfClass:[UITableView class]]) {
        findView = findView.superview;
    }
    UITableView *table = (UITableView *)findView;
    return table;
}

@end

@interface CellProviderSample1ViewController ()

@property (nonatomic, strong) VAAdCellProvider *adCellProvider;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *pets;
@property (nonatomic, strong) NSCache *imageCache;
@property (nonatomic, strong) NSCache *rowHeight;

@end

@implementation CellProviderSample1ViewController

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
    return 4;
}

// 之後的每個 ads 間隔
// kVAAdCellProviderAdOffsetInsertOnlyOne 只插入一個
- (NSUInteger)tableView:(UITableView *)tableView adOffsetInSection:(NSUInteger)section {
    return 8;
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
    return self.pets.count * 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *transformIndexPath = [self.adCellProvider transformToWithAdAtIndexPath:indexPath];
    NSInteger petIndex = indexPath.row / 4;
    NSDictionary *currentInfo = self.pets[petIndex];
    UITableViewCell *cell = nil;
    switch (indexPath.row % 4) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:transformIndexPath];
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.textLabel.text = [NSString stringWithFormat:@"領養動物編號 : %td", petIndex + 1];
            break;
        }
            
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"PetImageTableViewCell" forIndexPath:transformIndexPath];
            PetImageTableViewCell *petImageTableViewCell = (PetImageTableViewCell *)cell;
            petImageTableViewCell.petImageView.image = nil;
            
            if ([self.imageCache objectForKey:currentInfo[@"ImageName"]]) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    UIImage *image = [UIImage imageWithData:[self.imageCache objectForKey:currentInfo[@"ImageName"]]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        petImageTableViewCell.petImageView.image = image;
                    });
                });
            }
            else {
                __weak CellProviderSample1ViewController *weakSelf = self;
                NSInteger keepRow = transformIndexPath.row;
                [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:currentInfo[@"ImageName"]] completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
                    if (!error) {
                        [weakSelf.imageCache setObject:data forKey:currentInfo[@"ImageName"]];
                        UIImage *image = [UIImage imageWithData:data];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (petImageTableViewCell.indexPath && petImageTableViewCell.indexPath.row == keepRow) {
                                petImageTableViewCell.petImageView.image = image;
                            }
                        });
                    }
                }] resume];
            }
            break;
        }
            
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:transformIndexPath];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            NSString *sex = [currentInfo[@"Sex"] isEqualToString:@"雄"] ? @"♂" : @"♀";
            NSString *name = currentInfo[@"Name"];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", sex, name];
            break;
        }
            
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NoteTableViewCell" forIndexPath:transformIndexPath];
            NoteTableViewCell *noteTableViewCell = (NoteTableViewCell *)cell;
            noteTableViewCell.textView.text = currentInfo[@"Note"];
            break;
        }
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row % 4) {
        case 0:
            return 40.0f;
            
        case 1:
            return 200.0f;
            
        case 2:
            return 40.0f;
            
        case 3:
        {
            if ([self.rowHeight objectForKey:indexPath]) {
                return [[self.rowHeight objectForKey:indexPath] floatValue];
            }
            else {
                static NoteTableViewCell *dummyCell = nil;
                if (!dummyCell) {
                    dummyCell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NoteTableViewCell class]) owner:self options:nil][0];
                }
                NSDictionary *currentInfo = self.pets[indexPath.row / 4];
                dummyCell.textView.text = currentInfo[@"Note"];
                CGSize sizeThatFitsTextView = [dummyCell.textView sizeThatFits:CGSizeMake(CGRectGetWidth(dummyCell.textView.frame), MAXFLOAT)];
                [self.rowHeight setObject:@(sizeThatFitsTextView.height + 30) forKey:indexPath];
                return sizeThatFitsTextView.height + 30;
            }
        }
            
        default:
            return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
}

#pragma mark - Private Instance Method

- (VANativeAdViewAttributeObject *)retrieveSampleView1Attributes {
    VANativeAdViewAttributeObject *attribute = [VANativeAdViewAttributeObject new];
    attribute.customAdViewClass = [SampleView1 class];
    attribute.customAdViewSizeHandler = ^(CGFloat width, CGFloat ratio) {
        
        // 這邊我設定 ad 與畫面等寬
        CGFloat adWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
        
        // 高度 80 為預留給 title 和 main image, 其餘的部分, 會被等比例的壓短
        CGFloat adHeight = adWidth * ratio + 80.0f;
        return CGSizeMake(adWidth, adHeight);
    };
    return attribute;
}

#pragma mark - Private Instance Method

- (void)fetchPets {
    __weak CellProviderSample1ViewController *weakSelf = self;
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=f4a75ba9-7721-4363-884d-c3820b0b917c"] completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error : %@", error);
        }
        else {
            NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (responseJSON[@"result"][@"results"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.pets = responseJSON[@"result"][@"results"];
                    [weakSelf.tableView reloadData];
                });
            }
        }
    }] resume];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CellProviderSample1";
    self.imageCache = [NSCache new];
    self.imageCache.countLimit = 15;
    self.rowHeight = [NSCache new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PetImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"PetImageTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NoteTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoteTableViewCell"];
    
    // 建立AdCellProvider
    self.adCellProvider = [[VAAdCellProvider alloc] initWithPlacement:@"VMFiveAdNetwork_CellProviderSample1" adType:kVAAdTypeVideoCard tableView:self.tableView forAttributes:[self retrieveSampleView1Attributes]];
    self.adCellProvider.testMode = YES;
    self.adCellProvider.apiKey = @"YOUR API KEY";
    [self.adCellProvider loadAds];
    
    // 下載流浪動物列表
    [self fetchPets];
}

@end

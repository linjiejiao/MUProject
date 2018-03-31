//
//  MUOperationLogViewController.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/31.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUOperationLogViewController.h"
#import "MUDeviceOperationLogCell.h"

@interface MUOperationLogViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) MUDeviceItem *deviceItem;
@property (strong, nonatomic) BaseCollectionView *collectionView;

@end

@implementation MUOperationLogViewController

- (instancetype)initWithDeviceItem:(MUDeviceItem *)deviceItem {
    self = [super init];
    if(self){
        self.deviceItem = deviceItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringWithKey(@"operation_log_title");
    self.collectionView = [[BaseCollectionView alloc] initWithCellClass:[MUDeviceOperationLogCell class] direction:UICollectionViewScrollDirectionVertical];
    [self.collectionView registerClass:[MUDeviceOperationLogCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[MUDeviceOperationLogCell cellIdentifier]];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.deviceItem.operationLogs.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MUDeviceOperationLogCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MUDeviceOperationLogCell cellIdentifier] forIndexPath:indexPath];
    if(indexPath.item < self.deviceItem.operationLogs.count){
        cell.operationLog = self.deviceItem.operationLogs[indexPath.item];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    MUDeviceOperationLogCell *header =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[MUDeviceOperationLogCell cellIdentifier] forIndexPath:indexPath];
    return header;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return [MUDeviceOperationLogCell cellSize];
}

@end

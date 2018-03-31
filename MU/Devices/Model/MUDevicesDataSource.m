//
//  MUDevicesDataSource.m
//  MU
//
//  Created by liang jiajian on 2018/3/22.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUDevicesDataSource.h"
#import "MUDeviceManager.h"

@interface MUDevicesDataSource ()
@property (weak, nonatomic) id<MUDeviceCollectionViewCellDelegate> cellDelegate;
@property (strong, nonatomic) NSArray <MUDeviceItem *> *devicesList;

@end

@implementation MUDevicesDataSource

- (instancetype)initWithCellDelegate:(id<MUDeviceCollectionViewCellDelegate>)cellDelegate {
    self = [super init];
    if(self){
        self.cellDelegate = cellDelegate;
    }
    return self;
}

- (void)loadDataWithCompletion:(void(^)(BOOL success, NSArray<MUDeviceItem *> *devicesList))completion {
    __weak typeof(self) weakSelf = self;
    [[MUDeviceManager sharedInstance] loadDataWithCompletion:^(BOOL success, NSArray<MUDeviceItem *> *devicesList) {
        weakSelf.devicesList = devicesList;
        if(completion){
            completion(success, [devicesList copy]);
        }
    }];
}

- (MUDeviceItem *)getDeviceItemAtIndexPath:(NSIndexPath *)index {
    if(index.item < self.devicesList.count){
        return self.devicesList[index.item];
    }
    return nil;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.devicesList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MUDeviceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MUDeviceCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    cell.delegate = self.cellDelegate;
    if(indexPath.item < self.devicesList.count){
        cell.deviceItem = self.devicesList[indexPath.item];
    }
    return cell;
}

@end

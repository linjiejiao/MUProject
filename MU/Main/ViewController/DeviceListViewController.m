//
//  DeviceListViewController.m
//  MU
//
//  Created by liang jiajian on 2018/2/26.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "DeviceListViewController.h"
#import "AddDeviceViewController.h"
#import "MUDeviceDetailViewController.h"

#import "MUDeviceCollectionViewCell.h"
#import "MUDevicesDataSource.h"
#include "MUDeviceOperationManager.h"
#import "MUDeviceManager.h"

@interface DeviceListViewController () <UICollectionViewDelegate, MUDeviceCollectionViewCellDelegate>
@property (strong, nonatomic) BaseCollectionView *collectionView;
@property (strong, nonatomic) MUDevicesDataSource *devicesDataSource;
@property (strong, nonatomic) UIImageView *emptyListView;

@end

@implementation DeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 185.0f, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.text = NSLocalizedStringWithKey(@"device_list_title");
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel sizeToFit];
    self.tabBarController.navigationItem.titleView = titleLabel;
    UIButton *rightButton = [[UIButton alloc] init];
    [rightButton setImage:[UIImage imageNamed:@"icon_more_option"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(handleNavigationRightClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    int margin = -6;
    negativeSpacer.width = margin;
    self.tabBarController.navigationItem.rightBarButtonItems = nil;
    [self.tabBarController.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, rightBtnItem, nil]];

    self.collectionView = [[BaseCollectionView alloc] initWithCellClass:[MUDeviceCollectionViewCell class] direction:UICollectionViewScrollDirectionVertical];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.collectionView.delegate = self;
    self.devicesDataSource = [[MUDevicesDataSource alloc] initWithCellDelegate:self];
    self.collectionView.dataSource = self.devicesDataSource;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceListChanged:) name:kNotifcation_MUDeviceManager_DeviceListChanged object:nil];
    __weak typeof(self) weakSelf = self;
    [self.devicesDataSource loadDataWithCompletion:^(BOOL success, NSArray<MUDeviceItem *> *devicesList) {
        typeof(self) strongSelf = weakSelf;
        if(!strongSelf){
            return;
        }
        if (devicesList.count <= 0) {
            strongSelf.emptyListView.hidden = NO;
        }else{
            strongSelf.emptyListView.hidden = YES;
        }
        if(success){
            [strongSelf.collectionView reloadData];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.tabBarController.tabBar.size.height - self.navigationController.navigationBar.size.height - StatusBarHeight);
    [self.collectionView reloadData];
}

- (UIImageView *)emptyListView {
    if(!_emptyListView){
        _emptyListView = [[UIImageView alloc] init];
        _emptyListView.image = [UIImage imageNamed:@"img_no_devices"];
        [self.view addSubview:_emptyListView];
        [_emptyListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
    }
    return _emptyListView;
}

// 用tabBarController的navigationController push新界面，否则底部tabBar会一直显示
- (UINavigationController *)navigationController {
    return self.tabBarController.navigationController;
}

- (void)handleNavigationRightClicked:(UIButton *)sender {
    AddDeviceViewController *addDeviceViewVC = [[AddDeviceViewController alloc] init];
    [self.navigationController pushViewController:addDeviceViewVC animated:YES];
}

#pragma mark - notification
- (void)handleDeviceListChanged:(NSNotification *)notification {
    __weak typeof(self) weakSelf = self;
    [self.devicesDataSource loadDataWithCompletion:^(BOOL success, NSArray<MUDeviceItem *> *devicesList) {
        typeof(self) strongSelf = weakSelf;
        if(!strongSelf){
            return;
        }
        if (devicesList.count <= 0) {
            strongSelf.emptyListView.hidden = NO;
        }else{
            strongSelf.emptyListView.hidden = YES;
        }
        if(success){
            [strongSelf.collectionView reloadData];
        }
    }];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MUDeviceItem *deviceItem = [self.devicesDataSource getDeviceItemAtIndexPath:indexPath];
    if(!deviceItem){
        return;
    }
    MUDeviceDetailViewController *vc = [[MUDeviceDetailViewController alloc] initWithDeviceItem:deviceItem];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - MUDeviceCollectionViewCellDelegate
- (void)deviceCell:(MUDeviceCollectionViewCell *)cell didClickDeleteButtonWithDeviceItem:(MUDeviceItem *)deviceItem {
    [[MUDeviceManager sharedInstance] removeDevice:deviceItem];
}

- (void)deviceCell:(MUDeviceCollectionViewCell *)cell didClickSwitchButtonWithDeviceItem:(MUDeviceItem *)deviceItem {
    MUDeviceAction action = MUDeviceAction_On;
    if(deviceItem.status == MUDeviceItemStatus_On){
        action = MUDeviceAction_Off;
        deviceItem.status = MUDeviceItemStatus_Off;
    }else{
        action = MUDeviceAction_On;
        deviceItem.status = MUDeviceItemStatus_On;
    }
    [[MUDeviceOperationManager sharedInstance] doOperateDevice:deviceItem actionType:action time:[[NSDate date] timeIntervalSince1970] trigger:MUDeviceOperationLogTrigger_App];
    [self.collectionView reloadData];
}

@end

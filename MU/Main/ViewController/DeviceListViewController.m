//
//  DeviceListViewController.m
//  MU
//
//  Created by liang jiajian on 2018/2/26.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "DeviceListViewController.h"
#import "AddDeviceViewController.h"
#import "MUDeviceCollectionViewCell.h"
#import "MUDevicesDataSource.h"

@interface DeviceListViewController () <UICollectionViewDelegate>
@property (strong, nonatomic) BaseCollectionView *collectionView;
@property (strong, nonatomic) MUDevicesDataSource *devicesDataSource;

@end

@implementation DeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 185.0f, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.text = NSLocalizedString(@"device_list_title", nil);
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
    if(IOS11_OR_LATER){
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.collectionView.delegate = self;
    self.devicesDataSource = [[MUDevicesDataSource alloc] init];
    self.collectionView.dataSource = self.devicesDataSource;
    __weak typeof(self) weakSelf = self;
    [self.devicesDataSource loadDataWithCompletion:^(BOOL success, NSArray<MUDeviceItem *> *devicesList) {
        typeof(self) strongSelf = weakSelf;
        if(!strongSelf){
            return;
        }
        if(success){
            [strongSelf.collectionView reloadData];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

// 用tabBarController的navigationController push新界面，否则底部tabBar会一直显示
- (UINavigationController *)navigationController {
    return self.tabBarController.navigationController;
}

- (void)handleNavigationRightClicked:(UIButton *)sender {
    AddDeviceViewController *addDeviceViewVC = [[AddDeviceViewController alloc] init];
    [self.navigationController pushViewController:addDeviceViewVC animated:YES];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {

}

@end

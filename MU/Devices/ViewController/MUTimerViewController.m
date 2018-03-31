//
//  MUTimerViewController.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/31.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUTimerViewController.h"
#import "MUTimerTableViewCell.h"

@interface MUTimerViewController () <UITableViewDelegate, UITableViewDataSource, MUTimerTableViewCellDelegate>
@property (strong, nonatomic) MUDeviceItem *deviceItem;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation MUTimerViewController

- (instancetype)initWithDeviceItem:(MUDeviceItem *)deviceItem {
    self = [super init];
    if(self){
        self.deviceItem = deviceItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringWithKey(@"device_detail_timer");
    UIButton *addTimerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addTimerButton.backgroundColor = UIColor.whiteColor;
    [addTimerButton setTitleColor:[UIColor colorWithRGB:0x656565] forState:UIControlStateNormal];
    addTimerButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [addTimerButton setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    [addTimerButton setTitle:NSLocalizedStringWithKey(@"device_timer_add") forState:UIControlStateNormal];
    [addTimerButton sizeToFit];
    CGFloat imageW = addTimerButton.imageView.frame.size.width;
    CGFloat imageH = addTimerButton.imageView.frame.size.height;
    CGFloat titleW = addTimerButton.titleLabel.frame.size.width;
    CGFloat titleH = addTimerButton.titleLabel.frame.size.height;
    [addTimerButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageW, -imageH - 10, 0.f)];
    [addTimerButton setImageEdgeInsets:UIEdgeInsetsMake(-titleH, 0.f, 0.f, -titleW)];
    [self.view addSubview:addTimerButton];
    [addTimerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-PortraitSafeBottomInset);
        make.height.mas_equalTo(90);
    }];

    UITableView *tableView = [[UITableView alloc] init];
    tableView.backgroundColor = [UIColor colorWithRGB:0xf2f2f2];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView registerClass:[MUTimerTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MUTimerTableViewCell class])];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(addTimerButton.mas_top);
    }];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deviceItem.timerItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MUTimerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MUTimerTableViewCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    if(indexPath.item < self.deviceItem.timerItems.count){
        cell.timerItem = self.deviceItem.timerItems[indexPath.item];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.item < self.deviceItem.timerItems.count){
        NSMutableArray *temp = [self.deviceItem.timerItems mutableCopy];
        [temp removeObjectAtIndex:indexPath.item];
        self.deviceItem.timerItems = temp;
    }
    [self.tableView reloadData];
}

#pragma mark - MUTimerTableViewCellDelegate
- (void)timerCell:(MUTimerTableViewCell *)cell didClickedStatusButtonWithItem:(MUDeviceTimerItem *)item {
    if(item.status == MUDeviceTimerItemStrtus_Enable){
        item.status = MUDeviceTimerItemStrtus_Disable;
    }else{
        item.status = MUDeviceTimerItemStrtus_Enable;
    }
    [self.tableView reloadData];
}

@end

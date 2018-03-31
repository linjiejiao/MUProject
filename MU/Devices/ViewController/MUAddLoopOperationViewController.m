//
//  MUAddLoopOperationViewController.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/31.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUAddLoopOperationViewController.h"

@interface MUAddLoopOperationViewController ()
@property (strong, nonatomic) MUDeviceItem *deviceItem;

@end

@implementation MUAddLoopOperationViewController

- (instancetype)initWithDeviceItem:(MUDeviceItem *)deviceItem {
    self = [super init];
    if(self){
        self.deviceItem = deviceItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedStringWithKey(@"device_detail_loop_title");
}

@end

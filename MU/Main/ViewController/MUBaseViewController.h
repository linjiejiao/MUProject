//
//  MUBaseViewController.h
//  MU
//
//  Created by liang jiajian on 2018/3/16.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "BaseViewController.h"
#import "MUNavigationView.h"

@interface MUBaseViewController : BaseViewController
@property (strong, nonatomic) MUNavigationView *navigationView;

- (void)handleTitleClicked;

@end

//
//  BottomLineTextField.m
//  MU
//
//  Created by liang jiajian on 2018/3/27.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "BottomLineTextField.h"

@implementation BottomLineTextField

- (instancetype)init {
    self = [super init];
    if(self){
        [self setupBottomLine];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setupBottomLine];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setupBottomLine];
    }
    return self;
}

- (void)setupBottomLine {
    if(self.bottomLine){
        return;
    }
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.backgroundColor = [UIColor colorWithRGB:0xaaaaaa];
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}

@end

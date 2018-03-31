//
//  MUAddDeviceStep1View.m
//  MU
//
//  Created by liangjiajian_mac on 2018/3/23.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUAddDeviceStep1View.h"
#import "BaseCollectionViewCell.h"

@interface MUDeviceTypeCell : BaseCollectionViewCell
@property (strong, nonatomic) UIButton *radioButton;
@property (strong, nonatomic) UILabel *deviceTypeName;
@property (assign, nonatomic) MUDeviceItemType deviceType;

@end

@implementation MUDeviceTypeCell

+ (CGSize)cellSize {
    return CGSizeMake(ScreenWidth - 38, 75);
}

+ (CGFloat)cellIntervalHorizontal {
    return 0;
}

+ (CGFloat)cellIntervalVertical {
    return 15;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        self.layer.borderColor = UIColor.lightGrayColor.CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 4;
        self.radioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.radioButton setImage:[UIImage imageNamed:@"icon_radio_normal"] forState:UIControlStateNormal];
        [self.radioButton setImage:[UIImage imageNamed:@"icon_radio_selected"] forState:UIControlStateSelected];
        self.radioButton.userInteractionEnabled = NO;
        [self addSubview:self.radioButton];
        [self.radioButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.leading.equalTo(self.mas_leading).offset(50);
        }];
        self.deviceTypeName = [[UILabel alloc] init];
        self.deviceTypeName.font = [UIFont systemFontOfSize:12];
        self.deviceTypeName.textColor = [UIColor colorWithRGB:0x1b9dfc];
        [self addSubview:self.deviceTypeName];
        [self.deviceTypeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.trailing.equalTo(self.mas_trailing).offset(-50);
            make.leading.greaterThanOrEqualTo(self.radioButton.mas_trailing).offset(10);
        }];
    }
    return self;
}

- (void)setDeviceType:(MUDeviceItemType)deviceType {
    _deviceType = deviceType;
    NSString *deviceTypeName = nil;
    switch (deviceType) {
        case MUDeviceItemType_Touch:
            deviceTypeName = @"Touch";
            break;
        case MUDeviceItemType_AP:
            deviceTypeName = @"AP";
            break;
        case MUDeviceItemType_GSMDevice:
            deviceTypeName = @"CSM设备";
            break;
        default:
            break;
    }
    self.deviceTypeName.text = deviceTypeName;
}

@end

@interface MUAddDeviceStep1View () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation MUAddDeviceStep1View

- (instancetype)init {
    self = [super init];
    if(self){
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor colorWithRGB:0x656565];
    titleLabel.text = NSLocalizedStringWithKey(@"add_device_step1_title");
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.centerX.equalTo(self.mas_centerX);
    }];
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.font = [UIFont systemFontOfSize:12];
    descriptionLabel.textColor = [UIColor colorWithRGB:0x656565];
    descriptionLabel.numberOfLines = 2;
    descriptionLabel.text = NSLocalizedStringWithKey(@"add_device_step1_description");
    [self addSubview:descriptionLabel];
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self.mas_centerX);
    }];

    BaseCollectionView *collectionView = [[BaseCollectionView alloc] initWithCellClass:[MUDeviceTypeCell class] direction:UICollectionViewScrollDirectionVertical];
    [self addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.top.equalTo(descriptionLabel.mas_bottom).offset(15);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return MUDeviceItemType_Count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MUDeviceTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MUDeviceTypeCell cellIdentifier] forIndexPath:indexPath];
    cell.deviceType = (MUDeviceItemType)indexPath.row;
    cell.radioButton.selected = (self.selectedDeviceType == cell.deviceType);
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedDeviceType = (MUDeviceItemType)indexPath.row;
    [collectionView reloadData];
}

@end

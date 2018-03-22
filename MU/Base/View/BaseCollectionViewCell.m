//
//  BaseCollectionViewCell.m
//  MU
//
//  Created by liang jiajian on 2018/3/22.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

+ (CGSize)cellSize {
    return CGSizeMake(50, 50);
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellIntervalHorizontal {
    return 6;
}

+ (CGFloat)cellIntervalVertical {
    return 0;
}

@end
@implementation BaseCollectionViewFlowLayout

- (instancetype)initWithCellClass:(Class)cellClass direction:(UICollectionViewScrollDirection)direction {
    self = [super init];
    if(self){
        if([[cellClass new] isKindOfClass:[BaseCollectionViewCell class]]){
            if(direction == UICollectionViewScrollDirectionHorizontal){
                self.minimumLineSpacing = [cellClass cellIntervalHorizontal];
                self.minimumInteritemSpacing = [cellClass cellIntervalVertical];
            }else{
                self.minimumLineSpacing = [cellClass cellIntervalVertical];
                self.minimumInteritemSpacing = [cellClass cellIntervalHorizontal];
            }
            self.itemSize = [cellClass cellSize];
        }
        self.scrollDirection = direction;
    }
    return self;
}

@end

@implementation BaseCollectionView

- (instancetype)initWithCellClass:(Class)cellClass direction:(UICollectionViewScrollDirection)direction {
    BaseCollectionViewFlowLayout *layout = [[BaseCollectionViewFlowLayout alloc] initWithCellClass:cellClass direction:direction];
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if(self){
        if([[cellClass new] isKindOfClass:[BaseCollectionViewCell class]]){
            self.showsVerticalScrollIndicator = NO;
            self.showsHorizontalScrollIndicator = NO;
            self.backgroundColor = [UIColor clearColor];
            [self registerClass:cellClass forCellWithReuseIdentifier:[cellClass cellIdentifier]];
            self.contentInset = UIEdgeInsetsMake([cellClass cellIntervalVertical], [cellClass cellIntervalHorizontal], [cellClass cellIntervalVertical], [cellClass cellIntervalHorizontal]);
        }
    }
    return self;
}

@end

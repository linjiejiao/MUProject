//
//  BaseCollectionViewCell.h
//  MU
//
//  Created by liang jiajian on 2018/3/22.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell

+ (CGSize)cellSize;
+ (NSString *)cellIdentifier;
+ (CGFloat)cellIntervalHorizontal;
+ (CGFloat)cellIntervalVertical;

@end

@interface BaseCollectionViewFlowLayout : UICollectionViewFlowLayout
- (instancetype)initWithCellClass:(Class)cellClass direction:(UICollectionViewScrollDirection)direction;

@end

@interface BaseCollectionView : UICollectionView
- (instancetype)initWithCellClass:(Class)cellClass direction:(UICollectionViewScrollDirection)direction;

@end

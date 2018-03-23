//
//  MUStepIndecatorView.m
//  MU
//
//  Created by liang jiajian on 2018/3/23.
//  Copyright © 2018年 liang jiajian. All rights reserved.
//

#import "MUStepIndecatorView.h"

#define IndecatorSize       25
#define IndecatorInterval   35

#define HeightlightBackgroundColor  [UIColor colorWithRGB:0x00d9a2]
#define HeightlightTextColor        [UIColor whiteColor]
#define NormalBackgroundColor       [UIColor colorWithRGB:0xf2f2f2]
#define NormalTextColor             [UIColor colorWithRGB:0x656565]

@interface MUStepIndecatorView ()
@property (assign, nonatomic) NSUInteger indecatorCount;
@property (strong, nonatomic) NSArray<UILabel *> *indecatorViews;

@end

@implementation MUStepIndecatorView

- (instancetype)initWithStepCount:(NSUInteger)stepCount {
    self = [super init];
    if(self){
        self.indecatorCount = stepCount;
        [self setupIndecatorViews];
    }
    return self;
}

- (void)setupIndecatorViews {
    self.bounds = CGRectMake(0, 0, self.indecatorCount * IndecatorSize + (self.indecatorCount - 1) * IndecatorInterval, IndecatorSize);
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:self.indecatorCount];
    for(int i=0; i<self.indecatorCount; i++){
        [array addObject:[self createIndecatorViewWithIndex:i]];
    }
    self.indecatorViews = array;
}

- (void)heightlightStepIndecatorAtIndex:(NSUInteger)index {
    for(int i=0; i<self.indecatorCount; i++){
        UILabel *indecator = self.indecatorViews[i];
        if(i == index){
            indecator.backgroundColor = HeightlightBackgroundColor;
            indecator.textColor = HeightlightTextColor;
        }else{
            indecator.backgroundColor = NormalBackgroundColor;
            indecator.textColor = NormalTextColor;
        }
    }
}

- (UILabel *)createIndecatorViewWithIndex:(NSUInteger)index {
    UILabel *stepIndecator = [[UILabel alloc] init];
    stepIndecator.textAlignment = NSTextAlignmentCenter;
    stepIndecator.backgroundColor = [UIColor colorWithRGB:0xf2f2f2];
    stepIndecator.textColor = [UIColor colorWithRGB:0x656565];
    stepIndecator.text = [NSString stringWithFormat:@"%lu", index + 1];
    stepIndecator.font = [UIFont systemFontOfSize:16];
    stepIndecator.layer.masksToBounds = YES;
    stepIndecator.layer.cornerRadius = 12.5;
    stepIndecator.frame = CGRectMake(index * (IndecatorSize + IndecatorInterval), 0, IndecatorSize, IndecatorSize);
    [self addSubview:stepIndecator];
    return stepIndecator;
}

@end

//
//  YZTSegmentControl.m
//  HandPassword
//
//  Created by Dongdong on 16/5/6.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTSegmentControl.h"
#import "YZTGestureDefine.h"

#define kSegmentControlDefaultWidth  (kScreenWidth - 30.f)
#define kSegmentControlDefaultHeight 32.f

@interface YZTSegmentControl ()

@property (nonatomic, strong) UISegmentedControl *segmentControl;

@end

@implementation YZTSegmentControl

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, kSegmentControlDefaultWidth, kSegmentControlDefaultHeight)];
    if (self) {
        
    }
    return self;
}

#pragma mark - getter & setter

- (UISegmentedControl *)segmentControl
{
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc] init];
    }
    return _segmentControl;
}

@end

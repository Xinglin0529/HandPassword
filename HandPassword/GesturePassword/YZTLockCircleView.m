//
//  YZTLockCircleView.m
//  HandPassword
//
//  Created by Dongdong on 16/4/21.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTLockCircleView.h"
#import "YZTGestureDefine.h"

@interface YZTLockCircleView()

@property (nonatomic, strong) UIView * circlePath;
@property (nonatomic, strong) UIView * circleRound;

@end

@implementation YZTLockCircleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.circlePath = [[UIView alloc] init];
        self.circlePath.frame = frame;
        self.circlePath.layer.cornerRadius = frame.size.height/2;
        self.circlePath.layer.borderWidth = 1;
        self.circlePath.layer.borderColor = CoreLockCircleLineNormalColor.CGColor;
        self.circlePath.clipsToBounds = YES;
        [self addSubview:self.circlePath];
        
        self.circleRound = [[UIView alloc] init];
        self.circleRound.frame = frame;
        self.circleRound.layer.cornerRadius = frame.size.height/2;
        self.circleRound.backgroundColor = CoreLockCircleLineSelectedCircleColor;
        self.circleRound.hidden = YES;
        [self addSubview:self.circleRound];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    self.circlePath.hidden = selected;
    self.circleRound.hidden = !selected;
}

@end

//
//  CALayer+Shake.m
//  HandPassword
//
//  Created by Dongdong on 16/4/14.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "CALayer+Shake.h"

@implementation CALayer (Shake)

-(void)shake
{
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat s = 16;
    
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    kfa.duration = .1f;
    kfa.repeatCount =2;
    kfa.removedOnCompletion = YES;
    [self addAnimation:kfa forKey:@"shake"];
}

@end

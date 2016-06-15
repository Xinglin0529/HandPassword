//
//  YZTSegmentControl.h
//  HandPassword
//
//  Created by Dongdong on 16/5/6.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZTSegmentControl;

@protocol YZTSegmentControlDelegate <NSObject>

- (void)segmentControl:(YZTSegmentControl *)segmentControl selectedAtIndex:(NSInteger)index;

@end

@interface YZTSegmentControl : UIView

@property (nonatomic, strong) NSArray <NSString *> *titles;

@end

//
//  SegmentedControl.h
//  HandPassword
//
//  Created by Dongdong on 16/4/29.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XDSegmentedControlDelegate <NSObject>
- (void)onSegmentedControlSelectedIndex:(NSInteger)index;
@end

@interface XDSegmentedControl : UIView
@property (nonatomic, strong) UIColor *indicatorBackgroundColor;
@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, weak) id <XDSegmentedControlDelegate> delegate;
- (instancetype)init;
- (instancetype)initWithTitles:(NSArray <NSString *> *)titles;
- (void)setSegmentedControlSelectedIndex:(NSInteger)index;
- (void)segmentedControlScrollIndicatorToIndex:(NSInteger)index delta:(CGFloat)delta;

@end


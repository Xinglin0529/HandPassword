//
//  SegmentedControl.m
//  HandPassword
//
//  Created by Dongdong on 16/4/29.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "XDSegmentedControl.h"
#import "YZTGestureDefine.h"

@interface XDSegmentedControl () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIButton *currentBtn;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *titleWidthList;
@property (nonatomic, strong) NSMutableArray<UIButton *> *btnList;

@end

@implementation XDSegmentedControl

static inline CGFloat contentWidth(NSString *value,UIFont *font)
{
    return [value sizeWithAttributes:@{NSFontAttributeName:font}].width + 10.f;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
{
    self = [super init];
    if (self) {
        [self commonInit];
        self.titles = titles;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    __block UIButton *tempBtn = nil;
    CGFloat height = self.bounds.size.height;
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake([self totalWidth], height);
    [self.btnList enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(tempBtn.frame.origin.x + tempBtn.frame.size.width, 0, [(NSNumber *)self.titleWidthList[idx] floatValue], height);
        tempBtn = obj;
        if (idx == 0) {
            self.indicatorView.frame = CGRectMake(0, height - 2.f, [(NSNumber *)self.titleWidthList[idx] floatValue], 2.f);
        }
    }];
}

#pragma mark - public

- (void)setSegmentedControlSelectedIndex:(NSInteger)index
{
    UIButton *btn = self.btnList[index];
    [UIView animateWithDuration:0.3 animations:^{
        [self refreshButtonStatus];
        self.indicatorView.frame = CGRectMake(btn.frame.origin.x, self.indicatorView.frame.origin.y, btn.frame.size.width, self.indicatorView.frame.size.height);
    }];
}

- (void)segmentedControlScrollIndicatorToIndex:(NSInteger)index delta:(CGFloat)delta
{
    UIButton *btn = self.btnList[index];
    self.currentBtn = btn;
    self.indicatorView.frame = CGRectMake(kScreenWidth *delta, self.indicatorView.frame.origin.y, btn.frame.size.width, self.indicatorView.frame.size.height);
    [self refreshButtonStatus];
}

- (void)setTitles:(NSArray<NSString *> *)titles
{
    if (_titles != titles) {
        _titles = titles;
        [self saveTitleWidth];
    }
}

#pragma mark - event

- (void)buttonAction:(UIButton *)btn
{
    if (self.currentBtn == btn) {
        return;
    }
    self.currentBtn = btn;
    [self setSegmentedControlSelectedIndex:btn.tag];
}

#pragma mark - private

- (void)refreshButtonStatus
{
    for (UIButton *btn in self.btnList) {
        btn.selected = btn == self.currentBtn;
    }
}

- (void)saveTitleWidth
{
    if (self.titleWidthList.count) {
        [self.titleWidthList removeAllObjects];
    }
    for (NSString *value in _titles) {
        [self.titleWidthList addObject:@(contentWidth(value,[UIFont systemFontOfSize:14]))];
    }
    [self setupSubViews];
}

- (CGFloat)totalWidth
{
    CGFloat (^widthBlock)(NSArray<NSNumber *> *widths) = ^CGFloat(NSArray<NSNumber *> *widths) {
        CGFloat width = 0;
        for (NSNumber *number in self.titleWidthList) {
            width += [number floatValue];
        }
        return width;
    };
    
    if (widthBlock(self.titleWidthList) <= [UIScreen mainScreen].bounds.size.width) {
        for (int i = 0; i < self.titleWidthList.count; i++) {
            [self.titleWidthList replaceObjectAtIndex:i withObject:@([UIScreen mainScreen].bounds.size.width / self.titleWidthList.count)];
        }
    }
    return widthBlock(self.titleWidthList);
}

- (void)setupSubViews
{
    for (int i = 0; i < _titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i;
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        [self.btnList addObject:btn];
        if (i == 0) {
            btn.selected = YES;
            self.currentBtn = btn;
        }
    }
    [self.scrollView addSubview:self.indicatorView];
    [self setNeedsLayout];
}

- (void)commonInit
{
    self.indicatorBackgroundColor = [UIColor redColor];
    self.normalTitleColor = [UIColor blackColor];
    self.selectedTitleColor = [UIColor redColor];
}

#pragma getter & setter

- (NSMutableArray<UIButton *> *)btnList
{
    if (!_btnList) {
        _btnList = [NSMutableArray array];
    }
    return _btnList;
}

- (NSMutableArray<NSNumber *> *)titleWidthList
{
    if (!_titleWidthList) {
        _titleWidthList = [NSMutableArray array];
    }
    return _titleWidthList;
}

- (UIView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = self.indicatorBackgroundColor;
    }
    return _indicatorView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

@end

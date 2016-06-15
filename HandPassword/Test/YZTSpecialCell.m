//
//  YZTSpecialCell.m
//  HandPassword
//
//  Created by Dongdong on 16/5/5.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTSpecialCell.h"

#import <Masonry/Masonry.h>
#import "YZTGestureDefine.h"
#import "YZTImportantNewsModel.h"

@interface YZTSpecialCell ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *containerView;
@end

@implementation YZTSpecialCell
static CGFloat const kDefaultTitleLabelWidth = 120.f;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self yzt_setupSubviews];
    }
    return self;
}

#pragma mark - public

- (void)configCellWithData:(YZTImportantNewsModel *)model
{
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.date;
}

#pragma mark - private

- (void)yzt_setupSubviews
{
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.imgView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.detailLabel];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 10.f, 0, 10.f));
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.and.top.equalTo(self);
        make.bottom.equalTo(self.containerView.mas_bottom).offset(-25.f);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@(kDefaultTitleLabelWidth));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@10);
        make.trailing.equalTo(@-10);
        make.top.equalTo(self.imgView.mas_bottom).offset(5.f);
    }];
}

#pragma mark - getter & setter

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.clipsToBounds = YES;
        _containerView.layer.borderWidth = 1.f;
        _containerView.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _containerView;
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.backgroundColor = [UIColor yellowColor];
    }
    return _imgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:11.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor blueColor];
        _titleLabel.alpha = 0.7f;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:14.f];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _detailLabel;
}

@end

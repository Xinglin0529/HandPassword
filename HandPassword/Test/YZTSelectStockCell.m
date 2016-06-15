//
//  YZTSelectStockCell.m
//  HandPassword
//
//  Created by Dongdong on 16/5/5.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTSelectStockCell.h"
#import <Masonry/Masonry.h>
#import "YZTGestureDefine.h"
#import "YZTSelectStockModel.h"

@interface YZTSelectStockCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *relateLabel;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *knowLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *seperator;
@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;
@end

@implementation YZTSelectStockCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.labels = [NSMutableArray array];
        [self yzt_setupSubviews];
    }
    return self;
}

#pragma mark - public

- (void)configCellWithData:(YZTSelectStockModel *)model
{
    [self removeRelateLabel];

    self.contentLabel.text = model.content;
    self.knowLabel.text = model.know;
    self.dateLabel.text = model.date;
    
    self.relateLabel.hidden = model.relates.count <= 0;
    self.contentLabel.preferredMaxLayoutWidth = kScreenWidth - 40.f;
    
    [self.relateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        if (model.relates.count <= 0) {
            make.height.mas_equalTo(@0);
        } else {
            make.height.mas_equalTo(@14);
        }
    }];
    
    UILabel *temp = nil;

    for (int i = 0; i < model.relates.count; i++) {
        UILabel *l = [[UILabel alloc] init];
        l.font = self.relateLabel.font;
        l.textColor = [UIColor grayColor];
        l.textAlignment = NSTextAlignmentCenter;
        l.clipsToBounds = YES;
        l.layer.borderWidth = 0.5f;
        l.layer.borderColor = l.textColor.CGColor;
        l.text = model.relates[i];
        [self.containerView addSubview:l];
        [self.labels addObject:l];
        
        [l mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.relateLabel.mas_centerY);
            if (temp) {
                make.leading.equalTo(temp.mas_trailing).offset(5.f);
            } else {
                make.leading.equalTo(self.relateLabel.mas_trailing).offset(5.f);
            }
        }];
        temp = l;
    }
}

#pragma mark - private

- (void)removeRelateLabel
{
    for (UILabel *l in self.labels) {
        [l removeFromSuperview];
    }
    [self.labels removeAllObjects];
}

- (void)yzt_setupSubviews
{
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.contentLabel];
    [self.containerView addSubview:self.relateLabel];
    [self.containerView addSubview:self.seperator];
    [self.containerView addSubview:self.logoImageView];
    [self.containerView addSubview:self.knowLabel];
    [self.containerView addSubview:self.dateLabel];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(@10);
        make.trailing.mas_equalTo(@-10);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@10).priority(751);
        make.leading.mas_equalTo(@10);
        make.trailing.mas_equalTo(@-10);
    }];
    
    [self.relateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(5.f);
        make.leading.mas_equalTo(@10);
        make.height.mas_equalTo(@11);
    }];
    
    [self.seperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.relateLabel.mas_bottom).offset(5.f);
        make.leading.and.trailing.equalTo(self.containerView);
        make.height.mas_equalTo(@0.5);
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seperator.mas_bottom).offset(5.f);
        make.leading.mas_equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(15.f, 15.f));
        make.bottom.mas_equalTo(self.containerView.mas_bottom).offset(-5.f);
    }];
    
    [self.knowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.logoImageView.mas_trailing).offset(5.f);
        make.trailing.equalTo(self.containerView.mas_centerX);
        make.centerY.equalTo(self.logoImageView.mas_centerY);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.knowLabel.mas_trailing);
        make.trailing.mas_equalTo(@-10);
        make.centerY.equalTo(self.logoImageView.mas_centerY);
    }];
}

#pragma mark - getter & setter

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.clipsToBounds = YES;
        _containerView.layer.cornerRadius = 5.f;
    }
    return _containerView;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:14.f];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)relateLabel
{
    if (!_relateLabel) {
        _relateLabel = [[UILabel alloc] init];
        _relateLabel.textAlignment = NSTextAlignmentLeft;
        _relateLabel.font = [UIFont systemFontOfSize:11.f];
        _relateLabel.text = @"相关股票:";
    }
    return _relateLabel;
}

- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _logoImageView;
}

- (UILabel *)knowLabel
{
    if (!_knowLabel) {
        _knowLabel = [[UILabel alloc] init];
        _knowLabel.textAlignment = NSTextAlignmentLeft;
        _knowLabel.font = [UIFont systemFontOfSize:10.f];
    }
    return _knowLabel;
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.font = [UIFont systemFontOfSize:10.f];
        _dateLabel.textColor = [UIColor grayColor];
    }
    return _dateLabel;
}

- (UIView *)seperator
{
    if (!_seperator) {
        _seperator = [[UIView alloc] init];
        _seperator.backgroundColor = [UIColor grayColor];
    }
    return _seperator;
}
@end

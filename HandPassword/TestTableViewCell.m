//
//  TestTableViewCell.m
//  HandPassword
//
//  Created by Dongdong on 16/5/6.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "TestTableViewCell.h"
#import <Masonry.h>
#import "YZTGestureDefine.h"
#import "TestModel.h"

@interface TestTableViewCell ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *describeLabel;

@end

@implementation TestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)configCellData:(TestModel *)model
{
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    self.describeLabel.text = model.describe;
}

- (void)setupSubviews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.describeLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@10);
        make.leading.mas_equalTo(@10);
        make.trailing.mas_equalTo(@-10);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10.f);
        make.leading.trailing.equalTo(self.titleLabel);
    }];

    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10.f);
        make.leading.trailing.equalTo(self.titleLabel);
        make.bottom.equalTo(self.mas_bottom).offset(-10.f);
    }];
}

- (UILabel *(^)(CGFloat fontSize))createLabel
{
    return ^UILabel *(CGFloat fontSize) {
        UILabel *l = [UILabel new];
        l.textAlignment = NSTextAlignmentLeft;
        l.font = [UIFont systemFontOfSize:fontSize];
        l.numberOfLines = 0;
        return l;
    };
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = self.createLabel(13.f);
    }
    return _contentLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = self.createLabel(13.f);
    }
    return _titleLabel;
}

- (UILabel *)describeLabel
{
    if (!_describeLabel) {
        _describeLabel = self.createLabel(13.f);
    }
    return _describeLabel;
}

@end

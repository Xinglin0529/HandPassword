//
//  YZTCalendarTopCell.m
//  HandPassword
//
//  Created by Dongdong on 16/5/5.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTCalendarTopCell.h"
#import <Masonry/Masonry.h>
#import "YZTCalendarModel.h"

static CGFloat const kBottomValueLabelWidth = 80.f;

@implementation YZTCalendarTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

#pragma mark - override

- (void)configCellWithData:(YZTCalendarModel *)model
{
    [super configCellWithData:model];
    self.currentValueLabel.text = [NSString stringWithFormat:@"今值 %@",model.currentValue];
    self.previousValueLabel.text = [NSString stringWithFormat:@"前值 %@",model.previousValue];
    self.forecastValueLabel.text = [NSString stringWithFormat:@"预测 %@",model.forecastValue];
}

#pragma mark - private

- (void)setupSubviews
{
    [self.containerView addSubview:self.currentValueLabel];
    [self.containerView addSubview:self.previousValueLabel];
    [self.containerView addSubview:self.forecastValueLabel];
    
    [self.currentValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@5);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(5.f);
        make.width.equalTo(@(kBottomValueLabelWidth));
    }];
    
    [self.previousValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.currentValueLabel.mas_trailing).offset(5.f);
        make.top.equalTo(self.currentValueLabel.mas_top);
        make.width.equalTo(@(kBottomValueLabelWidth));
    }];
    
    [self.forecastValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.previousValueLabel.mas_trailing).offset(5.f);
        make.top.equalTo(self.currentValueLabel.mas_top);
        make.width.equalTo(@(kBottomValueLabelWidth));
    }];
}

#pragma mark - getter & setter

- (UILabel *(^)())createLabel
{
    return ^UILabel *(){
        UILabel *l = [UILabel new];
        l.textAlignment = NSTextAlignmentLeft;
        l.font = [UIFont systemFontOfSize:11.f];
        return l;
    };
}

- (UILabel *)currentValueLabel
{
    if (!_currentValueLabel) {
        _currentValueLabel = self.createLabel();
    }
    return _currentValueLabel;
}

- (UILabel *)previousValueLabel
{
    if (!_previousValueLabel) {
        _previousValueLabel = self.createLabel();
    }
    return _previousValueLabel;
}

- (UILabel *)forecastValueLabel
{
    if (!_forecastValueLabel) {
        _forecastValueLabel = self.createLabel();
    }
    return _forecastValueLabel;
}

@end

//
//  YZTImportantNewsCell.m
//  HandPassword
//
//  Created by Dongdong on 16/5/5.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTImportantNewsCell.h"
#import <Masonry/Masonry.h>
#import "YZTGestureDefine.h"
#import "YZTImportantNewsModel.h"

@interface YZTImportantNewsCell ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@end

@implementation YZTImportantNewsCell

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
    self.dateLabel.text = model.date;
}

#pragma mark - private

- (void)yzt_setupSubviews
{
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.dateLabel];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@10);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(64.f, 50.f));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imgView.mas_trailing).offset(10.f);
        make.trailing.equalTo(@-10);
        make.top.equalTo(self.imgView.mas_top);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@-10);
        make.bottom.equalTo(self.imgView.mas_bottom);
    }];
}

#pragma mark - getter & setter

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
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:11.f];
        _dateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _dateLabel;
}

@end

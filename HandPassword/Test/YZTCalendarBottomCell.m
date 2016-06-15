//
//  YZTCalendarBottomCell.m
//  HandPassword
//
//  Created by Dongdong on 16/5/5.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTCalendarBottomCell.h"
#import <Masonry/Masonry.h>
#import "YZTCalendarModel.h"
#import "YZTGestureDefine.h"

@implementation YZTCalendarBottomCell

static inline NSAttributedString *attributeSting(NSString *text)
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:13.f]};
    NSMutableAttributedString *a = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 2.f;
    [a addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, a.length)];
    [a addAttributes:attribute range:NSMakeRange(0, a.length)];
    return a;
};

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self yzt_setupSubviews];
    }
    return self;
}

#pragma mark - public 

- (void)configCellWithData:(YZTCalendarModel *)model
{
    self.flagImageView.backgroundColor = [UIColor redColor];
    self.contentLabel.attributedText = attributeSting(model.content);
    self.rightStatusLabel.text = model.time;
    if (model.time) {
        self.rightStatusLabel.backgroundColor = [UIColor blueColor];
        self.rightStatusLabel.textColor = [UIColor whiteColor];
    }
}

+ (CGFloat)cellHeight:(YZTCalendarModel *)model
{
    CGFloat height = 0.f;
    height += 10.f;
    height += 5.f;
    height += [self contentHeight:attributeSting(model.content)];
    height += 5.f;
    if (model.currentValue.length > 0 || model.previousValue.length > 0 || model.forecastValue.length > 0) {
        height += 11.f;
    }
    height += 5.f;
    return height;
}

+ (CGFloat)contentHeight:(NSAttributedString *)text
{
    return [text boundingRectWithSize:CGSizeMake(kScreenWidth - 15.f * 3 - 5.f * 2 - 50.f, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height + 1.f;
}

#pragma mark - private

- (void)yzt_setupSubviews
{
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.flagImageView];
    [self.containerView addSubview:self.contentLabel];
    [self.containerView addSubview:self.rightStatusLabel];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(10.f, 10.f, 0.f, 10.f));
    }];
    
    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@5);
        make.top.equalTo(@5);
        make.size.mas_equalTo(CGSizeMake(15.f, 10.f));
    }];
    
    [self.rightStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@-5);
        make.top.equalTo(self.flagImageView.mas_top);
        make.width.equalTo(@50);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.flagImageView.mas_trailing).offset(5.f);
        make.top.equalTo(self.flagImageView.mas_top);
        make.trailing.equalTo(self.rightStatusLabel.mas_leading).offset(-5.f);
    }];
}

#pragma mark - getter & setter

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.clipsToBounds = YES;
        _containerView.layer.cornerRadius = 3.f;
    }
    return _containerView;
}

- (UILabel *)rightStatusLabel
{
    if (!_rightStatusLabel) {
        _rightStatusLabel = [[UILabel alloc] init];
        _rightStatusLabel.textAlignment = NSTextAlignmentCenter;
        _rightStatusLabel.font = [UIFont systemFontOfSize:12.f];
        _rightStatusLabel.numberOfLines = 0;
    }
    return _rightStatusLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:13.f];
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIImageView *)flagImageView
{
    if (!_flagImageView) {
        _flagImageView = [[UIImageView alloc] init];
    }
    return _flagImageView;
}

@end

//
//  YZTLiveProgressCell.m
//  HandPassword
//
//  Created by Dongdong on 16/5/4.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTLiveProgressCell.h"
#import <Masonry/Masonry.h>
#import "YZTLiveModel.h"
#import "YZTGestureDefine.h"
#import "YZTImageContainerView.h"
static CGFloat const kViewLeftAndRightMargin = 10.f;//距离左右边距
static CGFloat const kTimeLabelWidth = 40.f;//时间标签宽度
static CGFloat const kContentLabelMaxHeight = 100.f;//当超过5行时文字默认最大高度
static CGFloat const kImageDefaultHeight = 64.f;//图片默认高度
static CGFloat const kImageViewMargin = 5.f;//图片间隔

@interface YZTLiveProgressCell () <YZTImageContainerViewDelegate>
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *expandBtn;
@property (nonatomic, strong) UIView *line02;
@property (nonatomic, strong) UIView *point;
@property (nonatomic, strong) YZTImageContainerView *imageContainerView;
@end

@implementation YZTLiveProgressCell

static inline NSAttributedString *attributeSting(NSString *text)
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14.f]};
    NSMutableAttributedString *a = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 3.f;
    [a addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, a.length)];
    [a addAttributes:attribute range:NSMakeRange(0, a.length)];
    return a;
};

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self setupSubviews];
    }
    return self;
}

#pragma mark - public

- (void)configCellWithData:(YZTLiveModel *)model indexPath:(NSIndexPath *)indexPath
{
    self.contentLabel.preferredMaxLayoutWidth = kScreenWidth - kViewLeftAndRightMargin *2 - kTimeLabelWidth - 3 * 5.f;
    [self.imageContainerView setImageWithUrls:model.imageUrls indexPath:indexPath];
    self.timeLabel.text = model.time;
    if (model.date && model.date.length > 0) {
        self.dateLabel.text = model.date;
    }
    self.contentLabel.attributedText = attributeSting(model.content);
    
    if (!model.isShowAll) {
        [self.expandBtn setTitle:@"展开" forState:UIControlStateNormal];
    } else {
        [self.expandBtn setTitle:@"收回" forState:UIControlStateNormal];
    }
    
    if ([self.class contentHeight:attributeSting(model.content)] <= kContentLabelMaxHeight) {
        
        self.expandBtn.hidden = YES;
        self.contentLabel.numberOfLines = 0;
        
        [self.expandBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@0);
        }];
        
        [self.imageContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.expandBtn.mas_bottom);
        }];
        
    } else {
        
        self.expandBtn.hidden = NO;
        self.contentLabel.numberOfLines = model.isShowAll ? 0 : 5;

        [self.expandBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@14);
        }];
        
        [self.imageContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.expandBtn.mas_bottom).offset(5.f);
        }];
    }
}

#pragma mark - event

- (void)expandBtnAction:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshTableView:)]) {
        [self.delegate refreshTableView:self];
    }
}

- (void)tapImageViewAction:(UITapGestureRecognizer *)tap
{
    UIImageView *iv = (UIImageView *)tap.view;
    if (self.delegate && [self.delegate respondsToSelector:@selector(showZoomImage:image:)]) {
        [self.delegate showZoomImage:self image:iv.image];
    }
}

- (void)showBigImage:(UIImage *)image
{
    
}

#pragma mark - private

+ (CGFloat)contentHeight:(NSAttributedString *)text
{
    return [text boundingRectWithSize:CGSizeMake(kScreenWidth - kViewLeftAndRightMargin *2 - kTimeLabelWidth - 3 * 5.f, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine context:nil].size.height + 1.f;
}

- (void)setupSubviews
{
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.expandBtn];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.line01];
    [self.contentView addSubview:self.line02];
    [self.contentView addSubview:self.point];
    [self.contentView addSubview:self.imageContainerView];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(@(kViewLeftAndRightMargin + kTimeLabelWidth + 5.f * 3));
        make.trailing.mas_equalTo(@(-kViewLeftAndRightMargin));
        make.top.mas_equalTo(@10);
    }];
    
    [self.expandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentLabel.mas_leading);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(5.f);
        make.height.mas_equalTo(@14);
    }];

    [self.imageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.expandBtn.mas_bottom).offset(5.f);
        make.leading.equalTo(self.contentLabel.mas_leading);
        make.width.mas_equalTo(@(kScreenWidth - 10.f * 2 - 40.f - 3 * 5.f));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5.f);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(@(kViewLeftAndRightMargin));
        make.top.equalTo(self.contentLabel.mas_top);
        make.width.mas_equalTo(@(kTimeLabelWidth));
        make.height.mas_equalTo(@14);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.timeLabel.mas_leading);
        make.top.equalTo(self.timeLabel.mas_bottom);
        make.height.mas_equalTo(@13);
    }];
    
    [self.line01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.timeLabel.mas_trailing).offset(5.f);
        make.top.mas_equalTo(@0);
        make.bottom.equalTo(self.point.mas_top);
        make.width.mas_equalTo(@1);
    }];
    
    [self.point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.line01.mas_centerX);
        make.centerY.equalTo(self.timeLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(5.f, 5.f));
    }];
    
    [self.line02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.point.mas_bottom);
        make.centerX.equalTo(self.point.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.equalTo(self.line01.mas_width);
    }];
}

- (UILabel *)createLabel:(UIFont *)font
{
    UILabel *l = [[UILabel alloc] init];
    l.font = font;
    l.textAlignment = NSTextAlignmentLeft;
    return l;
}

- (UIView *)createView
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor blueColor];
    return v;
}

#pragma mark - getter & setter

- (UIButton *)expandBtn
{
    if (!_expandBtn) {
        _expandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _expandBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_expandBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_expandBtn addTarget:self action:@selector(expandBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expandBtn;
}

- (UIView *)line01
{
    if (!_line01) {
        _line01 = [self createView];
    }
    return _line01;
}

- (UIView *)line02
{
    if (!_line02) {
        _line02 = [self createView];
    }
    return _line02;
}

- (UIView *)point
{
    if (!_point) {
        _point = [self createView];
        _point.layer.cornerRadius = 5.f / 2;
        _point.clipsToBounds = YES;
    }
    return _point;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [self createLabel:[UIFont systemFontOfSize:14.f]];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _contentLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [self createLabel:[UIFont systemFontOfSize:14.f]];
    }
    return _timeLabel;
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [self createLabel:[UIFont systemFontOfSize:13.f]];
    }
    return _dateLabel;
}

- (YZTImageContainerView *)imageContainerView
{
    if (!_imageContainerView) {
        _imageContainerView = [[YZTImageContainerView alloc] init];
        _imageContainerView.delegate = self;
    }
    return _imageContainerView;
}

@end

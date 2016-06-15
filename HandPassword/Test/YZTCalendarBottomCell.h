//
//  YZTCalendarBottomCell.h
//  HandPassword
//
//  Created by Dongdong on 16/5/5.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZTCalendarModel;

@interface YZTCalendarBottomCell : UITableViewCell
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *flagImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *rightStatusLabel;
- (void)configCellWithData:(YZTCalendarModel *)model;
+ (CGFloat)cellHeight:(YZTCalendarModel *)model;

@end

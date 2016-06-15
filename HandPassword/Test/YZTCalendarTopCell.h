//
//  YZTCalendarTopCell.h
//  HandPassword
//
//  Created by Dongdong on 16/5/5.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTCalendarBottomCell.h"

@class YZTCalendarModel;

@interface YZTCalendarTopCell : YZTCalendarBottomCell
@property (nonatomic, strong) UILabel *currentValueLabel;
@property (nonatomic, strong) UILabel *previousValueLabel;
@property (nonatomic, strong) UILabel *forecastValueLabel;
@end

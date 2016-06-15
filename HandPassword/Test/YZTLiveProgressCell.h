//
//  YZTLiveProgressCell.h
//  HandPassword
//
//  Created by Dongdong on 16/5/4.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZTLiveModel;
@class YZTLiveProgressCell;

@protocol YZTLiveProgressCellDelegate <NSObject>

- (void)refreshTableView:(YZTLiveProgressCell *)cell;
- (void)showZoomImage:(YZTLiveProgressCell *)cell image:(UIImage *)image;
@end

@interface YZTLiveProgressCell : UITableViewCell
@property (nonatomic, strong) UIView *line01;
@property (nonatomic, weak) id <YZTLiveProgressCellDelegate> delegate;
- (void)configCellWithData:(YZTLiveModel *)model indexPath:(NSIndexPath *)indexPath;
@end

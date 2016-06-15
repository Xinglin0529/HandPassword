//
//  TestTableViewCell.h
//  HandPassword
//
//  Created by Dongdong on 16/5/6.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TestModel;

@interface TestTableViewCell : UITableViewCell
- (void)configCellData:(TestModel *)model;
@end

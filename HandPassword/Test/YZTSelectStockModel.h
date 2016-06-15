//
//  YZTSelectStockModel.h
//  HandPassword
//
//  Created by Dongdong on 16/5/5.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZTSelectStockModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *know;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, strong) NSArray<NSString *> *relates;
@end

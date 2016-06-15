//
//  YZTLiveModel.h
//  HandPassword
//
//  Created by Dongdong on 16/5/4.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZTLiveModel : NSObject
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) BOOL isNew;
@property (nonatomic, assign) BOOL isShowAll;
@property (nonatomic, strong) NSArray<NSString *> *imageUrls;

@end

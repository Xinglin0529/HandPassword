//
//  YZTCalendarModel.h
//  HandPassword
//
//  Created by Dongdong on 16/5/5.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZTCalendarModel : NSObject
@property (nonatomic, copy) NSString *flagUrl;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *currentValue;
@property (nonatomic, copy) NSString *previousValue;
@property (nonatomic, copy) NSString *forecastValue;
@end

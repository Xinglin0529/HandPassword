//
//  HandPasswordModel.m
//  HandPassword
//
//  Created by Dongdong on 16/4/27.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "HandPasswordModel.h"

@implementation HandPasswordModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"name":@"customerName"};
}
@end

//
//  NSObject+Objc.h
//  HandPassword
//
//  Created by Dongdong on 16/4/22.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Objc)

- (NSArray<NSString *> *)propertyNames;

- (NSArray<NSString *> *)ivarNames;

- (NSArray<NSString *> *)methodNames;

- (NSArray<NSString *> *)attributes;

+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;
+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;
@end

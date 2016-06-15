//
//  NSObject+Objc.m
//  HandPassword
//
//  Created by Dongdong on 16/4/22.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "NSObject+Objc.h"
#import <objc/runtime.h>

@implementation NSObject (Objc)

- (NSArray<NSString *> *)propertyNames
{
    NSMutableArray<NSString *> *a = [[NSMutableArray alloc] init];
    u_int count;
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    for (NSInteger i = 0; i < count; i++  ) {
        objc_property_t property_t = properties[i];
        const char *name = property_getName(property_t);
        [a addObject:@(name)];
    }
    return a;
}

- (NSArray<NSString *> *)ivarNames
{
    NSMutableArray<NSString *> *a = [[NSMutableArray alloc] init];
    u_int cout;
    Ivar *ivars = class_copyIvarList(self.class, &cout);
    for (NSInteger i = 0; i < cout; i++) {
        const char *name = ivar_getName(ivars[i]);
        [a addObject:@(name)];
    }
    return a;
}

- (NSArray<NSString *> *)methodNames
{
    NSMutableArray<NSString *> *m = [[NSMutableArray alloc] init];
    u_int count;
    Method *methods = class_copyMethodList(self.class, &count);
    for (NSInteger i = 0; i < count; i++) {
        SEL sel = method_getName(methods[i]);
        const char *selName = sel_getName(sel);
        [m addObject:@(selName)];
    }
    return m;
}

- (NSArray<NSString *> *)attributes
{
    NSMutableArray<NSString *> *a = [[NSMutableArray alloc] init];
    u_int count;
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    for (NSInteger i = 0; i < count; i++  ) {
        objc_property_t property_t = properties[i];
        const char *attribute = property_getAttributes(property_t);
        [a addObject:@(attribute)];
    }
    return a;
}

+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel
{
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return NO;
    
    class_addMethod(self,
                    originalSel,
                    class_getMethodImplementation(self, originalSel),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(self,
                    newSel,
                    class_getMethodImplementation(self, newSel),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                   class_getInstanceMethod(self, newSel));
    return YES;
}

+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel
{
    Class class = object_getClass(self);
    Method originalMethod = class_getClassMethod(class, originalSel);
    Method newMethod = class_getClassMethod(class, newSel);
    if (!originalMethod || !newMethod) return NO;
    method_exchangeImplementations(originalMethod, newMethod);
    return YES;
}

#pragma mark - private

@end

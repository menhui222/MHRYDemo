//
//  NSObject+MethodSwizzling.m
//  IflyAPP
//
//  Created by little nie on 16/1/5.
//  Copyright © 2016年 iasku. All rights reserved.
//

#import "NSObject+MethodSwizzling.h"

@implementation NSObject (MethodSwizzling)
+ (void)swizzleInstanceSelector:(SEL)originSelector withSelector:(SEL)selector
{
    Class class = [self class];
    Method originMethod = class_getInstanceMethod(class, originSelector);
    Method method = class_getInstanceMethod(class, selector);
    method_exchangeImplementations(originMethod, method);
}

+ (void)swizzleClassSelector:(SEL)originSelector withSelector:(SEL)selector
{
    Class class = [self class];
    Method originMethod = class_getClassMethod(class, originSelector);
    Method method = class_getClassMethod(class, selector);
    method_exchangeImplementations(originMethod, method);
}
@end

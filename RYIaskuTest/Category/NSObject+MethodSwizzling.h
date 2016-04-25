//
//  NSObject+MethodSwizzling.h
//  IflyAPP
//
//  Created by little nie on 16/1/5.
//  Copyright © 2016年 iasku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MethodSwizzling)
+ (void)swizzleClassSelector:(SEL)originSelector withSelector:(SEL)selector;
@end

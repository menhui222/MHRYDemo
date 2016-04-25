
//
//  UIViewController+DynamicExcuteMethod.m
//  iAsku
//
//  Created by niehaili on 15/6/11.
//
//

#import "NSObject+DynamicExcuteMethod.h"

@implementation NSObject (DynamicExcuteMethod)
- (void)dynamicExcuteWithMethodName:(NSString *)methodName
{
    SEL selector = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selector]) {
        NSInvocation* inv = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
        [inv setSelector:selector];
        [inv setTarget:self];
        [inv invoke];
    }
}

+ (void)dynamicExcuteSelector:(SEL)selector arguments:(id)arguments,...
{
    if ([self respondsToSelector:selector]) {
        NSMethodSignature *methodSignature = [self methodSignatureForSelector:selector];
        NSInvocation* inv = [NSInvocation invocationWithMethodSignature:methodSignature];
        
        int index = 2;
        id arg;
        va_list args;
        va_start(args, arguments);
        if (arguments) {
            [inv setArgument:&arguments atIndex:index];
            index++;
        }
        while ((arg = va_arg(args, id))) {
            [inv setArgument:&arg atIndex:index];
            index++;
        }
        va_end(args);
        [inv retainArguments];
        [inv setSelector:selector];
        [inv setTarget:self];
        [inv invoke];
    }
}

- (UITableViewCell *)dynamicExcuteHasReturnValueWithMethodName:(NSString *)methodName
{
    UITableViewCell *cell = nil;
    SEL selector = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selector]) {
        NSInvocation* inv = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
        [inv setSelector:selector];
        [inv setTarget:self];
        [inv invoke];
        void *returnValue = NULL;
        [inv getReturnValue:&returnValue];
        cell = (__bridge UITableViewCell *)returnValue;
    }
    return cell;
}
@end

//
//  UIViewController+DynamicExcuteMethod.h
//  iAsku
//
//  Created by niehaili on 15/6/11.
//
//

#import <UIKit/UIKit.h>

@interface NSObject (DynamicExcuteMethod)
/**
 *  动态的执行方法
 *
 *  @param methodName 方法名
 */
- (void)dynamicExcuteWithMethodName:(NSString *)methodName;

/**
 *  动态执行方法
 *
 *  @param selector  选择方法
 *  @param arguments 参数列表
 */
+ (void)dynamicExcuteSelector:(SEL)selector arguments:(id)arguments,...;

- (id)dynamicExcuteHasReturnValueWithMethodName:(NSString *)methodName;
@end

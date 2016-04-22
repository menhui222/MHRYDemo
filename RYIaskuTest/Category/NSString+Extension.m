//
//  NSString+Extension.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/22.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString(Extension)


- (NSString *)transformChinesePinYin
{
    NSMutableString *pinyin = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    return [pinyin uppercaseString];
}
@end

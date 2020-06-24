//
//  NSString+nocrash.m
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "NSString+nocrash.h"

@implementation NSString(nocrash)
- (id)initWithString2:(NSString *)aString{
    if (!aString) {
        NSLog(@"initWithString2:(%@)", @"aString不能为nil");
        return nil;
    }
    return [self initWithFormat:@"%@",aString];
}
+ (id)stringWithString2:(NSString *)string{
    if (!string) {
        NSLog(@"stringWithString2:(%@)", @"string不能为nil");
        return nil;
    }
    return [self stringWithFormat:@"%@",string];
}
- (NSString *)stringByAppendingString2:(NSString *)aString{
    if (!aString) {
        NSLog(@"stringByAppendingString2:(%@)", @"aString不能为nil");
        return nil;
    }
    return [self stringByAppendingFormat:@"%@",aString];
}
- (NSString *)substringFromIndex2:(NSUInteger)from{
    if (from>=[self length]) {
        NSLog(@"substringFromIndex2:(%@)",@"from越界");
        return nil;
    }
    return [self substringFromIndex:from];
}
- (NSString *)substringToIndex2:(NSUInteger)to{
    if (to>[self length]) {
        NSLog(@"substringToIndex2:(%@)",@"to越界");
        return nil;
    }
    return [self substringToIndex:to];
}

- (NSString *)substringWithRange2:(NSRange)range{
    if (range.location+range.length>[self length]) {
        NSLog(@"substringWithRange:(%@)",@"range越界");
        return nil;
    }
    return [self substringWithRange:range];
}
- (id)objectForKey:(id)aKey{
    NSLog(@"unrecognizedSelector");
    return nil;
}
- (id)objectForKey2:(id)aKey{
    NSLog(@"unrecognizedSelector");
    return nil;
}
- (id)objectAtIndex:(NSUInteger)index{
    NSLog(@"unrecognizedSelector");
    return nil;
}
- (id)objectAtIndex2:(NSUInteger)index{
    NSLog(@"unrecognizedSelector");
    return nil;
}
-(id)allKeys{
    NSLog(@"unrecognizedSelector");
    return nil;
}
- (BOOL)hasPrefix2:(NSString *)aString{
    if (!aString) {
        NSLog(@"hasPrefix2:(%@)", @"aString不能为nil");
        return NO;
    }
    return [self hasPrefix:aString];
}
- (int)count{
    return 0;
}
@end

@implementation NSMutableString(nocrash)
- (void)setString2:(NSString *)aString{
    if (!aString) {
        NSLog(@"setString2:(%@)",@"aString不能为nil");
        return;
    }
    [self setString:aString];
}
- (void)appendString2:(NSString *)aString{
    if (!aString) {
        NSLog(@"aString不能为nil");
        return;
    }
    [self appendFormat:@"%@",aString];
}
@end

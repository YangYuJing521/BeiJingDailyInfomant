//
//  NSString+nocrash.h
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//
#import <Foundation/Foundation.h>
#define llong long long

@interface NSString(nocrash)
- (id)initWithString2:(NSString *)aString;
+ (id)stringWithString2:(NSString *)string;
- (NSString *)stringByAppendingString2:(NSString *)aString;
- (NSString *)substringFromIndex2:(NSUInteger)from;
- (NSString *)substringToIndex2:(NSUInteger)to;
- (NSString *)substringWithRange2:(NSRange)range;
- (id)objectForKey:(id)aKey;
- (id)objectForKey2:(id)aKey;
- (id)objectAtIndex:(NSUInteger)index;
- (id)objectAtIndex2:(NSUInteger)index;
- (BOOL)hasPrefix2:(NSString *)aString;
-(id)allKeys;
- (int)count;
@end

@interface NSMutableString(nocrash)
- (void)setString2:(NSString *)aString;
- (void)appendString2:(NSString *)aString;
@end


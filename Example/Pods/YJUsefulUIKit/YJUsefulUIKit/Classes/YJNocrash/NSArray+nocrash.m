//
//  NSArray+nocrash.m
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "NSArray+nocrash.h"

@implementation NSArray(nocrash)
- (id)initWithArray2:(NSArray *)aArr{
    if (!aArr) {
        NSLog(@"initWithArray2:(%@)", @"aArr不能为nil");
        return nil;
    }
    return [self initWithArray:aArr];
}
- (id)objectAtIndex2:(NSUInteger)index{
    if (index>=[self count]) {
        NSLog(@"objectAtIndex2:(%@)", @"index越界");
        return nil;
    }
    return [self objectAtIndex:index];
}
- (id)objectForKey:(id)aKey{
    NSLog(@"unrecognizedSelector");
    return nil;
}
- (id)objectForKey2:(id)aKey{
    NSLog(@"unrecognizedSelector");
    return nil;
}
-(id)allKeys{
    NSLog(@"unrecognizedSelector");
    return nil;
}
- (BOOL)isEqualToString:(NSString *)aString{
    return NO;
}
@end

@implementation NSMutableArray(nocrash)
- (void)addObject2:(id)anObject{
    if (!anObject) {
        NSLog(@"addObject2:(%@)",@"anObject不能为nil");
        return;
    }
    [self addObject:anObject];
}
- (void)insertObject2:(id)anObject atIndex2:(NSUInteger)index{
    if (!anObject) {
        NSLog(@"insertObject:(%@) atIndex:",@"anObject不能为nil");
        return;
    }
    if (index>[self count]) {
        NSLog(@"insertObject:atIndex:(%@)",@"index越界");
        return;
    }
    [self insertObject:anObject atIndex:index];
}
- (void)removeObjectAtIndex2:(NSUInteger)index{
    if (index>=[self count]) {
        NSLog(@"removeObjectAtIndex2:(%@)",@"index越界");
        return;
    }
    [self removeObjectAtIndex:index];
}
- (void)replaceObjectAtIndex2:(NSUInteger)index withObject2:(id)anObject{
    if (index>=[self count]) {
        NSLog(@"replaceObjectAtIndex:(%@) withObject:",@"index越界");
        return;
    }
    if (!anObject) {
        NSLog(@"replaceObjectAtIndex:withObject:(%@)",@"anObject不能为nil");
        return;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
}
@end


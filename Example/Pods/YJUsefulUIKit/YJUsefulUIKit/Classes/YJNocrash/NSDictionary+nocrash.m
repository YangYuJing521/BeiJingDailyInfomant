//
//  NSDictionary+nocrash.m
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "NSDictionary+nocrash.h"

@implementation NSDictionary(nocrash)
- (id)objectForKey2:(id)aKey{
    if (!aKey) {
        NSLog(@"objectForKey2:(%@)",@"aKey不能为nil");
        return nil;
    }
    if (!self||![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return [self objectForKey:aKey];
}
- (id)objectAtIndex:(NSUInteger)index{
    NSLog(@"unrecognizedSelector");
    return nil;
}
- (id)objectAtIndex2:(NSUInteger)index{
    NSLog(@"unrecognizedSelector");
    return nil;
}
- (int)count{
    return 0;
}
- (BOOL)isEqualToString:(NSString *)aString{
    return NO;
}
@end

@implementation NSMutableDictionary(nocrash)
- (void)removeObjectForKey2:(id)aKey{
    if (!aKey) {
        NSLog(@"removeObjectForKey2:(%@)",@"aKey不能为nil");
        return;
    }
    [self removeObjectForKey:aKey];
}
- (void)setObject2:(id)anObject forKey2:(id)aKey{
    if (!anObject&&!aKey) {
        NSLog(@"setObject2:(%@) forKey2:%@",@"anObject不能为nil",@"aKey不能为nil");
        return;
    }
    if (!anObject) {
        NSLog(@"setObject2:(%@) forKey2:%@",@"anObject不能为nil",aKey);
        return;
    }
    if (!aKey) {
        NSLog(@"setObject2:%@ forKey2:(%@)",anObject,@"aKey不能为nil");
        return;
    }
    [self setObject:anObject forKey:aKey];
}
@end

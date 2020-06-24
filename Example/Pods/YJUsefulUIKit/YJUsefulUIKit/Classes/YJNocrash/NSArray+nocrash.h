//
//  NSArray+nocrash.h
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (nocrash)
- (id)initWithArray2:(NSArray *)aArr;
- (id)objectAtIndex2:(NSUInteger)index;
- (id)objectForKey:(id)aKey;
- (id)objectForKey2:(id)aKey;
-(id)allKeys;
- (BOOL)isEqualToString:(NSString *)aString;
@end

@interface NSMutableArray (nocrash)
- (void)addObject2:(id)anObject;
- (void)insertObject2:(id)anObject atIndex2:(NSUInteger)index;
- (void)removeObjectAtIndex2:(NSUInteger)index;
- (void)replaceObjectAtIndex2:(NSUInteger)index withObject2:(id)anObject;
@end


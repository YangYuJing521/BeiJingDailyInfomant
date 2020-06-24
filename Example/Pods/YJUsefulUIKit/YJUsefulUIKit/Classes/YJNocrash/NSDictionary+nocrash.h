//
//  NSDictionary+nocrash.h
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (nocrash)
- (id)objectForKey2:(id)aKey;
- (id)objectAtIndex:(NSUInteger)index;
- (id)objectAtIndex2:(NSUInteger)index;
- (int)count;
- (BOOL)isEqualToString:(NSString *)aString;
@end

@interface NSMutableDictionary (nocrash)
- (void)removeObjectForKey2:(id)aKey;
- (void)setObject2:(id)anObject forKey2:(id)aKey;
@end

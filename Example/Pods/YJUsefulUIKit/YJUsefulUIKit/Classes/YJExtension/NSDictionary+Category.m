//
//  NSDictionary+Category.m
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)
-(id)objectOrNilForKey:(NSString *)key{
    
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNull class]]) {
        return nil;
    }else{
        if ([object isKindOfClass:[NSString class]]) {
            if ([object isEqualToString:@"<null>"]||[object isEqualToString:@"null"]||[object isEqualToString:@"(null)"]||[object isEqualToString:@"\"<null>\""]) {
                return nil;
            }
            return object;
        }
        return object;
    }
}

@end

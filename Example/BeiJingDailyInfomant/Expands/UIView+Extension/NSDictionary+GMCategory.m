//
//  NSDictionary+GMCategory.m
//  GomeShop
//
//  Created by ued1 on 2018/9/18.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import "NSDictionary+GMCategory.h"

@implementation NSDictionary (GMCategory)
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

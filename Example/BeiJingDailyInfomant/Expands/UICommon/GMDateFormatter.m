//
//  GMDateFormatter.m
//  GomeShop
//
//  Created by MeiShopiOS on 2018/11/28.
//  Copyright © 2018 mshop. All rights reserved.
//

#import "GMDateFormatter.h"

@implementation GMDateFormatter
static GMDateFormatter *_instance = nil;

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[GMDateFormatter alloc] init];
    });
    return _instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
@end

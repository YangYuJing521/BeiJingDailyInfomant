//
//  NSURL+nocrash.m
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "NSURL+nocrash.h"

@implementation NSURL(nocrash)
+ (id)URLWithString2:(NSString *)URLString{
    if (!URLString) {
        NSLog(@"URLWithString2:(%@)", @"URLString不能为nil");
        return nil;
    }
    return [self URLWithString:URLString];
}
+ (id)URLWithString2:(NSString *)URLString relativeToURL:(NSURL *)baseURL{
    if (!URLString) {
        NSLog(@"URLWithString2:(%@) relativeToURL:", @"URLString不能为nil");
        return nil;
    }
    return [self URLWithString:URLString relativeToURL:baseURL];
}
@end

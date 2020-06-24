//
//  NSURL+nocrash.h
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL(nocrash)
+ (id)URLWithString2:(NSString *)URLString;
+ (id)URLWithString2:(NSString *)URLString relativeToURL:(NSURL *)baseURL;
@end

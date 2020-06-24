//
//  NSNumber+nocrash.m
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "NSNumber+nocrash.h"

@implementation NSNumber(nocrash)
- (BOOL)isEqualToString:(NSString *)aString{
    return [[NSString stringWithFormat:@"%@",self] isEqualToString:aString];
}
-(NSUInteger)length{
    return [[NSString stringWithFormat:@"%@",self] length];
}
@end

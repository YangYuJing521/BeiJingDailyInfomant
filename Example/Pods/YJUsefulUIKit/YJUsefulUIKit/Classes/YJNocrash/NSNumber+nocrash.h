//
//  NSNumber+nocrash.h
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber(nocrash)
- (BOOL)isEqualToString:(NSString *)aString;
-(NSUInteger)length;
@end


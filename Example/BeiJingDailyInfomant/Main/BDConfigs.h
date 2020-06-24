//
//  BDConfigs.h
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/23.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, NSTabBarType) {
    NSTabBarTypeHome = 0,  //首页
    NSTabBarTypeLive,
    NSTabBarTypeBJNum,
    NSTabBarTypeService,
    NSTabBarTypeMe,
};


@interface BDConfigs : NSObject
extern NSString *const BAOLIAOROUTER;  //爆料类型选择
@end

NS_ASSUME_NONNULL_END

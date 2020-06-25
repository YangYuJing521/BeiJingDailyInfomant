//
//  ReadJsonHandler.h
//  BeiJingDailyInfomant
//
//  Created by 杨玉京 on 2020/6/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^Result)(id data, BOOL isSucceed);
@interface ReadJsonHandler : NSObject

/** 读取爆料列表本地模拟数据 */
+(void)GetBaoLiaoTypesFromLocalJson:(Result) result;
@end

NS_ASSUME_NONNULL_END

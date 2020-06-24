//
//  BDAppDelegate+Category.m
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/23.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "BDAppDelegate+Category.h"
#import "BDInfomantMainVC.h"


@implementation BDAppDelegate (Category)

-(void)registSchemes{
    [MGJRouter registerURLPattern:BAOLIAOROUTER toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        BDInfomantMainVC *vc = [[BDInfomantMainVC alloc] init];
        [navigationVC pushViewController:vc animated:YES];
    }];
}
@end

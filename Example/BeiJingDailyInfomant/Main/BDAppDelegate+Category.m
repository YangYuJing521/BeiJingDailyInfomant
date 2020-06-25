//
//  BDAppDelegate+Category.m
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/23.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "BDAppDelegate+Category.h"
#import "BDInfomantMainVC.h"
#import "BDInfomantCommitController.h"

@implementation BDAppDelegate (Category)

-(void)registSchemes{
    [MGJRouter registerURLPattern:BAOLIAOLISTROUTER toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        BDInfomantMainVC *vc = [[BDInfomantMainVC alloc] init];
        [navigationVC pushViewController:vc animated:YES];
    }];
    
    [MGJRouter registerURLPattern:BAOLIAOCOMMITROUTER toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        BDInfomantCommitController *vc = [[BDInfomantCommitController alloc] init];
        vc.dataModel = routerParameters[MGJRouterParameterUserInfo][@"dataModel"];
        [navigationVC pushViewController:vc animated:YES];
    }];

}
@end

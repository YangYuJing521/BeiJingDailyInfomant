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
    // 类型选择
    [MGJRouter registerURLPattern:BAOLIAOLISTROUTER toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        BDInfomantMainVC *vc = [[BDInfomantMainVC alloc] init];
        vc.isFromCommit = routerParameters[MGJRouterParameterUserInfo][@"isFromCommit"];
        [navigationVC pushViewController:vc animated:YES];
    }];
    
    // 提交页面
    [MGJRouter registerURLPattern:BAOLIAOCOMMITROUTER toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        NSNumber *commit = routerParameters[MGJRouterParameterUserInfo][@"isFromCommit"];
        BOOL isFromCommit = commit.boolValue;
        if (isFromCommit) {//在提交页面选择类型
            for (UIViewController *vc in navigationVC.viewControllers) {
                if ([vc isKindOfClass:[BDInfomantCommitController class]]){
                    ((BDInfomantCommitController *)vc).dataModel = routerParameters[MGJRouterParameterUserInfo][@"dataModel"];
                    [navigationVC popToViewController:vc animated:YES];
                    return ;
                }
            }
        }
        //在我的-爆料入口选择类型
        BDInfomantCommitController *vc = [[BDInfomantCommitController alloc] init];
        vc.dataModel = routerParameters[MGJRouterParameterUserInfo][@"dataModel"];
        [navigationVC pushViewController:vc animated:YES];
    }];

}
@end

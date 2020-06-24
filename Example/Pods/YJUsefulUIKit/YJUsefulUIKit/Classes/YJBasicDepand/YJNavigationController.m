//
//  YJNavigationController.m
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "YJNavigationController.h"
#import "YJUICommon.h"
@interface YJNavigationController ()

@end

@implementation YJNavigationController
#pragma mark - load初始化一次
+(void)load{
    [self setUpBase];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (void)setUpBase
{
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = [UIColor whiteColor];
    [bar setTintColor:[UIColor darkGrayColor]];
    bar.translucent = YES;
    //让导航栏透明

    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置导航栏字体颜色
    UIColor * naiColor = [UIColor blackColor];
    attributes[NSForegroundColorAttributeName] = naiColor;
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    bar.titleTextAttributes = attributes;
    bar.shadowImage = [YJUITools imageWithColor:HEXCOLOR(0xe4e4e4) size:CGSizeMake(ScreenW,0.5)];
}

#pragma mark - 返回
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count >= 1) {
        //返回按钮自定义
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -15;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 33, 33);
        
        if (@available(ios 11.0,*)) {
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -15,0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10,0, 0);
        }

        [button addTarget:self action:@selector(backButtonTapClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    //跳转
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 点击
- (void)backButtonTapClick {
    [self popViewControllerAnimated:YES];
}


@end

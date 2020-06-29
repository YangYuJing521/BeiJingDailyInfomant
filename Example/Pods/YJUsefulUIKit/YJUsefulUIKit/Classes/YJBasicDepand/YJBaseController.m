//
//  YJBaseController.m
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "YJBaseController.h"
#import "YJUIViewExtenson.h"
@interface YJBaseController ()

@end

@implementation YJBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        //ios 11以下
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //左导航
    if (self.navigationController.childViewControllers.count > 1) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -15; //ios11一下有用
        
        EazyClickButton *button = (EazyClickButton *)[self leftBarButton];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
    }
    //右导航
    EazyClickButton *rightBtn = (EazyClickButton *)[self rightBarButton];
    if (rightBtn) {
        [rightBtn addTarget:self action:@selector(rightBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSpacer.width = -5;
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }

}


#pragma mark 导航栏按钮及点击事件
/** 默认返回按钮 */
-(EazyClickButton *)leftBarButton{
    EazyClickButton *button = [[EazyClickButton alloc] init];
    [button setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 33, 33);
    if (@available(ios 11.0,*)) {
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -15,0, 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -10,0, 0);
    }
    [button addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
/** 默认没有rightbaritem */
-(EazyClickButton *)rightBarButton{
    return nil;
}
/** 默认返回 */
-(void)leftBarButtonItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 默认无点击事件 */
-(void)rightBarButtonItemClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    [[SDWebImageManager sharedManager] cancelAll];
}

- (void)dealloc
{
    NSLog(@"%@---dealloc",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

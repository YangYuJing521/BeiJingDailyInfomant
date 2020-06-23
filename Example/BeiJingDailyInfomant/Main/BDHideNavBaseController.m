//
//  BDHideNavBaseController.m
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "BDHideNavBaseController.h"

@interface BDHideNavBaseController ()

@end

@implementation BDHideNavBaseController

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = GMBGColor255;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)dealloc
{
    NSLog(@"%@---dealloc",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

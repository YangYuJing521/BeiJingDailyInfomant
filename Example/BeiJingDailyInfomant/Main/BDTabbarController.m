//
//  BDTabbarController.m
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "BDTabbarController.h"
#import "BDNavigationController.h"

@interface BDTabbarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) NSMutableArray *tabBarItems;
@end

@implementation BDTabbarController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    NSDate * date = [NSDate date];
//    NSLog(@"结束时间***%@",date);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;

    [self addDcChildViewContorller];
    self.selectedViewController = [self.viewControllers objectAtIndex:GMTabBarControllerHome]; //默认选择首页index为0
    //背景颜色
    [self.tabBar setShadowImage:[self imageWithColor:[UIColor whiteColor] Hight:0.5]];
    [self.tabBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor] Hight:0.5]];
    self.tabBar.backgroundImage =[self imageWithColor:[UIColor whiteColor] Hight:kTabbarHeight];
}

-(UIImage *)imageWithColor:(UIColor *)color Hight:(CGFloat)hight{
    CGRect rect = CGRectMake(0.0f,0.0f, ScreenW,hight);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 添加子控制器
- (void)addDcChildViewContorller
{
    
    NSArray *childArray = @[
                            @{MallClassKey  : @"BDBaseController",
                              MallTitleKey  : @"新闻",
                              MallImgKey    : @"icon-home",
                              MallSelImgKey : @"icon-home-act",},
                            @{MallClassKey  : @"BDBaseController",
                              MallTitleKey  : @"直播",
                              MallImgKey    : @"icon_chat",
                              MallSelImgKey : @"icon_chat_act"},
                            @{
                              MallClassKey  : @"BDBaseController",
                              MallTitleKey  : @"北京号",
                              MallImgKey    : @"icon-shopkeeper",
                              MallSelImgKey : @"icon-shopkeeper-act",},
                            @{
                               MallClassKey  : @"BDBaseController",
                               MallTitleKey  : @"服务",
                               MallImgKey    : @"icon-shopkeeper",
                               MallSelImgKey : @"icon-shopkeeper-act",},
                            @{
                              MallClassKey  : @"BDMeViewController",
                              MallTitleKey  : @"我的",
                              MallImgKey    : @"icon-my",
                              MallSelImgKey : @"icon-my-act",},
                            
                            ];
    for (int i = 0; i<childArray.count; i++) {
        NSDictionary *dict = [childArray objectOrNilAtIndex:i];
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
        BDNavigationController *nav = [[BDNavigationController alloc] initWithRootViewController:vc];
        [self addChildViewController:nav];
        UITabBarItem *item = vc.tabBarItem;
        item.image = [[UIImage imageNamed:dict[MallImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.title = [dict objectOrNilForKey:MallTitleKey];
        if (i == GMTabBarControllerShopKeeper) {
            
        }
        NSDictionary *normal = @{
                                 NSFontAttributeName:PFRFont(10),
                                 NSForegroundColorAttributeName:GMRedTextColor238_50_40,
                                 };
        NSDictionary *selected = @{
                                 NSFontAttributeName:PFRFont(10),
                                 NSForegroundColorAttributeName:GMBlackTextColor51,
                                 };
        [item setTitleTextAttributes:normal forState:UIControlStateSelected];
        [item setTitleTextAttributes:selected forState:UIControlStateNormal];
//        item.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);//（当只有图片的时候）需要自动调整
        // 添加tabBarItem至数组
        [self.tabBarItems addObject:vc.tabBarItem];
        }
}


#pragma mark - 控制器跳转拦截
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
}
- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    
    return tabBarButton;
}

#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
    
}

#pragma mark - 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - LazyLoad
- (NSMutableArray *)tabBarItems {
    
    if (_tabBarItems == nil) {
        _tabBarItems = [NSMutableArray array];
    }
    return _tabBarItems;
}

@end

//
//  UIViewController+BDScroll.h
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/27.
//  Copyright © 2020 silverBullet. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol BDScrollVCDelegate <NSObject>

- (void)childVc:(UIViewController *)childVc scrollViewDidScroll:(UIScrollView *)scroll;

@end

@interface UIViewController (BDScroll)
- (void)setCurrentScrollContentOffsetY:(CGFloat)offsetY;

@end

NS_ASSUME_NONNULL_END

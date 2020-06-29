//
//  UIViewController+BDScroll.m
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/27.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "UIViewController+BDScroll.h"


@implementation UIViewController (BDScroll)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.parentViewController && [self.parentViewController respondsToSelector:@selector(childVc:scrollViewDidScroll:)]) {
        [self.parentViewController performSelector:@selector(childVc:scrollViewDidScroll:) withObject:self withObject:scrollView];
    }
}

- (void)setCurrentScrollContentOffsetY:(CGFloat)offsetY {
    
    if ([self isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableVC = (UITableViewController *)self;
        if (offsetY <= 200*kWidthRatio) {
            [tableVC.tableView setContentOffset:CGPointMake(0, offsetY)];
        } else if (tableVC.tableView.contentOffset.y < offsetY && tableVC.tableView.contentOffset.y <200*kWidthRatio) {
            [tableVC.tableView setContentOffset:CGPointMake(0, 200*kWidthRatio)];
        }
    }
}

@end

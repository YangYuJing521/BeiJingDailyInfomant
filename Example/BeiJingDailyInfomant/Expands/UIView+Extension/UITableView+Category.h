//
//  UITableView+Category.h
//  GomeShop
//
//  Created by Gome on 2018/8/20.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Category)

/**
 *  快速创建tableView
 *
 *  @param delegate 代理
 *
 *  @return 返回一个自定义的tableView
 */
+ (UITableView *)initTableViewWithDelegate:(id)delegate;

/*没有更多了*/
-(UIView*)NoMoreFooter;

@end

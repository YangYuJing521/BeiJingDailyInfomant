//
//  UITableView+Category.h
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
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

//
//  UITableView+Category.m
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "UITableView+Category.h"
#import "UILabel+Extension.h"
#import "YJmacros.h"
#import "YYCategories.h"

@implementation UITableView (Category)
/** 默认 */
+ (UITableView *)initTableViewWithDelegate:(id)delegate;
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.sectionFooterHeight =0.f;
    tableView.sectionHeaderHeight =0.f;
    
    adjustsScrollViewInsets(tableView);
    return tableView;
}

-(UIView*)NoMoreFooter{
    
    UIView * footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 47*kWidthRatio)];
    footer.backgroundColor =HEXCOLOR(0xF3F5F7);
    UILabel * noMoreLabel = [UILabel addLabelWithtitle:@"没有更多了" titleColor:HEXCOLOR(0xCCCCCC) font:PFRFont(12)];
    [footer addSubview:noMoreLabel];
    noMoreLabel.textAlignment =NSTextAlignmentCenter;
    noMoreLabel.frame =CGRectMake(0, 15*kWidthRatio, self.width, 17*kWidthRatio);
    return footer;
}

@end

//
//  BDBJHListController.m
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/27.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "BDBJHListController.h"
#import "BDBJHNewsCell.h"

@interface BDBJHListController ()

@end

@implementation BDBJHListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delaysContentTouches = NO;
    self.tableView.canCancelContentTouches = YES;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HEXCOLOR(0xF3F5F7);
    self.tableView.rowHeight=120*kWidthRatio;
    UITableViewHeaderFooterView *headerV = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 244*kWidthRatio)];
    self.tableView.tableHeaderView = headerV;
    [self.view layoutIfNeeded];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDBJHNewsCell *cell = [BDBJHNewsCell cellWithTableView:tableView identifier:@"BDBJHNewsCellID"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

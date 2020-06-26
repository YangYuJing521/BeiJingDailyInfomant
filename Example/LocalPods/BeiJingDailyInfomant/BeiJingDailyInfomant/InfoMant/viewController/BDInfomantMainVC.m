//
//  BDInfomantMainVC.m
//  Pods-BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/21.
//

#import "BDInfomantMainVC.h"
#import "ReadJsonHandler.h"
#import "BaoLiaoTypeModel.h"
#import "BDBaoLiaoTypeCell.h"
#import "BDConfigs.h"

static NSString *const BDBaoLiaoTypeCellID = @"BDBaoLiaoTypeCellID";

@interface BDInfomantMainVC ()
<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;   //模型数据
@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;  //缓存行高
@end

@implementation BDInfomantMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"爆料话题";
    self.view.backgroundColor = GMBGColor255;
    self.heightAtIndexPath = [NSMutableDictionary dictionary];
    //获取数据
    WEAKSELF
    [ReadJsonHandler GetBaoLiaoTypesFromLocalJson:^(id  _Nonnull data, BOOL isSucceed) {
        NSArray *list = [[data objectForKey2:@"data"] objectForKey2:@"list"];
        weakSelf.dataArray = [BaoLiaoTypeModel mj_objectArrayWithKeyValuesArray:list];
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BDBaoLiaoTypeCell *cell = [BDBaoLiaoTypeCell cellWithTableView:tableView identifier:BDBaoLiaoTypeCellID];
    cell.indexPath = indexPath;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [MGJRouter openURL:BAOLIAOCOMMITROUTER withUserInfo:@{@"navigationVC" : self.navigationController,
                                                             @"dataModel" : self.dataArray[indexPath.row],
                                                          @"isFromCommit" : self.isFromCommit} completion:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *height = [self.heightAtIndexPath objectForKey2:[NSString stringWithFormat:@"%zd",indexPath.row]];
    if (TO_STR(height).length) return height.floatValue;
    return UITableViewAutomaticDimension;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *height = [NSString stringWithFormat:@"%f",cell.frame.size.height];
    [self.heightAtIndexPath setObject2:height forKey2:[NSString stringWithFormat:@"%zd",indexPath.row]];
}
#pragma mark lazy load
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight, ScreenW, ScreenH-kStatusBarAndNavigationBarHeight-kTabbarSafeBottomMargin)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 150;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end

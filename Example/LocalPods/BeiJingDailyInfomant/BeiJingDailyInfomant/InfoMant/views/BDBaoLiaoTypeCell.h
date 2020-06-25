//
//  BDBaoLiaoTypeCell.h
//  BeiJingDailyInfomant
//
//  Created by 杨玉京 on 2020/6/25.
//

#import <YJUsefulUIKit/YJUsefulUIKit.h>
#import "BaoLiaoTypeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BDBaoLiaoTypeCell : YJTemplateTableViewCell
//构造
+(BDBaoLiaoTypeCell *)cellWithTableView:(UITableView *)tableView
                             identifier:(NSString *)ID;

//数据
@property (nonatomic, strong) BaoLiaoTypeModel *model;
@end

NS_ASSUME_NONNULL_END

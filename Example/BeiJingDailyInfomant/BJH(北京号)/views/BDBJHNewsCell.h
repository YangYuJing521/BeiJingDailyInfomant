//
//  BDBJHNewsCell.h
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/29.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <YJUsefulUIKit/YJUsefulUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDBJHNewsCell : YJTemplateTableViewCell
+(BDBJHNewsCell *)cellWithTableView:(UITableView *)tableView
                         identifier:(nonnull NSString *)ID;
@end

NS_ASSUME_NONNULL_END

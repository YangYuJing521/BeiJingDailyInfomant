//
//  YJTemplateTableViewCell.h
//
//  Created by 杨玉京 on 2020/6/23.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TemplateTableViewCellDelegate <NSObject>

- (void)contentTableviewDidClickWithType:(NSString *)type contentData:(id )contentData indexPath:(NSIndexPath *)indexPath index:(NSInteger)index;

@end

@interface YJTemplateTableViewCell : UITableViewCell
@property (nonatomic, weak) id <TemplateTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

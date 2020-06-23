//
//  GMTemplateTableViewCell.h
//  GomeShop
//
//  Created by ued1 on 2018/8/13.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GMTemplateTableViewCellDelegate <NSObject>

- (void)contentTableviewDidClickWithType:(NSString *)type contentData:(id )contentData indexPath:(NSIndexPath *)indexPath index:(NSInteger)index;

@end

@interface GMTemplateTableViewCell : UITableViewCell
@property (nonatomic, weak) id <GMTemplateTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

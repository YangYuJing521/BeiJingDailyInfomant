//
//  TemplateBaseCell.h
//  GomeShop
//
//  Created by ued1 on 2018/8/8.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TemplateBaseCellCellDelegate <NSObject>

- (void)contentViewDidClickWithType:(NSString *)type contentData:(id )contentData indexPath:(NSIndexPath *)indexPath index:(NSInteger)index;

@end

@interface TemplateBaseCell : UICollectionViewCell
@property (nonatomic, weak) id <TemplateBaseCellCellDelegate> delegate;
@property (nonatomic, strong) UIImageView *backgroudImageView;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

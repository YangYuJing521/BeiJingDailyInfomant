//
//  YJTemplateBaseCell.h
//
//  Created by 杨玉京 on 2020/6/23.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TemplateBaseCellCellDelegate <NSObject>

- (void)contentViewDidClickWithType:(NSString *)type contentData:(id )contentData indexPath:(NSIndexPath *)indexPath index:(NSInteger)index;

@end

@interface YJTemplateBaseCell : UICollectionViewCell
@property (nonatomic, weak) id <TemplateBaseCellCellDelegate> delegate;
@property (nonatomic, strong) UIImageView *backgroudImageView;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

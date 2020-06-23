//
//  TemplateBaseReusableView.h
//  GomeShop
//
//  Created by ued1 on 2018/8/10.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TemplateBaseReusableViewDelegate <NSObject>

- (void)reuseableViewDidClickWithType:(NSString *)type contentData:(id )contentData indexPath:(NSIndexPath *)indexPath index:(NSInteger)index;

@end
@interface TemplateBaseReusableView : UICollectionReusableView
@property (nonatomic, weak) id <TemplateBaseReusableViewDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

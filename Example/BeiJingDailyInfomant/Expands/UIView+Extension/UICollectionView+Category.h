//
//  UICollectionView+Category.h
//  GomeShop
//
//  Created by Gome on 2018/8/15.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (Category)

/*
 添加collectionView视图

 @param delegate 代理
 @param supView 父视图
 @return UICollectionView
 */
+(UICollectionView*)addCollectionViewDelegate:(id)delegate SupView:(UIView*)supView;

@end

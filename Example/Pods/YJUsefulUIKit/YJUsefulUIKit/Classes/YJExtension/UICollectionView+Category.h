//
//  UICollectionView+Category.h
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
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

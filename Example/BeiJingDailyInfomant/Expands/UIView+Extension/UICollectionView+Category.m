//
//  UICollectionView+Category.m
//  GomeShop
//
//  Created by Gome on 2018/8/15.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import "UICollectionView+Category.h"
#import "macros.h"

@implementation UICollectionView (Category)

+(UICollectionView*)addCollectionViewDelegate:(id)delegate SupView:(UIView*)supView{
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
     UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = delegate;
    collectionView.dataSource = delegate;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    adjustsScrollViewInsets(collectionView);
    [supView addSubview:collectionView];
    
    return collectionView;
}
@end

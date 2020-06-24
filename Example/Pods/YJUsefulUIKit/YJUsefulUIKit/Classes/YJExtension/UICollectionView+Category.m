//
//  UICollectionView+Category.m
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "UICollectionView+Category.h"
#import "YJmacros.h"

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

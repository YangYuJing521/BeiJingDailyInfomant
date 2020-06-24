//
//  YJTemplateBaseReusableView.h
//
//  Created by 杨玉京 on 2020/6/23.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TemplateBaseReusableViewDelegate <NSObject>

- (void)reuseableViewDidClickWithType:(NSString *)type contentData:(id )contentData indexPath:(NSIndexPath *)indexPath index:(NSInteger)index;

@end
@interface YJTemplateBaseReusableView : UICollectionReusableView
@property (nonatomic, weak) id <TemplateBaseReusableViewDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

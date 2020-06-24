//
//  YJCycleScrollViewCell.h
//  YJCycleScrollViewCell
//
//  Created by 杨玉京 on 2020/6/22.
//

#import <UIKit/UIKit.h>

@interface YJCycleScrollViewCell : UICollectionViewCell
@property(nonatomic,assign) BOOL hasConfig;//标记是否配置过cell UI属性
@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)NSString *title;
@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, assign) CGFloat titleLabelHeight;
@property (nonatomic, assign) NSTextAlignment titleLabelTextAlignment;
@end

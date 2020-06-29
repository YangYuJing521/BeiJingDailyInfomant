//
//  BDSegmentItemView.h
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/27.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BDSegmentItemView;

@protocol BDSegmentItemViewDelegate <NSObject>

- (void)segmentBar:(BDSegmentItemView *)segmentBar tapIndex:(NSInteger)index;

@end

@interface BDSegmentItemView : UIView
/*当前被选中的位置*/
@property (nonatomic, assign) NSInteger changeIndex;
/*所有的文本*/
@property (nonatomic,strong) NSArray *segmentModels;
/*指示器*/
@property (nonatomic, strong) UIView *indicatorView;
/*所有的按钮*/
@property (nonatomic,strong) NSMutableArray * btns;
/*最后被点击的*/
@property (nonatomic, weak) UIButton *lastBtn;
/*代理*/
@property(nonatomic,weak)id<BDSegmentItemViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame  SegmentItems:(NSArray*)segmentItems;

@end

NS_ASSUME_NONNULL_END

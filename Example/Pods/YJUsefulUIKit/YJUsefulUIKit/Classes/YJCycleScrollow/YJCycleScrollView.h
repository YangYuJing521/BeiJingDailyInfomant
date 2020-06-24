//
//  YJCycleScrollView.h
//  YJCycleScrollView
//  实现banner轮播图，可支持无限轮播、自动轮播；banner图片源可传本地图，也可传图片url地址；
//  pagerConrol和banner上的标题可显示可隐藏。
//  实现方案，采用UICollectionView做容器，无限轮播banner数（n）乘1000，达到边界时再重置到初始位置。
//  解决轮播出现半屏问题、banner空白问题。
//  支持layout设置frame布局
//  Created by 杨玉京 on 2020/6/22.
//

#import <UIKit/UIKit.h>
//PageControl 位置
typedef NS_ENUM(NSInteger,PageControlAliment){
    PageContolAlimentRight,
    PageContolAlimentCenter,
    PageContolAlimentLeft,
};
@class GMCycleScrollView;
@protocol YJCycleScrollViewDelegate <NSObject>
@optional
//banner 点击事件
- (void)cycleScrollView:(GMCycleScrollView *)cycleScrollView didSelectAtIndex:(NSInteger)index;

/** 图片滚动回调 */
- (void)cycleScrollView:(GMCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index;

@end

/**
 对接MVPClean 设计，GMCycleScrollView的展示数据源 由DataSource提供
 */
@protocol YJCycleScrollViewDataSource <NSObject>
@required

/**
 获取轮播图数组
 @return 轮播图数组
 */
-(NSArray*)cycleScrollViewImagesGroup;
@optional

/**
 获取banner标题数组

 @return banner标题数组
 */
-(NSArray*)cycleScrollViewTitlesGroup;

/**
 获取banner标题高度

 @return banner标题高度
 */
-(CGFloat)cycleScrollViewTitleLableHeight;
@end

@interface YJCycleScrollView : UIView
+(instancetype)cycleScrollViewWithFrame:(CGRect)frame imageNamesGroup:(NSArray*)imageNameGroup;
+(instancetype)cycleScrollViewWithFrame:(CGRect)frame imageUrlsGroup:(NSArray*)imageUrlsGroup;
+(instancetype)cycleScrollViewWithFrame:(CGRect)frame imageNamesGroup:(NSArray*)imageNameGroup cycleLoop:(BOOL)isCycleLoop;

/** 解决轮播图卡在一半的问题，在控制器viewWillAppear时调用此方法 */
- (void)adjustWhenControllerViewWillAppera;

@property(nonatomic,weak) id<YJCycleScrollViewDelegate> delegate;
/**
 MVPClean 下提供展示数据源
 */
@property(nonatomic,weak) id<YJCycleScrollViewDataSource> dataSource;
/** 数据源 */
@property (nonatomic, strong) NSArray *imageURLStringsGroup;//网络图片url string数组

@property (nonatomic, strong) NSArray *titlesGroup;//每张图片对应要显示的文字数组
@property (nonatomic, strong) NSArray *localizationImageNamesGroup;//本地图片数组
@property (nonatomic, strong) UIImage *placeholderImage;//占位图，用于网络未加载到图片时

/** UI风格 */
@property(nonatomic,assign) BOOL isCycleLoop; //是否无限循环，默认NO
@property(nonatomic,assign) BOOL isAutoScroll; //是否自动滚动，默认YES
@property(nonatomic,assign) BOOL isShowPageControl; //是否显示PageControl
@property(nonatomic,assign) BOOL isShowBannerTitle; //banner是否显示文字
@property(nonatomic,assign) PageControlAliment pageControlAliment;
/**Config*/
@property(nonatomic,assign) CGFloat autoScrollTimeInterval;//自动轮播间隔时间
@property(nonatomic,strong) UIColor *pageIndicatorTintColor;//pageControl 圆点颜色
@property(nonatomic,strong) UIColor *currentPageIndicatorTintColor;//pageControl 当前页圆点颜色

@property(nonatomic,assign) CGFloat titleLableHeight; //标题高，如果现实banner标题，必须设置。
@property (nonatomic, strong) UIColor *titleLabelTextColor;//标题颜色
@property (nonatomic, strong) UIFont *titleLabelTextFont;//标题字体
@property (nonatomic, assign) NSTextAlignment titleLabelTextAlignment;//标题位置
/** 自定义设置 */

/** 轮播图片的ContentMode，默认为 UIViewContentModeScaleToFill */
@property (nonatomic, assign) UIViewContentMode bannerImageViewContentMode;

@end

//
//  YJGuidePageView.h
//  Pods
//  一个简单的引导页，在APP初次安装启动或引导页版本更新后初次启动显示。
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJGuidePageView : UIView<UIScrollViewDelegate>{
    UIPageControl *pageControl;
    UIScrollView *mainScrollView;
    UIButton *goHomeBtn;
}
-(void)show;
@property(nonatomic,copy) NSArray *imageArray; //引导页每页的内容图
@property(nonatomic,copy) NSString *guidePageVersion; //版本号，如image改变时 请更新version
@property(nonatomic,strong) UIImage *buttonNomalImage; //最后一页的按钮图（非点击状态）
@property(nonatomic,strong) UIImage *buttonSelectedImage; //最后一页的按钮图（点击状态）
@property(nonatomic,strong) NSString *buttonTitle;//最后一页的按钮标题（如果按钮图已带文字请不要设置）
@property(nonatomic,strong) UIColor *buttonTitleColor;
@property(nonatomic,assign) BOOL moveRightDismiss;//在最右边继续滑动引导页消失进入APP主页，默认NO。
@property(nonatomic,strong) UIColor *currentPageIndicatorTintColor;
@property(nonatomic,strong) UIColor *pageIndicatorTintColor;

@end

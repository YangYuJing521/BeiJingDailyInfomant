//
//  BDBJHMainController.m
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/27.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "BDBJHMainController.h"
#import "BDDefineScrollView.h"
#import "YJCycleScrollView.h"
#import "BDSegmentItemView.h"
#import "BDBJHListController.h"
#import "UIViewController+BDScroll.h"

@interface BDBJHMainController ()<UIScrollViewDelegate,BDSegmentItemViewDelegate>
@property (nonatomic, strong) BDDefineScrollView *contentView;
@property (nonatomic, strong) YJCycleScrollView *cycleScrollView;
@property (nonatomic, strong) BDSegmentItemView *segmentView;
@end

@implementation BDBJHMainController
{
    NSInteger _currentIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = GMBGGrayColor240;
    [self addChilds];
    [self configUI];
}

-(void)configUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.contentView = [[BDDefineScrollView alloc] initWithFrame:self.view.bounds];
    self.contentView.delegate = self;
    self.contentView.showsHorizontalScrollIndicator = NO;
    self.contentView.pagingEnabled = YES;
    self.contentView.contentSize = CGSizeMake(ScreenW*self.childViewControllers.count, 0);
    [self.view addSubview:self.contentView];
    
    NSArray *urlAray = @[
        @"https://ie.bjd.com.cn/images/202006/28/5ef8b80de4b01e7223d6283d_w300.jpeg",    @"https://ie.bjd.com.cn/images/202006/28/5ef8bbebe4b01e7223d62ca0_w300.jpeg",
        @"https://ie.bjd.com.cn/images/202006/28/5ef7f876e4b01e7223d43d71_w300.jpeg",       @"https://ie.bjd.com.cn/images/202006/28/5ef8973ee4b01e7223d5ea0f_w300.jpeg"
    ];
    self.cycleScrollView = [YJCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, ScreenW, 200*kWidthRatio) imageUrlsGroup:urlAray];
    self.cycleScrollView.isCycleLoop = YES;
    self.cycleScrollView.isShowPageControl = YES;
    self.cycleScrollView.isShowBannerTitle = YES;
    self.cycleScrollView.titlesGroup = @[@"北京市首辆核酸检测采样车开进北展广场~",
                                         @"通州新增两个核酸检测点！满足市民“愿检尽检”需求",
                                         @"石景山人才住房新政图解指南，请查收！",
                                         @"还好吗？还好！她是经开区社区防疫一线的“还好”姑娘"];
    [self.view addSubview:self.cycleScrollView];
    
    NSArray *titles = [self.childViewControllers valueForKey:@"title"];
    //点击切换视图
    self.segmentView = [[BDSegmentItemView alloc]initWithFrame:CGRectMake(0, self.cycleScrollView.bottom, ScreenW, 44*kWidthRatio) SegmentItems:titles];
    self.segmentView.delegate = self;
    [self.view addSubview:self.segmentView];
    
    // 选中第0个VC
    [self selectedIndex:0];

}
- (void)addChilds {
    [self addChildWithVC:[BDBJHListController new] title:@"推荐"];
    [self addChildWithVC:[BDBJHListController new] title:@"关注"];
    [self addChildWithVC:[BDBJHListController new] title:@"矩阵"];
}
- (void)addChildWithVC:(UIViewController *)vc title:(NSString *)title {
    vc.title = title;
    [self addChildViewController:vc];
}
- (void)selectedIndex:(NSInteger)index {
    BDBJHListController *VC = self.childViewControllers[index];
    if (!VC.view.superview) {
        VC.view.frame = CGRectMake(index * self.contentView.frame.size.width, 0, self.contentView.frame.size.width, self.contentView.frame.size.height-kStatusBarAndNavigationBarHeight-kTabbarHeight);
        [self.contentView addSubview:VC.view];
    }
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.frame.size.width, 0) animated:NO];
    _currentIndex = index;
}
#pragma mark segentDelegate
-(void)segmentBar:(BDSegmentItemView *)segmentBar tapIndex:(NSInteger)index{
    [self selectedIndex:index];
}

#pragma mark scrollview
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger i = offsetX / scrollView.frame.size.width;
    if (i == _currentIndex) return;
    [self selectedIndex:i];
    self.segmentView.changeIndex = i;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY>kStatusBarAndNavigationBarHeight){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
     }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

#pragma mark - XLStudyChildVCDelegate
- (void)childVc:(UIViewController *)childVc scrollViewDidScroll:(UIScrollView *)scroll {
    
    CGFloat offsetY = scroll.contentOffset.y;
    UIViewController *currentVC = self.childViewControllers[_currentIndex];
    if ([currentVC isEqual:childVc]) {
        
        CGRect headerFrame = self.cycleScrollView.frame;
        headerFrame.origin.y = -offsetY;
        // header上滑到导航条位置时，固定
        if (headerFrame.origin.y <= -200*kWidthRatio) {
            headerFrame.origin.y = -200*kWidthRatio;
        }else if (headerFrame.origin.y >= 0) {
            // header向下滑动时，固定
            headerFrame.origin.y = 0;
        }
        self.cycleScrollView.frame = headerFrame;
        
        CGRect barFrame = self.segmentView.frame;
        barFrame.origin.y = CGRectGetMaxY(self.cycleScrollView.frame);
        self.segmentView.frame = barFrame;
        
        // 改变其他VC中的scroll偏移
        [self.childViewControllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj isEqual:currentVC]) {
                [self addViewToSuperView:obj AtIndex:idx];
                [obj setCurrentScrollContentOffsetY:offsetY];
            }
        }];
    }
}
/*如果滑动  没有添加到 父视图*/
-(void)addViewToSuperView:(UIViewController*)VC AtIndex:(NSInteger)index{
    
    if (!VC.view.superview) {
        VC.view.frame = CGRectMake(index * self.contentView.frame.size.width, 0, self.contentView.frame.size.width, self.contentView.frame.size.height-kStatusBarAndNavigationBarHeight-kTabbarHeight);
        [self.contentView addSubview:VC.view];
    }
}



@end

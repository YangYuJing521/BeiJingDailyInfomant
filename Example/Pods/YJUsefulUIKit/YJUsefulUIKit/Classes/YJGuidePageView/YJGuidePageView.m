//
//  YJGuidePageView.m
//  Pods
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "YJGuidePageView.h"
NSString * const guidePageKey = @"GuidePageKey";
NSString * const currentGuidePageKey =@"CurrentGuidePageKey";
@implementation YJGuidePageView

-(void)show{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *oldVersion = [userDefaults stringForKey:guidePageKey];
    if ([oldVersion isEqualToString:[YJGuidePageView getGuidePageVersion]]) {
        return;
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
}
-(instancetype)init{
    return  [self initWithFrame:[UIScreen mainScreen].bounds];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        [self initialization];
        [self setSubViews];
    }
    return self;
}
-(void)initialization{
    self.guidePageVersion = @"1.0";
    self.moveRightDismiss = YES;
}
-(void)setSubViews{
    CGSize mainSize =self.bounds.size;
    mainScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.bounces = NO;
    mainScrollView.pagingEnabled = YES;
    mainScrollView.delegate = self;
    [self addSubview:mainScrollView];
        
    goHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goHomeBtn.frame = CGRectMake(mainSize.width*2+(mainSize.width-159)/2.0, mainSize.height*517/667.0, 159, 50); //517/667
    [goHomeBtn addTarget:self action:@selector(goHomePage) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:goHomeBtn];

    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(goHomeBtn.frame)+(mainSize.height-CGRectGetMaxY(goHomeBtn.frame))/2.0-15.0, mainSize.width, 30)];
    pageControl.numberOfPages = 1;
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 设置页码
    pageControl.currentPage = page;
    if (page==0) {
        mainScrollView.bounces = NO;
    }else if(_moveRightDismiss&&page == _imageArray.count-1){
        mainScrollView.bounces = YES;
    }
    if (scrollView.contentOffset.x>scrollView.contentSize.width - scrollView.frame.size.width) {
        [self goHomePage];
    }
}
-(void)goHomePage{
    [self removeFromSuperview];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_guidePageVersion forKey:guidePageKey];
    [userDefaults synchronize];
}
-(void)setUpContentView{
    CGSize mainSize =mainScrollView.bounds.size;
    mainScrollView.contentSize = CGSizeMake(mainSize.width*self.imageArray.count, mainSize.height);
    for(int i = 0;i<self.imageArray.count;i++){
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(mainSize.width*i, 0, mainSize.width, mainSize.height)];
        imgView.image = _imageArray[i];
        [mainScrollView addSubview:imgView];
    }
    pageControl.numberOfPages = self.imageArray.count;
    CGRect temFrame = goHomeBtn.frame;
    temFrame.origin.x = mainSize.width*(_imageArray.count-1)+(mainSize.width-temFrame.size.width)/2.0;
    goHomeBtn.frame = temFrame;
    [mainScrollView bringSubviewToFront:goHomeBtn];
}
#pragma mark property
-(void)setImageArray:(NSArray *)imageArray{
    _imageArray = [imageArray copy];
    [self setUpContentView];
}
-(void)setGuidePageVersion:(NSString *)guidePageVersion{
    _guidePageVersion = guidePageVersion;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:guidePageVersion forKey:currentGuidePageKey];
    [userDefaults synchronize];
}
+(NSString*)getGuidePageVersion{
    NSString *guidePageVersion = nil;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    guidePageVersion = [userDefaults objectForKey:currentGuidePageKey];
    return guidePageVersion;
}
-(void)setButtonTitle:(NSString *)buttonTitle{
    _buttonTitle = buttonTitle;
    [goHomeBtn setTitle:buttonTitle forState:UIControlStateNormal];
}
-(void)setButtonNomalImage:(UIImage *)buttonNomalImage{
    _buttonNomalImage = buttonNomalImage;
    [goHomeBtn setBackgroundImage:buttonNomalImage forState:UIControlStateNormal];
}
-(void)setButtonSelectedImage:(UIImage *)buttonSelectedImage{
    _buttonSelectedImage = buttonSelectedImage;
    [goHomeBtn setBackgroundImage:buttonSelectedImage forState:UIControlStateSelected];
}
-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}
-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}
@end

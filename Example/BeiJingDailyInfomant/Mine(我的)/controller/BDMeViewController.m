//
//  BDViewController.m
//  BeiJingDailyInfomant
//
//  Created by silverBullet on 06/20/2020.
//  Copyright (c) 2020 silverBullet. All rights reserved.
//

#import "BDMeViewController.h"
#import "BDMeHeadView.h"
#import "BDInfomantMainVC.h"
#import "BDMeTopFourCell.h"
#import "BDMeBaoLiaoReusableView.h"

static double const HEADHEIGHT = 80;
static NSString *const BDMeTopFourCellID = @"BDMeTopFourCellID";
static NSString *const BDMeBaoLiaoReusableViewID = @"BDMeBaoLiaoReusableViewID";

@interface BDMeViewController ()
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TemplateBaseCellCellDelegate,TemplateBaseReusableViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BDMeHeadView *personHeadView;
@end

@implementation BDMeViewController
{
    double topBackHeight; //头部高度
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    topBackHeight = (HEADHEIGHT + kStatusBarAndNavigationBarHeight)*kWidthRatio;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.collectionView.backgroundColor = HEXCOLOR(0xF3F5F7);
}

#pragma mark collectionView datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) return 4;
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YJTemplateBaseCell *gridCell = nil;
    if (indexPath.section == 0) {
        BDMeTopFourCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDMeTopFourCellID forIndexPath:indexPath];
        gridCell = cell;
    }
    gridCell.delegate = self;
    gridCell.indexPath = indexPath;
    return gridCell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    YJTemplateBaseReusableView *gridView = nil;
    if (indexPath.section==1) {
        BDMeBaoLiaoReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:BDMeBaoLiaoReusableViewID forIndexPath:indexPath];
        gridView = header;
    }
    gridView.delegate = self;
    gridView.indexPath = indexPath;
    return gridView;
}
//item
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ScreenW/4, 81 * kWidthRatio);
}
//head
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==1) return CGSizeMake(ScreenW, 98*kWidthRatio);
    return CGSizeZero;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark cell Delegate
-(void)contentViewDidClickWithType:(NSString *)type contentData:(id)contentData indexPath:(NSIndexPath *)indexPath index:(NSInteger)index{}

-(void)reuseableViewDidClickWithType:(NSString *)type contentData:(id)contentData indexPath:(NSIndexPath *)indexPath index:(NSInteger)index{
    [MGJRouter openURL:BAOLIAOROUTER withUserInfo:@{@"navigationVC" : self.navigationController,} completion:nil];
}

#pragma mark layout
//y
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//x
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 0, 10, 0);
}

#pragma mark 滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat xOffset = (yOffset + topBackHeight)/2;
    if (yOffset < -topBackHeight) {
        CGRect rect = _personHeadView.frame;
        rect.origin.y = yOffset;
        rect.size.height =  -yOffset ;
        rect.origin.x = xOffset;
        rect.size.width = ScreenW + fabs(xOffset)*2;
        _personHeadView.frame = rect;
        
        [_personHeadView.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self->_personHeadView.mas_bottom).offset(0);
            make.left.mas_equalTo((rect.size.width-ScreenW)/2);
            make.right.equalTo(self->_personHeadView.mas_right).mas_equalTo(-(rect.size.width-ScreenW)/2);
        }];
    }
}


#pragma mark lazy load
-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [UICollectionView addCollectionViewDelegate:self SupView:self.view];
        _collectionView.alwaysBounceVertical = YES;  // 垂直
        [_collectionView registerClass:[BDMeTopFourCell class] forCellWithReuseIdentifier:BDMeTopFourCellID];
        [_collectionView registerClass:[BDMeBaoLiaoReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:BDMeBaoLiaoReusableViewID];
        _collectionView.contentInset = UIEdgeInsetsMake(topBackHeight, 0, 0, 0);
        [_collectionView addSubview:self.personHeadView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view).offset(0);
            make.height.mas_equalTo(ScreenH-kTabbarHeight);
        }];
    }
    return _collectionView;
}

-(BDMeHeadView *)personHeadView{
    if (_personHeadView == nil) {
        _personHeadView = [[BDMeHeadView alloc] initWithFrame:CGRectMake(0, -topBackHeight, ScreenW, topBackHeight)];
    }
    return _personHeadView;
}

@end

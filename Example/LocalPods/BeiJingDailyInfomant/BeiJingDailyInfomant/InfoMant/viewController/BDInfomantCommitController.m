//
//  BDInfomantCommitController.m
//  AFNetworking
//
//  Created by 杨玉京 on 2020/6/25.
//

#import "BDInfomantCommitController.h"
#import "BDInfomantCommitTitleCell.h"
#import "BDConfigs.h"
static NSString *const BDInfomantCommitTitleCellID = @"BDInfomantCommitTitleCell";
static NSString *const BDInfomantCommitDesCellID = @"BDInfomantCommitDesCellID";
static NSString *const BDInfomantCommitPicCellID = @"BDInfomantCommitPicCellID";
static NSString *const BDInfomantSelectTopicCellID = @"BDInfomantSelectTopicCellID";
static NSString *const BDInfomantSelectTelePhoneCellID = @"BDInfomantSelectTelePhoneCellID";

@interface BDInfomantCommitController ()
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,UITextViewDelegate,TemplateBaseCellCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) UITextField *phoneField;
@end

@implementation BDInfomantCommitController
{
    CGFloat itemWH;  //item 宽高
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"爆料";
    itemWH = (ScreenW - 60*kWidthRatio) * 0.25;
    self.collectionView.backgroundColor = GMBGColor255;
}

-(void)setDataModel:(BaoLiaoTypeModel *)dataModel{
    _dataModel = dataModel;
    [self.collectionView reloadData];
}
#pragma mark collectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 2) return 5;
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YJTemplateBaseCell *gridCell = nil;
    if (indexPath.section == 0) {
        BDInfomantCommitTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDInfomantCommitTitleCellID forIndexPath:indexPath];
        cell.textField.delegate = self;
        self.textField = cell.textField;
        gridCell = cell;
    }
    if (indexPath.section==1) {
        BDInfomantCommitDesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDInfomantCommitDesCellID forIndexPath:indexPath];
        cell.textView.delegate = self;
        self.textView = cell.textView;
        gridCell = cell;
    }
    if (indexPath.section==2) {
        BDInfomantCommitPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDInfomantCommitPicCellID forIndexPath:indexPath];
        gridCell = cell;
    }
    if (indexPath.section==3) {
        BDInfomantSelectTopicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDInfomantSelectTopicCellID forIndexPath:indexPath];
        cell.model = self.dataModel;
        gridCell = cell;
    }
    if (indexPath.section==4) {
        BDInfomantSelectTelePhoneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDInfomantSelectTelePhoneCellID forIndexPath:indexPath];
        self.phoneField = cell.phoneField;
        gridCell = cell;
    }
    gridCell.delegate = self;
    gridCell.indexPath = indexPath;
    return gridCell;
}
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return CGSizeMake(ScreenW, 44 * kWidthRatio);
    if (indexPath.section == 1) return CGSizeMake(ScreenW, 180 * kWidthRatio);
    if (indexPath.section == 2) return CGSizeMake(itemWH, itemWH);
    if (indexPath.section == 3) return CGSizeMake(ScreenW, 44 * kWidthRatio);
    if (indexPath.section == 4) return CGSizeMake(ScreenW, 44 * kWidthRatio);
    return CGSizeZero;
}
//head
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        // 选择类型
        [MGJRouter openURL:BAOLIAOLISTROUTER withUserInfo:@{@"navigationVC" : self.navigationController,
        @"isFromCommit" : @1} completion:nil];
    }
}

#pragma mark cell delegate
-(void)contentViewDidClickWithType:(NSString *)type contentData:(id)contentData indexPath:(NSIndexPath *)indexPath index:(NSInteger)index{
    NSLog(@"%zd",index);
}

#pragma mark layout
//y
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 2) return  10*kWidthRatio;
    return 0;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 2) return UIEdgeInsetsMake(0, 15*kWidthRatio, 0, 15*kWidthRatio);
    if (section == 3) return UIEdgeInsetsMake(35*kWidthRatio, 0, 0, 0);
    return UIEdgeInsetsZero;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.textField resignFirstResponder];
    [self.textView resignFirstResponder];
    [self.phoneField resignFirstResponder];
}

#pragma mark uitextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark uitextview
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([TO_STR(textView.text) isEqualToString: @"详细描述（时间、地点、人物、事件）"]) {
        textView.text = @"";
        self.textView.textColor = GMBlackTextColor51;
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (TO_STR(textView.text).length == 0){
        self.textView.textColor = GMGrayTextColor153;
        self.textView.text =  @"详细描述（时间、地点、人物、事件）";
    }else{
        self.textView.textColor = GMBlackTextColor51;
    }
}

#pragma mark lazy load
-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowOut = [[UICollectionViewFlowLayout alloc] init];
        flowOut.minimumLineSpacing=0;
        flowOut.minimumInteritemSpacing=0;
        if (@available(iOS 9.0, *)) {
            flowOut.sectionHeadersPinToVisibleBounds = YES;
        }
        if (@available(iOS 11.0, *)) {
            flowOut.sectionInsetReference = UICollectionViewFlowLayoutSectionInsetFromSafeArea;
        }
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight, ScreenW, ScreenH-kStatusBarAndNavigationBarHeight-kTabbarSafeBottomMargin) collectionViewLayout:flowOut];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.alwaysBounceVertical=YES;
        [_collectionView registerClass:[BDInfomantCommitTitleCell class] forCellWithReuseIdentifier:BDInfomantCommitTitleCellID];
        [_collectionView registerClass:[BDInfomantCommitDesCell class] forCellWithReuseIdentifier:BDInfomantCommitDesCellID];
        [_collectionView registerClass:[BDInfomantCommitPicCell class] forCellWithReuseIdentifier:BDInfomantCommitPicCellID];
        [_collectionView registerClass:[BDInfomantSelectTopicCell class] forCellWithReuseIdentifier:BDInfomantSelectTopicCellID];
        [_collectionView registerClass:[BDInfomantSelectTelePhoneCell class] forCellWithReuseIdentifier:BDInfomantSelectTelePhoneCellID];
        [self.view addSubview:_collectionView];
        }
    return _collectionView;
}

-(UIButton *)rightBarButton{
    EazyClickButton *rightBtn = [EazyClickButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setTitleColor:GMRedTextColor238_50_40 forState:UIControlStateNormal];
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = PFR16Font;
    return rightBtn;
}

-(void)rightBarButtonItemClick{
    NSLog(@"%@",self.textField.text);
    NSLog(@"%@",self.textView.text);
    NSLog(@"%@",self.phoneField.text);
}
@end

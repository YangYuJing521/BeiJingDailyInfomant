//
//  BDInfomantCommitController.m
//  AFNetworking
//
//  Created by 杨玉京 on 2020/6/25.
//

#import "BDInfomantCommitController.h"
#import "BDInfomantCommitTitleCell.h"
#import "BDConfigs.h"
#import "TZImagePickerController.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "YJPodUtil.h"

static NSString *const BDInfomantCommitTitleCellID = @"BDInfomantCommitTitleCell";
static NSString *const BDInfomantCommitDesCellID = @"BDInfomantCommitDesCellID";
static NSString *const BDInfomantCommitPicCellID = @"BDInfomantCommitPicCellID";
static NSString *const BDInfomantSelectTopicCellID = @"BDInfomantSelectTopicCellID";
static NSString *const BDInfomantSelectTelePhoneCellID = @"BDInfomantSelectTelePhoneCellID";



@interface BDInfomantCommitController ()
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,UITextViewDelegate,TemplateBaseCellCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) UITextField *phoneField;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@end

#define MAXVIDEOINTERVAL 60   //选择视频的最大时长
#define MINVIDEOINTERVAL 10   //选择视频的最小时长

@implementation BDInfomantCommitController
{
    CGFloat itemWH;  //item 宽高
    NSMutableArray *_selectedPhotos;   //选中图片
    NSMutableArray *_selectedAssets;   //选中图片asset
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"爆料";
    itemWH = (ScreenW - 60*kWidthRatio) * 0.25;
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    self.collectionView.backgroundColor = GMBGColor255;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
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
    if (section == 2) {
        if (_selectedPhotos.count >= 9) { //最多添加9个
            return _selectedPhotos.count;
        }
        return _selectedPhotos.count + 1;
    }
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
        if (indexPath.item == _selectedPhotos.count) {
            cell.iconImage.image =  [UIImage imageNamed:@"add_pic_and_video" inBundle:[YJPodUtil bundleForPod:@"BeiJingDailyInfomant"] compatibleWithTraitCollection:nil];
            cell.delBtn.hidden=YES;
            cell.videoImage.hidden = YES;
        }else{
            cell.iconImage.image = _selectedPhotos[indexPath.item];
            cell.delBtn.hidden= NO;
            cell.asset = _selectedAssets[indexPath.item];
        }
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
            if (indexPath.item == _selectedPhotos.count) {
                NSString *takePhotoTitle = @"相机";
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:takePhotoTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self takePhoto];
                }];
                [alertVc addAction:takePhotoAction];
                UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self pushTZImagePickerController];
                }];
                [alertVc addAction:imagePickerAction];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alertVc addAction:cancelAction];
                UIPopoverPresentationController *popover = alertVc.popoverPresentationController;
                UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
                if (popover) {
                    popover.sourceView = cell;
                    popover.sourceRect = cell.bounds;
                    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
                }
                [self presentViewController:alertVc animated:YES completion:nil];
                
            } else { // preview photos or video / 预览照片或者视频
            PHAsset *asset = _selectedAssets[indexPath.item];
            BOOL isVideo = NO;
            isVideo = asset.mediaType == PHAssetMediaTypeVideo;
            if (isVideo) { // perview video / 预览视频
                TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
                TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
                vc.model = model;
                vc.modalPresentationStyle = UIModalPresentationFullScreen;
                [self presentViewController:vc animated:YES completion:nil];
            } else { // preview photos / 预览照片
                TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.item];
                imagePickerVc.maxImagesCount = 9;
                imagePickerVc.allowPickingGif = NO;
                imagePickerVc.allowPickingOriginalPhoto = NO;
                imagePickerVc.allowPickingMultipleVideo = YES;
                imagePickerVc.showSelectedIndex = YES;
//                imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
                imagePickerVc.videoMaximumDuration = MAXVIDEOINTERVAL;
                imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
                [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                    self->_selectedPhotos = [NSMutableArray arrayWithArray:photos];
                    self->_selectedAssets = [NSMutableArray arrayWithArray:assets];
//                    self->_isSelectOriginalPhoto = isSelectOriginalPhoto;
                    [self->_collectionView reloadData];
                    self->_collectionView.contentSize = CGSizeMake(0, ((self->_selectedPhotos.count + 2) / 3 ) * (4 + (ScreenW - 2 * 4 - 4) / 3 - 4));
                }];
                [self presentViewController:imagePickerVc animated:YES completion:nil];
            }
        }
    }
    if (indexPath.section==3) {
        // 选择类型
        [MGJRouter openURL:BAOLIAOLISTROUTER withUserInfo:@{@"navigationVC" : self.navigationController,
        @"isFromCommit" : @1} completion:nil];
    }
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

#pragma mark cell delegate
-(void)contentViewDidClickWithType:(NSString *)type contentData:(id)contentData indexPath:(NSIndexPath *)indexPath index:(NSInteger)index{

    if ([self collectionView:self.collectionView numberOfItemsInSection:2] <= _selectedPhotos.count) {
        [_selectedPhotos removeObjectAtIndex:index];
        [_selectedAssets removeObjectAtIndex:index];
        [self.collectionView reloadData];
        return;
    }
    
    [_selectedPhotos removeObjectAtIndex:index];
    [_selectedAssets removeObjectAtIndex:index];
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:2];
        [self->_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self->_collectionView reloadData];
    }];

//    NSLog(@"%zd",index);
}

#pragma mark - TZImagePickerController
- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:9 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.barItemTextColor = [UIColor blackColor];
    // [imagePickerVc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    // imagePickerVc.navigationBar.tintColor = [UIColor blackColor];
    // imagePickerVc.naviBgColor = [UIColor whiteColor];
    // imagePickerVc.navigationBar.translucent = NO;
//    imagePickerVc.delegate = self;
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = NO;
    // 1.设置目前已经选中的图片数组
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
    imagePickerVc.videoMaximumDuration = 60; // 视频最大拍摄时间
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    // imagePickerVc.photoWidth = 1600;
    // imagePickerVc.photoPreviewMaxWidth = 1600;
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    /*
    [imagePickerVc setAssetCellDidSetModelBlock:^(TZAssetCell *cell, UIImageView *imageView, UIImageView *selectImageView, UILabel *indexLabel, UIView *bottomView, UILabel *timeLength, UIImageView *videoImgView) {
        cell.contentView.clipsToBounds = YES;
        cell.contentView.layer.cornerRadius = cell.contentView.tz_width * 0.5;
    }];
     */
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = YES; // 是否可以多选视频
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.needCircleCrop = NO;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = ScreenW - 2 * left;
    NSInteger top = (ScreenW - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.scaleAspectFillCrop = YES;
    // 设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake((self.view.tz_height - widthHeight) / 2, left, widthHeight, widthHeight);
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
    // 自定义导航栏上的返回按钮
    /*
    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
        [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
    }];
    imagePickerVc.delegate = self;
    */
    
    // Deprecated, Use statusBarStyle
    // imagePickerVc.isStatusBarDefault = NO;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = YES;
    // 设置拍照时是否需要定位，仅对选择器内部拍照有效，外部拍照的，请拷贝demo时手动把pushImagePickerController里定位方法的调用删掉
    imagePickerVc.allowCameraLocation = YES;
    
    // 自定义gif播放方案
//    [[TZImagePickerConfig sharedInstance] setGifImagePlayBlock:^(TZPhotoPreviewView *view, UIImageView *imageView, NSData *gifData, NSDictionary *info) {
//        FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:gifData];
//        FLAnimatedImageView *animatedImageView;
//        for (UIView *subview in imageView.subviews) {
//            if ([subview isKindOfClass:[FLAnimatedImageView class]]) {
//                animatedImageView = (FLAnimatedImageView *)subview;
//                animatedImageView.frame = imageView.bounds;
//                animatedImageView.animatedImage = nil;
//            }
//        }
//        if (!animatedImageView) {
//            animatedImageView = [[FLAnimatedImageView alloc] initWithFrame:imageView.bounds];
//            animatedImageView.runLoopMode = NSDefaultRunLoopMode;
//            [imageView addSubview:animatedImageView];
//        }
//        animatedImageView.animatedImage = animatedImage;
//    }];
    
    // 设置首选语言 / Set preferred language
    imagePickerVc.preferredLanguage = @"zh-Hans";
    // 设置languageBundle以使用其它语言 / Set languageBundle to use other language
    // imagePickerVc.languageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"tz-ru" ofType:@"lproj"]];
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {

    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


#pragma mark UIImagePickController
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        [mediaTypes addObject:(NSString *)kUTTypeMovie];
        [mediaTypes addObject:(NSString *)kUTTypeImage];
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    tzImagePickerVc.sortAscendingByModificationDate = YES;
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSDictionary *meta = [info objectForKey:UIImagePickerControllerMediaMetadata];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image meta:meta location:self.location completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                NSLog(@"图片保存失败 %@",error);
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
//                if (self.allowCropSwitch.isOn) { // 允许裁剪,去裁剪
//                    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
//                        [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
//                    }];
//                    imagePicker.allowPickingImage = YES;
//                    imagePicker.needCircleCrop = self.needCircleCropSwitch.isOn;
//                    imagePicker.circleCropRadius = 100;
//                    [self presentViewController:imagePicker animated:YES completion:nil];
//                } else {
                    [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
//                }
            }
        }];
    } else if ([type isEqualToString:@"public.movie"]) {
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoUrl) {
            [[TZImageManager manager] saveVideoWithUrl:videoUrl location:self.location completion:^(PHAsset *asset, NSError *error) {
                [tzImagePickerVc hideProgressHUD];
                if (!error) {
                    TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        if (!isDegraded && photo) {
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:photo];
                        }
                    }];
                }
            }];
        }
    }
}

- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [_collectionView reloadData];
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        NSLog(@"location:%@",phAsset.location);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}
// The picker should dismiss itself; when it dismissed these handle will be called.
// You can also set autoDismiss to NO, then the picker don't dismiss itself.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 你也可以设置autoDismiss属性为NO，选择器就不会自己dismis了
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
//    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    // 1.打印图片名字
    [self printAssetsName:assets];
    // 2.图片位置信息
    for (PHAsset *phAsset in assets) {
        NSLog(@"location:%@",phAsset.location);
    }
    
    // 3. 获取原图的示例，用队列限制最大并发为1，避免内存暴增
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.operationQueue.maxConcurrentOperationCount = 2;
    for (NSInteger i = 0; i < assets.count; i++) {
        PHAsset *asset = assets[i];
        // 图片上传operation，上传代码请写到operation内的start方法里，内有注释
//        TZImageUploadOperation *operation = [[TZImageUploadOperation alloc] initWithAsset:asset completion:^(UIImage * photo, NSDictionary *info, BOOL isDegraded) {
//            if (isDegraded) return;
//            NSLog(@"图片获取&上传完成");
//        } progressHandler:^(double progress, NSError * _Nonnull error, BOOL * _Nonnull stop, NSDictionary * _Nonnull info) {
//            NSLog(@"获取原图进度 %f", progress);
//        }];
//        [self.operationQueue addOperation:operation];
    }
}

// If user picking a video and allowPickingMultipleVideo is NO, this callback will be called.
// If allowPickingMultipleVideo is YES, will call imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
// 如果用户选择了一个视频且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    // open this code to send video / 打开这段代码发送视频
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPresetLowQuality success:^(NSString *outputPath) {
        // NSData *data = [NSData dataWithContentsOfFile:outputPath];
        NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        // Export completed, send video here, send by outputPath or NSData
        // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    } failure:^(NSString *errorMessage, NSError *error) {
        NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
    }];
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

// If user picking a gif image and allowPickingMultipleVideo is NO, this callback will be called.
// If allowPickingMultipleVideo is YES, will call imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
// 如果用户选择了一个gif图片且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(PHAsset *)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[animatedImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [_collectionView reloadData];
}

// Decide album show or not't
// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(PHFetchResult *)result {
    /*
    if ([albumName isEqualToString:@"个人收藏"]) {
        return NO;
    }
    if ([albumName isEqualToString:@"视频"]) {
        return NO;
    }*/
    return YES;
}

// Decide asset show or not't
// 决定asset显示与否
- (BOOL)isAssetCanSelect:(PHAsset *)asset {
    
    switch (asset.mediaType) {
        case PHAssetMediaTypeVideo: {
            // 视频时长
            NSTimeInterval duration = asset.duration;
            if (duration > MAXVIDEOINTERVAL || duration < MINVIDEOINTERVAL) return NO;
            return YES;
        } break;
        case PHAssetMediaTypeImage: {
            // 图片尺寸
//            if (asset.pixelWidth > 3000 || asset.pixelHeight > 3000) {
//               return NO;
//            }
            return YES;
        } break;
        case PHAssetMediaTypeAudio:
            return NO;
            break;
        case PHAssetMediaTypeUnknown:
            return NO;
            break;
        default: break;
    }
}
#pragma mark private
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

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (PHAsset *asset in assets) {
        fileName = [asset valueForKey:@"filename"];
        NSLog(@"图片名字:%@",fileName);
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

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        _imagePickerVc.videoMaximumDuration = MAXVIDEOINTERVAL;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}
@end

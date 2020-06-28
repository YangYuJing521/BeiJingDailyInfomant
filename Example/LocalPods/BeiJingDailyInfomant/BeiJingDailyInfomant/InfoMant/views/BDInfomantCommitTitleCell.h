//
//  BDInfomantCommitTitleCell.h
//  BeiJingDailyInfomant
//
//  Created by 杨玉京 on 2020/6/25.
//

#import <YJUsefulUIKit/YJUsefulUIKit.h>
#import "BaoLiaoTypeModel.h"
NS_ASSUME_NONNULL_BEGIN

// title
@interface BDInfomantCommitTitleCell : YJTemplateBaseCell
@property (nonatomic, strong) UITextField *textField;
@end


// 描述
@interface BDInfomantCommitDesCell : YJTemplateBaseCell
@property (nonatomic, strong) UITextView *textView;
@end

// 添加视频图片
@interface BDInfomantCommitPicCell : YJTemplateBaseCell
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIImageView *delBtn;
@property (nonatomic, strong) UIImageView *videoImage;
@property (nonatomic, strong) id asset;
@end

// 选择话题
@interface BDInfomantSelectTopicCell : YJTemplateBaseCell
@property (nonatomic, strong) UILabel *topicLabel;
@property (nonatomic, strong) BaoLiaoTypeModel *model;
@end

// 电话号码
@interface BDInfomantSelectTelePhoneCell : YJTemplateBaseCell
@property (nonatomic, strong) UITextField *phoneField;
@end
NS_ASSUME_NONNULL_END

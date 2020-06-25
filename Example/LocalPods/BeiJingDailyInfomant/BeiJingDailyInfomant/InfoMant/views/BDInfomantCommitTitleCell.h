//
//  BDInfomantCommitTitleCell.h
//  BeiJingDailyInfomant
//
//  Created by 杨玉京 on 2020/6/25.
//

#import <YJUsefulUIKit/YJUsefulUIKit.h>

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

@end
NS_ASSUME_NONNULL_END

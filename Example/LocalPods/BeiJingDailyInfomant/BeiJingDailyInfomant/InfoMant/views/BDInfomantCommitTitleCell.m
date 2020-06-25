//
//  BDInfomantCommitTitleCell.m
//  BeiJingDailyInfomant
//
//  Created by 杨玉京 on 2020/6/25.
//

#import "BDInfomantCommitTitleCell.h"

@implementation BDInfomantCommitTitleCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, ScreenW-30, 44*kWidthRatio)];
    [self addSubview:self.textField];
    self.textField.textColor = GMBlackTextColor51;
    self.textField.font = PFR16Font;
    self.textField.textAlignment = NSTextAlignmentLeft;
    self.textField.borderStyle = UITextBorderStyleNone;
    NSDictionary *attDic = @{
                             NSForegroundColorAttributeName:GMGrayTextColor153,
                             NSFontAttributeName:PFRFont(18)
                             };
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"标题（30字以内）" attributes:attDic];
    self.textField.attributedPlaceholder = attr;
    self.textField.clearsOnBeginEditing = NO;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.clearButtonMode = UITextFieldViewModeNever;
    self.textField.keyboardType = UIKeyboardTypeDefault;
    
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(15, 43.5*kWidthRatio, ScreenW-30, 0.5*kWidthRatio)];
    sepLine.backgroundColor = GMBGSepLineColor;
    [self addSubview:sepLine];
}
@end


@implementation BDInfomantCommitDesCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 5*kWidthRatio, ScreenW-30, 175*kWidthRatio)];
    [self addSubview:self.textView];
    self.textView.returnKeyType= UIReturnKeyDefault;
    self.textView.textColor = GMGrayTextColor153;
    self.textView.font = PFR15Font;
    self.textView.text = @"详细描述（时间、地点、人物、事件）";
}
@end

//------//
@interface BDInfomantCommitPicCell()
@property (nonatomic, strong) UIImageView *iconImage;
@end
@implementation BDInfomantCommitPicCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        WEAKSELF
//        self.iconImage = [UIImageView addImageViewImageStr:@"add_pic_and_video" tapAction:^(UIImageView *image) {
//            if ([weakSelf.delegate respondsToSelector:@selector(contentViewDidClickWithType:contentData:indexPath:index:)]) {
//                [weakSelf.delegate contentViewDidClickWithType:@"" contentData:nil indexPath:weakSelf.indexPath index:weakSelf.indexPath.item];
//            }
//        }];
        self.iconImage = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"icon_topic_title"];
        self.iconImage.image = image;
//        self.iconImage.backgroundColor = [UIColor blackColor];
        self.iconImage.userInteractionEnabled = YES;
        [self addSubview:self.iconImage];
        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end

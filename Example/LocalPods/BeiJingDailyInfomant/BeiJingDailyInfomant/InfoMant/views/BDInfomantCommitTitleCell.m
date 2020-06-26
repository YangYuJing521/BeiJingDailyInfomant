//
//  BDInfomantCommitTitleCell.m
//  BeiJingDailyInfomant
//
//  Created by 杨玉京 on 2020/6/25.
//

#import "BDInfomantCommitTitleCell.h"
#import "YJPodUtil.h"
// ------------------  title  ------------------
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
    self.textField.font = PFR18Font;
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


// ------------------  描述  ------------------
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
    self.textView.text =  @"详细描述（时间、地点、人物、事件）";
}
@end

// ------------------  添加视频图片  ------------------
@interface BDInfomantCommitPicCell()
@property (nonatomic, strong) UIImageView *iconImage;
@end
@implementation BDInfomantCommitPicCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.iconImage = [[UIImageView alloc] init];
        UIImage *image2 = [UIImage imageNamed:@"add_pic_and_video" inBundle:[YJPodUtil bundleForPod:@"BeiJingDailyInfomant"] compatibleWithTraitCollection:nil];
        self.iconImage.image = image2;
        self.iconImage.userInteractionEnabled = YES;
        [self addSubview:self.iconImage];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectPictureOrVideo)];
        [self.iconImage addGestureRecognizer:tap];
        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}
-(void)SelectPictureOrVideo{
    if ([self.delegate respondsToSelector:@selector(contentViewDidClickWithType:contentData:indexPath:index:)]) {
        [self.delegate contentViewDidClickWithType:@"" contentData:nil indexPath:self.indexPath index:self.indexPath.item];
    }
}

@end



// ------------------   选择话题  ------------------
@implementation BDInfomantSelectTopicCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(15, 0, ScreenW-30, 0.5*kWidthRatio)];
        sep.backgroundColor = GMBGSepLineColor;
        [self addSubview:sep];
        
        UILabel *topic = [UILabel addLabelWithtitle:@"话题" titleColor:GMBlackTextColor51 font:PFR16Font];
        [self addSubview:topic];
        [topic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self);
            make.width.mas_greaterThanOrEqualTo(40);
            make.height.mas_greaterThanOrEqualTo(16);
        }];
        
        self.topicLabel = [[UILabel alloc] init];
        [self addSubview:self.topicLabel];
        self.topicLabel.textAlignment = NSTextAlignmentRight;
        [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-15);
            make.centerY.mas_equalTo(self);
            make.width.mas_greaterThanOrEqualTo(200);
            make.height.mas_greaterThanOrEqualTo(16);
        }];
        
        UIView *sep2 = [[UIView alloc] initWithFrame:CGRectMake(15, 43.5*kWidthRatio, ScreenW-30, 0.5*kWidthRatio)];
        sep2.backgroundColor = GMBGSepLineColor;
        [self addSubview:sep2];
    }
    return self;
}
-(void)setModel:(BaoLiaoTypeModel *)model{
    _model = model;
    NSString *str = [NSString stringWithFormat:@" %@ >",model.title];
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:str];
    NSDictionary *attdic = @{
        NSFontAttributeName:PFR16Font,
        NSForegroundColorAttributeName:GMBlackTextColor51
    };
    [attstr addAttributes:attdic range:NSMakeRange(0, str.length)];
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
       attach.image = [UIImage imageNamed:@"icon_topic_title"];
       attach.bounds = CGRectMake(0, 0, 12, 14);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    [attstr insertAttributedString:attachString atIndex:0];
    self.topicLabel.attributedText = attstr;
}

@end



// ------------------  电话号码  ------------------
@implementation BDInfomantSelectTelePhoneCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *topic = [UILabel addLabelWithtitle:@"手机号" titleColor:GMBlackTextColor51 font:PFR16Font];
        [self addSubview:topic];
        [topic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self);
            make.width.mas_greaterThanOrEqualTo(50);
            make.height.mas_greaterThanOrEqualTo(16);
        }];
        
        self.phoneField = [[UITextField alloc] init];
        [self addSubview:self.phoneField];
        self.phoneField.textColor = GMBlackTextColor51;
        self.phoneField.font = PFR16Font;
        self.phoneField.textAlignment = NSTextAlignmentRight;
        self.phoneField.borderStyle = UITextBorderStyleNone;
        NSDictionary *attDic = @{
                                 NSForegroundColorAttributeName:GMGrayTextColor153,
                                 NSFontAttributeName:PFR16Font
                                 };
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"仅用于工作人员联系您" attributes:attDic];
        self.phoneField.attributedPlaceholder = attr;
        self.phoneField.clearsOnBeginEditing = NO;
        self.phoneField.returnKeyType = UIReturnKeyDone;
        self.phoneField.clearButtonMode = UITextFieldViewModeNever;
        self.phoneField.keyboardType = UIKeyboardTypeDefault;
        [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-15);
            make.centerY.mas_equalTo(self);
            make.width.mas_greaterThanOrEqualTo(200);
            make.height.mas_greaterThanOrEqualTo(16);
        }];
        UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(15, 43.5*kWidthRatio, ScreenW-30, 0.5*kWidthRatio)];
        sep.backgroundColor = GMBGSepLineColor;
        [self addSubview:sep];
    }
    return self;
}

@end

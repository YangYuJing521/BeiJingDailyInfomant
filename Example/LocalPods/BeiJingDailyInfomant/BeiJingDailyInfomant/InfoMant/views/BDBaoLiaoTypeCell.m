//
//  BDBaoLiaoTypeCell.m
//  BeiJingDailyInfomant
//
//  Created by 杨玉京 on 2020/6/25.
//

#import "BDBaoLiaoTypeCell.h"
@interface BDBaoLiaoTypeCell()
@property (nonatomic, strong) UILabel *titleLabel;  //title
@property (nonatomic, strong) UILabel *desLabel;  //描述
@property (nonatomic, strong) UILabel *participateLabel;  //人数
@property (nonatomic, strong) UILabel *goNowLabel;   //立刻爆料
@property (nonatomic, strong) UIView *sepLine;
@end

@implementation BDBaoLiaoTypeCell

+(BDBaoLiaoTypeCell *)cellWithTableView:(UITableView *)tableView identifier:(nonnull NSString *)ID{
    BDBaoLiaoTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BDBaoLiaoTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = GMBGColor255;
        [self configUI];
    }
    return  self;
}

-(void)configUI{
    //12 14
    self.titleLabel = [UILabel addLabelWithtitle:@"" titleColor:GMBlackTextColor51 font:PFR18Font];
    [self.contentView addSubview:self.titleLabel];
    
    self.desLabel = [UILabel addLabelWithtitle:@"" titleColor:GMGrayTextColor102 font:PFR14Font];
    self.desLabel.numberOfLines = 0;
    [self.contentView addSubview:self.desLabel];
    
    self.participateLabel = [UILabel addLabelWithtitle:@"" titleColor:GMGrayTextColor153 font:PFR12Font];
    [self.contentView addSubview:self.participateLabel];
    
    self.goNowLabel = [UILabel addLabelWithtitle:@"立刻爆料" titleColor:[UIColor blueColor] font:PFR14Font];
    self.goNowLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.goNowLabel];
    
    self.sepLine = [[UIView alloc] init];
    self.sepLine.backgroundColor = GMBGSepLineColor;
    [self.contentView addSubview: self.sepLine];
    
    //自动布局
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.height.mas_greaterThanOrEqualTo(@18);
        make.width.lessThanOrEqualTo(@(ScreenW-30));
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.width.lessThanOrEqualTo(@(ScreenW-30));
        make.height.mas_greaterThanOrEqualTo(14);
    }];
    
    [self.participateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.desLabel.mas_bottom).offset(10);
        make.height.greaterThanOrEqualTo(@11);
        make.width.lessThanOrEqualTo(@(ScreenW-30));
    }];
    
    [self.goNowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.equalTo(self.participateLabel.mas_top);
        make.height.greaterThanOrEqualTo(@14);
        make.width.lessThanOrEqualTo(@(ScreenW-30));
    }];
    
    [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.participateLabel.mas_bottom).offset(15);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.mas_equalTo(self.sepLine.mas_bottom);
    }];

}

-(void)setModel:(BaoLiaoTypeModel *)model{
    _model = model;
    //title
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:model.title];
    NSDictionary *attdic = @{
        NSFontAttributeName:PFR18Font,
        NSForegroundColorAttributeName:GMBlackTextColor51
    };
    [attstr addAttributes:attdic range:NSMakeRange(0, model.title.length)];
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
       attach.image = [UIImage imageNamed:@"icon_topic_title"];
       attach.bounds = CGRectMake(0, 0, 12, 14);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    [attstr insertAttributedString:attachString atIndex:0];
    self.titleLabel.attributedText = attstr;
    //详情
    self.desLabel.text = model.remark;
    //参与
    self.participateLabel.text = [NSString stringWithFormat:@"\( %zd人参与 \)",model.virtualCount];
}
@end

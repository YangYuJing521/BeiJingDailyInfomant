//
//  BDBJHNewsCell.m
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/29.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "BDBJHNewsCell.h"
#import "UIImageView+WebCache.h"
#import "YJFilterTool.h"
@interface BDBJHNewsCell()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *sepLine;
@end
@implementation BDBJHNewsCell
+(BDBJHNewsCell *)cellWithTableView:(UITableView *)tableView identifier:(nonnull NSString *)ID{
    BDBJHNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BDBJHNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    self.titleLabel = [UILabel addLabelWithtitle:@"高扬的旗帜：不畏艰险，冲锋在前，战疫“火线”光荣入党！" titleColor:GMBlackTextColor51 font:PFR16Font];
    self.titleLabel.numberOfLines=2;
    [self addSubview:self.titleLabel];
    
    self.icon = [[UIImageView alloc] init];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[YJFilterTool filterImageUrl:@"https://ie.bjd.com.cn/images/202006/28/5ef8b9c0e4b01e7223d62a35_w400.jpeg"]]];
    [self addSubview:self.icon];
    
    self.sourceLabel = [UILabel addLabelWithtitle:@"北京房山官方发布" titleColor:GMGrayTextColor102 font:PFR12Font];
    [self addSubview:self.sourceLabel];
    
    self.timeLabel = [UILabel addLabelWithtitle:@"1小时前" titleColor:GMGrayTextColor102 font:PFR12Font];
    [self addSubview:self.timeLabel];
    
    self.sepLine = [[UIView alloc] init];
    self.sepLine.backgroundColor = GMBGSepLineColor;
    [self addSubview:self.sepLine];
    
    //布局
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(100*kWidthRatio);
        make.width.mas_equalTo(150*kWidthRatio);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.right.mas_equalTo(self.icon.mas_left).offset(-10);
        make.height.mas_greaterThanOrEqualTo(16);
    }];
    
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.mas_greaterThanOrEqualTo(12);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(self.titleLabel);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.sourceLabel);
        make.width.mas_lessThanOrEqualTo(150);
        make.height.mas_greaterThanOrEqualTo(12);
    }];
    
    [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(0.5*kWidthRatio);
    }];
}



@end

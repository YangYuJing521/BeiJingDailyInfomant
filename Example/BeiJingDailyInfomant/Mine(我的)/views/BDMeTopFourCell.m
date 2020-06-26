//
//  BDMeTopFourCell.m
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/23.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "BDMeTopFourCell.h"

@interface BDMeTopFourCell()
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation BDMeTopFourCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = GMBGColor255;
        [self configUi];
    }
    return self;
}

-(void)configUi{
    _iconImage = [UIImageView addImageViewWithImageName:@"all_order"];
    [self.contentView addSubview:_iconImage];
    
    _titleLabel = [UILabel addLabelWithtitle:@"功能入口" titleColor:GMBlackTextColor51 font:PFRFont(12)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-7.5*kWidthRatio);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_equalTo(@(17 * kWidthRatio));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15*kWidthRatio);
    }];
}

@end

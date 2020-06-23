//
//  BDMeHeadView.m
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "BDMeHeadView.h"
@interface BDMeHeadView()
@property (nonatomic, strong) UIImageView *avatar; //头像
@property (nonatomic, strong) UILabel *nickName;   //昵称
@end

static NSInteger const AVATARWH = 66;
@implementation BDMeHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self configUIWithFrame:frame];
    }
    return self;
}

-(void)configUIWithFrame:(CGRect)frame{
    self.image = [UIImage imageNamed:@"MineHeader"];
    double avatarTop = (frame.size.height - AVATARWH*kWidthRatio) * 0.5;
    
    //视图容器
    _contentView = [UIView new];
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(frame.size.height);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    
    //头像
    _avatar = [UIImageView addImageViewWithImageName:@"mine_adavator"];
    [_contentView addSubview:_avatar];
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@25);
        make.width.height.mas_equalTo(@(AVATARWH * kWidthRatio));
        make.top.mas_equalTo(@(avatarTop));
    }];
    _avatar.layer.cornerRadius = AVATARWH * 0.5;
    _avatar.layer.masksToBounds = YES;
    
    //昵称
    _nickName = [UILabel addLabelWithtitle:@"YangYuJing" titleColor:GMBGColor255 font:PFRFont(20)];
    [_contentView addSubview:_nickName];
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatar.mas_right).offset(10);
        make.centerY.mas_equalTo(_avatar.centerY);
        make.height.mas_greaterThanOrEqualTo(@20);
    }];
}
@end

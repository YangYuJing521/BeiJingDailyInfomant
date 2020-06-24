//
//  BDMeBaoLiaoReusableView.m
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/23.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "BDMeBaoLiaoReusableView.h"

@interface BDMeBaoLiaoReusableView()
@property (nonatomic, strong) UIImageView *iconImage;
@end

@implementation BDMeBaoLiaoReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    WEAKSELF
    _iconImage = [UIImageView addImageViewImageStr:@"enter_img" tapAction:^(UIImageView *image) {
        if ([weakSelf.delegate respondsToSelector:@selector(reuseableViewDidClickWithType:contentData:indexPath:index:)]) {
            [self.delegate reuseableViewDidClickWithType:@"" contentData:nil indexPath:self.indexPath index:self.indexPath.section];
        }
    }];
    [self addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
@end

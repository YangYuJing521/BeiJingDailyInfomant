//
//  UIImageView+Extension.m
//  借钱花花
//
//  Created by Meiyue on 15/12/16.
//  Copyright © 2015年 abc. All rights reserved.
//

#import "UIImageView+Extension.h"

#pragma mark 内部类 MYExImageView
@interface MYExImageView : UIImageView
@property (copy,nonatomic) void (^action)(UIImageView *image);

@end

@implementation MYExImageView
#pragma mark 点击事件
- (void)tapImageBtnClick{
    if (self.action) {
        self.action(self);
    }
}
#pragma mark 初始化
- (instancetype)init{
    if (self = [super init]) {
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageBtnClick)];
        [self addGestureRecognizer:tapGes];
    }
    return self;
}
@end


@implementation UIImageView (MYExImageView)

+ (instancetype )addImageViewWithImageName:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.userInteractionEnabled = YES;
    return imageView;
}

+ (instancetype)addImageViewImageStr:(NSString *)imageStr
                           tapAction: ( void(^)(UIImageView *image))tapAction{
    MYExImageView *image = [[MYExImageView alloc] init];
    image.image = [UIImage imageNamed:imageStr];
    image.action = tapAction;
    image.userInteractionEnabled = YES;
    return image;
}

+ (instancetype)addCornerImageViewWithImageStr:(NSString *)imageStr
                               tapAction:( void(^)(UIImageView *image))tapAction{
    
    MYExImageView *image = [self addImageViewImageStr:imageStr tapAction:tapAction];
    image.clipsToBounds = YES;
    image.layer.masksToBounds = YES;
    return image;
}



@end

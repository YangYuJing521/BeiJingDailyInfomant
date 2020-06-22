//
//  UIImageView+Extension.h
//  借钱花花
//
//  Created by Meiyue on 15/12/16.
//  Copyright © 2015年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MYExtension)

/**
 *  创建 UIImageView
 *
 *  @param imageName 图片名字(图片在项目中)
 */
+ (instancetype )addImageViewWithImageName:(NSString *)imageName;

/**
 *  创建 UIImageView
 *
 *  @param imageStr  图片名字(图片在项目中)
 *  @param tapAction 单击回调
 */
+ (instancetype)addImageViewImageStr:(NSString *)imageStr
                            tapAction: ( void(^)(UIImageView *image))tapAction;


/**
 创建含有圆角的

 @param imageStr 图片名字
 @param tapAction 点击事件
 @return 视图
 */
+ (instancetype)addCornerImageViewWithImageStr:(NSString *)imageStr
                                     tapAction:( void(^)(UIImageView *image))tapAction;
@end

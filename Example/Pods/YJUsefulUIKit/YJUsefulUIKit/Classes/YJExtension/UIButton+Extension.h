//
//  UIButton+Extension.h
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <UIKit/UIKit.h>

/*button按钮点击*/
typedef void(^TapButtonActionBlock) (UIButton *button) ;

@interface MYExButton : UIButton
/*点击block*/
@property (copy, nonatomic) TapButtonActionBlock action;
@end

@interface MYExFrameButton : MYExButton
-(instancetype)initWithFrame:(CGRect)frame andTitleFrame:(CGRect)titleFrame andImageFrame:(CGRect)imageFrame;
@end

@interface UIButton (MYExtension)

/**
 普通按钮只含有文字

 @param title 标题
 @param backgroundColor 背景色
 @param titleColor 文本颜色
 @param tapAction 点击事件
 @return 返回值
 */
+ (instancetype)addCustomButtonTitle:(NSString *)title  font:(UIFont *)font
                     backgroundColor:(UIColor *)backgroundColor
                          titleColor:(UIColor *)titleColor
                           tapAction:(TapButtonActionBlock)tapAction;


/**
 创建文本 图片都有的

 @param title 文本
 @param titleColor 文本颜色
 @param font 字体大小
 @param image 图片
 @param highImage 选中图片
 @param backgroundColor 背景色
 @param tapAction 点击事件
 @return 返回
 */
+ (instancetype)addButtonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font
                             image:(NSString *)image
                         highImage:(NSString *)highImage
                   backgroundColor:(UIColor *)backgroundColor
                         tapAction:(TapButtonActionBlock)tapAction;

/**
 
创建 含有圆角的
 @param title 标题
 @param font 字体大小
 @param backgroundColor 背景色
 @param titleColor 文本颜色
 @param tapAction 点击事件
 @return 返回值
 */
+ (instancetype)addRadiuButtonWithTitle:(NSString *)title
                                   font:(UIFont *)font
                        backgroundColor:(UIColor *)backgroundColor
                             titleColor:(UIColor *)titleColor
                              tapAction:(TapButtonActionBlock)tapAction;




/**
 创建可设置文本 图片frame
 
 @param frame frame
 @param title 文本
 @param titleFrame 文本frame
 @param titleColor 文本颜色
 @param font 字体大小
 @param image 图片
 @param highImage 选中图片
 @param imageFrame 图片frame
 @param backgroundColor 背景色
 @param tapAction 点击事件
 @return 返回
 */
+ (instancetype)addButtonWithframe:(CGRect)frame
                             Title:(NSString *)title
                        titleFrame:(CGRect)titleFrame
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font
                             image:(NSString *)image
                         highImage:(NSString *)highImage
                        imageFrame:(CGRect)imageFrame
                   backgroundColor:(UIColor *)backgroundColor
                         tapAction:(TapButtonActionBlock)tapAction;

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

- (void)setEnlargeEdge:(CGFloat) size;

@end


@interface EazyClickButton : UIButton
@end

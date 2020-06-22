//
//  UILabel+Extension.h
//  借钱花花
//
//  Created by Meiyue on 15/12/16.
//  Copyright © 2015年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
/**
 *  快速创建Label
 *
 *  @param title         文字
 *  @param font          字体
 */

+ (instancetype)addLabelWithtitle:(NSString *)title
                       titleColor:(UIColor *)titleColor
                             font:(UIFont *)font;
/**
 *  设置字间距
 */
- (void)setColumnSpace:(CGFloat)columnSpace;
/**
 *  设置行距
 */
- (void)setRowSpace:(CGFloat)rowSpace;
/**
 *  设置删除线
   @param color 删除线颜色
 */
- (void)setCenterLineWithColor:(UIColor *)color;
/**
 *  设置下划线
 @param color 删除线颜色
 */
- (void)setBottomLineWithColor:(UIColor *)color;

/**
 设计字体大小

 @param font 字体大小
 @param range 范围
 */
-(void)setLabelAttributeText:(UIFont*)font Range:(NSRange)range;


/**
 设置部分字体的颜色
 @param text 查找的文本
 @param textColor 文本的颜色
 */
-(void)setAttributeText:(NSString*)text Color:(UIColor*)textColor;


/**
 
设置部分字体的颜色
 @param text 文本
 @param textColor 文本颜色
 */
-(void)setStartAttributeText:(NSString*)text Color:(UIColor*)textColor;
/*设置长度*/
-(void)setStartAttributeText:(NSString*)text Color:(UIColor*)textColor Length:(NSInteger)length;

/*获取文本的宽高*/
-(CGSize)getLabelWith;

//给UILabel设置行间距和字间距
-(void)setLabelSpaceWithLineHight:(CGFloat)lineHight;

/*计算高度*/
-(CGFloat)getSpaceLabelwithWidth:(CGFloat)width LineHight:(CGFloat)lineHight;
/*label添加 中间线*/
-(void)addMiddleLinerange:(NSRange)range;

@end

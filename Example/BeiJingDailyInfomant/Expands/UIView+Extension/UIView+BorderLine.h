//
//  UIView+BorderLine.h
//  GomeShop
//
//  Created by Gome on 2018/8/15.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {
    UIBorderSideTypeAll  = 0,
    UIBorderSideTypeTop = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft = 1 << 2,
    UIBorderSideTypeRight = 1 << 3,
};


@interface UIView (BorderLine)


/**
 给View添加边框

 @param color 颜色
 @param borderWidth 变宽 宽度
 @param borderType 类型
 @return 返回值
 */
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;


@end

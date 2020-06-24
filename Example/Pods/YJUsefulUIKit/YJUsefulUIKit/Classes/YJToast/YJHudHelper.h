//
//  YJHudHelper.h
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DissMissDuration 2.0f   
@interface YJHudHelper : NSObject

#pragma mark loading
/** 加载菊花 */
+(void)ShowLoadingToView:(UIView *)view animated:(BOOL)animated;
/** 加载菊花带标题 */
+(void)ShowLoadingWithTitle:(NSString *)title ToView:(UIView *)view animated:(BOOL)animated;
/** 加载菊花带标题和内容 */
+(void)ShowLoadingWithTitle:(NSString *)title subTitle:(NSString *)suibtitle ToView:(UIView *)view animated:(BOOL)animated;


#pragma mark tips
/** 显示文字在window上2秒消失*/
+(void)ShowText:(NSString *)text;
/** 显示文字在window上，几秒后消失*/
+(void)ShowText:(NSString *)text dismissAfterDelay:(CGFloat)delay;
/** 显示文字在view上， 几秒后消失 */
+(void)showTextWithTitle:(NSString *)text toView:(UIView *)view dismissAfterDelay:(CGFloat)delay;
/** 显示文字和子标题在view上， 几秒后消失 */
+(void)showTextWithTitle:(NSString *)text subTitle:(NSString *)content toView:(UIView *)view dismissAfterDelay:(CGFloat)delay;

/** 隐藏所有的hud */
+(NSInteger)HideAllHudsForView:(UIView *)view animated:(BOOL)animated;
@end

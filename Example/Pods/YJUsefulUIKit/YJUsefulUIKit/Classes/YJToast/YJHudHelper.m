//
//  YJHudHelper.m
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "YJHudHelper.h"
#import "MDProgressHUD.h"

@implementation YJHudHelper
+(void)ShowLoadingToView:(UIView *)view animated:(BOOL)animated{
    [self HideAllHudsForView:view animated:NO];
    [MDProgressHUD showHUDAddedTo:view animated:YES];
}

+ (void)ShowLoadingWithTitle:(NSString *)title ToView:(UIView *)view animated:(BOOL)animated{
    [self HideAllHudsForView:view animated:NO];
    MDProgressHUD *hud = [MDProgressHUD showHUDAddedTo:view animated:animated];
    hud.label.text = title;
}

+ (void)ShowLoadingWithTitle:(NSString *)title subTitle:(NSString *)suibtitle ToView:(UIView *)view animated:(BOOL)animated{
    [self HideAllHudsForView:view animated:NO];
    MDProgressHUD *hud = [MDProgressHUD showHUDAddedTo:view animated:animated];
    hud.label.text = title;
    hud.detailsLabel.text = suibtitle;
}

+(void)ShowText:(NSString *)text{
    MDProgressHUD *hud = [MDProgressHUD showHUDAddedTo:[self frontWindow] animated:YES];
    hud.mode = MDProgressHUDModeText;
    hud.label.text = text;
    [hud hideAnimated:YES afterDelay:2.0f];
}

+(void)ShowText:(NSString *)text dismissAfterDelay:(CGFloat)delay{
    MDProgressHUD *hud = [MDProgressHUD showHUDAddedTo:[self frontWindow] animated:YES];
    hud.mode = MDProgressHUDModeText;
    hud.label.text = text;
    if (delay<=0) {
        delay = 2.0f;
    }
    [hud hideAnimated:YES afterDelay:delay];
}
+(void)showTextWithTitle:(NSString *)text toView:(UIView *)view dismissAfterDelay:(CGFloat)delay{
    [self HideAllHudsForView:view animated:NO];
    MDProgressHUD *hud = [MDProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MDProgressHUDModeText;
    hud.label.text = text;
    if (delay<=0) {
        delay = 2.0f;
    }
    [hud hideAnimated:YES afterDelay:delay];
}

+(void)showTextWithTitle:(NSString *)text subTitle:(NSString *)content toView:(UIView *)view dismissAfterDelay:(CGFloat)delay{
    [self HideAllHudsForView:view animated:NO];
    MDProgressHUD *hud = [MDProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MDProgressHUDModeText;
    hud.label.text = text;
    hud.detailsLabel.text = content;
    if (delay<=0) {
        delay = 2.0f;
    }
    [hud hideAnimated:YES afterDelay:delay];
}

+(NSInteger)HideAllHudsForView:(UIView *)view animated:(BOOL)animated{
    NSArray *huds = [self allHudForView:view];
    for (MDProgressHUD *hud in huds) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:animated];
    }
    return [huds count];
}

+(NSArray *)allHudForView:(UIView *)view{
    NSMutableArray *huds = [NSMutableArray array];
    NSArray *subViews = view.subviews;
    for (UIView *view in subViews) {
        if ([view isKindOfClass:[MDProgressHUD class]]) {
            [huds addObject:view];
        }
    }
    
    MDProgressHUD *hudOnWindow = [MDProgressHUD HUDForView:[self frontWindow]];
    if (hudOnWindow != nil) {
        [huds addObject:hudOnWindow];
    }
    return [NSArray arrayWithArray:huds];
}


+ (UIWindow *)frontWindow {
#if !defined(SV_APP_EXTENSIONS)
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal);
        BOOL windowKeyWindow = window.isKeyWindow;
        
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported && windowKeyWindow) {
            return window;
        }
    }
#endif
    return nil;
}
@end

//
//  YJAlertViewTool.m
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "YJAlertViewTool.h"

#define kRootViewController [UIApplication sharedApplication].keyWindow.rootViewController

@interface YJAlertViewTool ()

@property(copy,nonatomic)void (^cancelClicked)(void);

@property(copy,nonatomic)void (^confirmClicked)(void);

@end


@implementation YJAlertViewTool

/** Alert  任意多个按键 返回选中的 buttonIndex 和 buttonTitle */
+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)actionTitles  preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void(^)(NSUInteger buttonIndex, NSString *buttonTitle))handler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        handler(0, @"取消");
    }];
    [alert addAction:cancelAction];
    
    for (int i = 0; i < actionTitles.count; i ++) {
        
        UIAlertAction *confimAction = [UIAlertAction actionWithTitle:actionTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            handler((i + 1), actionTitles[i]);
        }];
        [alert addAction:confimAction];
    }
    
    [kRootViewController presentViewController:alert animated:YES completion:nil];
}

+ (void)showAlertView:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelButtonTitle otherTitle:(NSString *)otherButtonTitle cancelBlock:(void (^)(void))cancle confrimBlock:(void (^)(void))confirm {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction;
    if (cancelButtonTitle) {
        cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (cancle) {
                 cancle();
            }
        }];
        
        [alertController addAction:cancelAction];
    }
    if (otherButtonTitle) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (confirm) {
                confirm();
            }
        }];
        [alertController addAction:otherAction];
    }

    [viewController presentViewController:alertController animated:YES completion:nil];
}
@end

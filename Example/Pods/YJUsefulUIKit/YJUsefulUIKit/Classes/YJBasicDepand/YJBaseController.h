//
//  YJBaseController.h
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJBaseController : UIViewController

/** 自定义导航按钮 */
-(UIButton *)leftBarButton;
/** 自定义导航按钮 */
-(UIButton *)rightBarButton;
/** 导航按钮点击事件 */
-(void)leftBarButtonItemClick;
/** 导航按钮点击事件 */
-(void)rightBarButtonItemClick;
@end

NS_ASSUME_NONNULL_END

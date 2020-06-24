//
//  YJProgessWKWebview.h
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface YJProgessWKWebview : WKWebView
@property(nonatomic,strong) UIColor * trackTintColor;
@property(nonatomic,strong) UIColor * progressTintColor;
@end

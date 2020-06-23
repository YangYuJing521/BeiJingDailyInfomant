//
//  TemplateBaseReusableView.m
//  GomeShop
//
//  Created by ued1 on 2018/8/10.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import "TemplateBaseReusableView.h"
#import "macros.h"
@implementation TemplateBaseReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = GMBGColor255;
    }
    return self;
}
@end

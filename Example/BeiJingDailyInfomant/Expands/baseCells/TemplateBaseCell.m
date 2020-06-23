//
//  TemplateBaseCell.m
//  GomeShop
//
//  Created by ued1 on 2018/8/8.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import "TemplateBaseCell.h"
#import "macros.h"

@implementation TemplateBaseCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = GMBGColor255;
    }
    return self;
}
@end

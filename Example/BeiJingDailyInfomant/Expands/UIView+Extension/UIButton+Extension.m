//
//  UIButton+Extension.m
//  借钱花花
//
//  Created by Meiyue on 15/12/16.
//  Copyright © 2015年 abc. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>
static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

@implementation MYExButton

- (instancetype)init
{
    if(self = [super init])
    {
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark 点击事件
-(void)btnClick:(UIButton *)button
{
    if(self.action){
        self.action(self);
    }
}

@end


@interface MYExFrameButton()
@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect imageRect;
@end
@implementation MYExFrameButton
-(instancetype)initWithFrame:(CGRect)frame andTitleFrame:(CGRect)titleFrame andImageFrame:(CGRect)imageFrame{
    if (self = [super initWithFrame:frame]) {
        self.titleRect = titleFrame;
        self.imageRect = imageFrame;
        [self setExclusiveTouch:YES];
        self.clipsToBounds = YES;
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(CGRect)backgroundRectForBounds:(CGRect)bounds{
    return bounds;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return _titleRect;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return _imageRect;
}

#pragma mark 点击事件
-(void)btnClick:(UIButton *)button
{
    if(self.action){
        self.action(self);
    }
}
@end



@implementation UIButton (MYExtension)

#pragma mark 创建普通按钮
+ (instancetype)addCustomButtonTitle:(NSString *)title  font:(UIFont *)font
                               backgroundColor:(UIColor *)backgroundColor
                                    titleColor:(UIColor *)titleColor
                                     tapAction:(TapButtonActionBlock)tapAction{
    
    MYExButton *btn = [[MYExButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = backgroundColor;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = font;
    btn.action = tapAction;
    
    return btn;
}

#pragma mark 创建文字和图片按钮
+ (instancetype)addButtonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font
                             image:(NSString *)image
                         highImage:(NSString *)highImage
                   backgroundColor:(UIColor *)backgroundColor
                     tapAction:(TapButtonActionBlock)tapAction{
    
    MYExButton *btn = [self addCustomButtonTitle:title font:font backgroundColor:backgroundColor titleColor:titleColor tapAction:tapAction];
    
    // 设置图片
    if (image) {
         [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (highImage) {
        [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateSelected];
    }
    return btn;
}

+ (instancetype)addButtonWithframe:(CGRect)frame
                             Title:(NSString *)title
                        titleFrame:(CGRect)titleFrame
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font
                             image:(NSString *)image
                         highImage:(NSString *)highImage
                        imageFrame:(CGRect)imageFrame
                   backgroundColor:(UIColor *)backgroundColor
                         tapAction:(TapButtonActionBlock)tapAction{
    
    MYExFrameButton *btn = [[MYExFrameButton alloc] initWithFrame:frame andTitleFrame:titleFrame andImageFrame:imageFrame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = backgroundColor;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = font;
    btn.action = tapAction;
    // 设置图片
    if (image) {
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (highImage) {
        [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateSelected];
    }
    return btn;
}

#pragma mark 带有圆角的
+ (instancetype)addRadiuButtonWithTitle:(NSString *)title
                                     font:(UIFont *)font
                          backgroundColor:(UIColor *)backgroundColor
                               titleColor:(UIColor *)titleColor
                                tapAction:(TapButtonActionBlock)tapAction{
    
    MYExButton *btn = [self addCustomButtonTitle:title font:font backgroundColor:backgroundColor titleColor:titleColor tapAction:tapAction];
    btn.layer.masksToBounds = YES;
    btn.clipsToBounds = YES;
    return btn;
}

- (void)setEnlargeEdge:(CGFloat) size{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void) setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect) enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (UIView*) hitTest:(CGPoint) point withEvent:(UIEvent*) event
{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

@end


@implementation EazyClickButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end

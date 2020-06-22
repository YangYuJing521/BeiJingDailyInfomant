//
//  UILabel+Extension.m
//  借钱花花
//
//  Created by Meiyue on 15/12/16.
//  Copyright © 2015年 abc. All rights reserved.
//

#import "UILabel+Extension.h"
#import <CoreText/CoreText.h>
#import "macros.h"
@implementation UILabel (Extension)

+ (instancetype)addLabelWithtitle:(NSString *)title
                       titleColor:(UIColor *)titleColor
                             font:(UIFont *)font{
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = titleColor;
    label.userInteractionEnabled = YES;
    label.font = font;
    label.backgroundColor=[UIColor clearColor];
    return label;
}

/*label添加 中间线*/
-(void)addMiddleLinerange:(NSRange)range{
    if (NULLString(TO_STR(self.text))||!self||(range.location+range.length>self.text.length)){
        //如果没有文本 或者label 不存在
        return;
    }
    //中划线
    NSMutableAttributedString * attribtStr = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attribtStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    self.attributedText= attribtStr;
}

-(void)setLabelAttributeText:(UIFont*)font Range:(NSRange)range{
    if (NULLString(self.text)) {
        return;
    }
    NSMutableAttributedString *  attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = attributedString;
}

/*计算高度*/
-(CGFloat)getSpaceLabelwithWidth:(CGFloat)width LineHight:(CGFloat)lineHight {
    
    if (NULLString(self.text)||!self) {
        return 0.f;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineHight;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle};
    
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

//给UILabel设置行间距和字间距
-(void)setLabelSpaceWithLineHight:(CGFloat)lineHight {
    
    if (NULLString(self.text)||!self) {
        return;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineHight; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:self.text attributes:dic];
    self.attributedText = attributeStr;
}



/**
 设置部分字体的颜色
 @param text 查找的文本
 @param textColor 文本的颜色
 */
-(void)setAttributeText:(NSString*)text Color:(UIColor*)textColor{
    
    if (NULLString(self.text)||NULLString(text)) {
        return;
    }
    
    NSRange range = [self.text rangeOfString:text];
    NSMutableAttributedString *  attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(range.location+1, self.text.length-range.location-1)];
    self.attributedText = attributedString;
}


-(void)setStartAttributeText:(NSString*)text Color:(UIColor*)textColor{
    
    if (NULLString(self.text)||NULLString(text)) {
        return;
    }
    NSRange range = [self.text rangeOfString:text];
    NSMutableAttributedString *  attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, range.location)];
    self.attributedText = attributedString;
}

-(void)setStartAttributeText:(NSString*)text Color:(UIColor*)textColor Length:(NSInteger)length{
    
    if (NULLString(self.text)||NULLString(text)) {
        return;
    }
    NSRange range = [self.text rangeOfString:text];
    NSMutableAttributedString *  attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(range.location+range.length, length)];
    self.attributedText = attributedString;
}

-(CGSize)getLabelWith{
    
    CGSize textSize = CGSizeZero;
    if (!NULLString(self.text)) {
        textSize = [self.text boundingRectWithSize:CGSizeZero
                                           options:(NSStringDrawingOptions)(NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin)
                                        attributes:@{NSFontAttributeName: self.font}
                                           context:NULL].size;
    }
    return textSize;
}



/**
 *  设置字间距
 */
- (void)setColumnSpace:(CGFloat)columnSpace{
    
    if (self.attributedText) {
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(columnSpace) range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
}

/**
 *  设置行距
 */
- (void)setRowSpace:(CGFloat)rowSpace
{
//    self.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
//    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}

/**
 *  设置删除线
 */
- (void)setCenterLineWithColor:(UIColor *)color
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.text];
    [str addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, self.text.length )];
    [str addAttribute:NSStrikethroughColorAttributeName value:color range:NSMakeRange(0, self.text.length)];
    self.attributedText = str;
}

/**
 *  设置下划线
 */
- (void)setBottomLineWithColor:(UIColor *)color
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.text];
    [str addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, self.text.length )];
    [str addAttribute:NSStrokeColorAttributeName value:color range:NSMakeRange(0, self.text.length)];
    self.attributedText = str;
}

@end

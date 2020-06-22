//
//  GMFilterTool.h
//  GomeShop
//
//  Created by Gome on 2018/9/3.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  NS_ENUM(NSInteger ,GMTabBarControllerType){
    GMTabBarControllerHome = 0,             //首页
    GMTabBarControllerIM = 1,           //消息
    GMTabBarControllerShopKeeper = 2,          //店主
    GMTabBarControllerMySelf = 3,           //我的
};

@interface GMFilterTool : NSObject
/*字符串 是否包含*/
+(BOOL)filterString:(NSString*)str ContainSubString:(NSString*)subStr;
/*拨打电话*/
+(void)callPhoneNumer:(NSString*)phoneNumber;
/*检测是不是电话号码*/
+(BOOL)filterByPhoneNumber:(NSString *)phone;
/*文本 字符串 全部替换*/
+(NSString*)regularExpressionWithString:(NSString*)replaceStr ReplaceStr:(NSString*)str;
/*处理图片链接*/
+(NSString*)filterImageUrl:(NSString*)imageUrl;
//判断是否有中文
+(BOOL)hasChinese:(NSString *)str;
// 读取本地JSON文件
+(NSDictionary *)readLocalFileWithName:(NSString *)name;
/*转化 时间 时间格式*/
+(NSString *)timeWithTimeIntervalString:(NSString *)seconds DateFormat:(NSString*)dateFormat;
/*匹配 数字 字母 汉字*/
+(BOOL)validateRemark:(NSString*)sText;
/*根据字符串 截断字符串*/
+(NSString*)cutOffString:(NSString*)Str WithMark:(NSString*)mark;
/*判断 字符串类型*/
+(NSString*)filterStringWithStr:(NSString*)str;
/*字符串转Json*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/*json转字符串*/
+ (NSString *)jsonStringWithDict:(NSDictionary *)dict;
/* label->range颜色/大小*/
+(void)LabelAttributedString:(UILabel*)label range:(NSRange)range color:(UIColor *)color size:(CGFloat)size;
@end

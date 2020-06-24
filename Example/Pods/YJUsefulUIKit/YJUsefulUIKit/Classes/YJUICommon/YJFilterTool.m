//
//  YJFilterTool.m
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "YJFilterTool.h"
#import <objc/runtime.h>
#import "YJObjectNocarsh.h"
#import "YJmacros.h"

@implementation YJFilterTool
/*字符串转Json*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+(BOOL)filterString:(NSString*)str ContainSubString:(NSString*)subStr{
    
    if (NULLString(str)||NULLString(subStr)) {
        return NO;
    }
    
    if([str rangeOfString:subStr].location !=NSNotFound){
        return YES;
    }else{
        return NO;
    }
    return NO;
}

/*json转字符串*/
+ (NSString *)jsonStringWithDict:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

/*判断 字符串类型*/
+(NSString*)filterStringWithStr:(NSString*)str{
    
    if (!str||[str isKindOfClass:[NSNull class]]) {
        return  nil;
    }
    str = [NSString stringWithFormat:@"%@",str];
    if (NULLString(str)) {
        return nil;
    }
    return str;
}

/*根据字符串 截断字符串*/
+(NSString*)cutOffString:(NSString*)Str WithMark:(NSString*)mark{
    if (NULLString(Str)||NULLString(mark)) {
        return nil;
    }
    return [[Str componentsSeparatedByString:mark] lastObject];
}

+(NSString *)timeWithTimeIntervalString:(NSString *)seconds DateFormat:(NSString*)dateFormat {
    
    if (!seconds||!dateFormat) {
        return nil;
    }
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormat];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[seconds integerValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

/*拨打电话*/
+(void)callPhoneNumer:(NSString*)phoneNumber{
    
    if (NULLString(phoneNumber)) {
        return;
    }
    NSString * phoneTel = [NSString stringWithFormat:@"tel://%@",phoneNumber];
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:)]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:phoneTel]];
    }
}

+(BOOL)filterByPhoneNumber:(NSString *)phone{
    
    NSPredicate * telePhoneNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(1[0123456789]{10})|((0[0-9]{2,3}){0,1}([2-9][0-9]{6,7}))$"];
    BOOL isTelephoneNumber = [telePhoneNumberPred evaluateWithObject:phone];
    return isTelephoneNumber;
}

/*处理图片链接*/
+(NSString*)filterImageUrl:(NSString*)imageUrl{
    if (NULLString(imageUrl)) {
        return @"";
    }
    
    if ([YJFilterTool hasChinese:imageUrl]) {
        #if __IPHONE_OS_VERSION_MIN_REQUIRED < 90000
        //小于某版本的时候代码在这里定义
         imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        #else
         imageUrl =  [imageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        #endif
    }

    if (!([imageUrl hasPrefix:@"http"]||[imageUrl hasPrefix:@"https"])) {
        imageUrl = [@"http:" stringByAppendingString:imageUrl];
    }
    return imageUrl;
}

//判断是否有中文
+(BOOL)hasChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

// 读取本地JSON文件
+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

/*文本 字符串 全部替换*/
+(NSString*)regularExpressionWithString:(NSString*)replaceStr ReplaceStr:(NSString*)str{
    
    if (NULLString(replaceStr)||!str) {
        return nil;
    }
    NSString * regExpStr = @"[-/]";
    // 创建 NSRegularExpression 对象,匹配 正则表达式
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:regExpStr
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];
    // 替换匹配的字符串为 searchStr
  NSString * resultStr = [regExp stringByReplacingMatchesInString:replaceStr
                                                 options:NSMatchingReportProgress
                                                   range:NSMakeRange(0, replaceStr.length)
                                            withTemplate:str];
    return resultStr;
}

+(BOOL)validateRemark:(NSString*)sText{
    if (!sText) {
        return NO;
    }
    //匹配 字母 数字 汉字
    NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return[pred evaluateWithObject:sText];
}

/* label->range颜色/大小*/
+(void)LabelAttributedString:(UILabel*)label range:(NSRange)range color:(UIColor *)color size:(CGFloat)size
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:range];
    [label setAttributedText:noteStr];
}


/** 处理带小数点的金额显示 */
+(NSString *)handlePrice:(NSString *)price{
    if ([price containsString:@"."]) {
        NSArray *twoParts = [price componentsSeparatedByString:@"."];
        NSString *xiaoshu = twoParts.lastObject;
        if (xiaoshu.length>2) {
            xiaoshu = [xiaoshu substringToIndex:1];
        }
        
        NSString *tempString = xiaoshu;
        for (NSInteger i = xiaoshu.length-1 ; i>=0; i--) {
            if ([xiaoshu characterAtIndex:i]=='0') {
                tempString = [tempString substringToIndex2:i];
            }
        }
        NSString *price = [NSString stringWithFormat:@"%@.%@",twoParts.firstObject, tempString];
        if ([price characterAtIndex:price.length-1]=='.') {
            price = twoParts.firstObject;
        }
        return price;
    }
    return price;
}
@end

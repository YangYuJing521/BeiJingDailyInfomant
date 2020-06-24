//
//  YJPodUtil.h
//
//  Created by 杨玉京 on 2020/6/22.
//
//

#import <Foundation/Foundation.h>

@interface YJPodUtil : NSObject
//通过Pod 名字获取其所在的Bundle
+ (NSBundle *)bundleForPod:(NSString*)podName;

@end

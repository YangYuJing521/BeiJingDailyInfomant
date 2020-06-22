//
//  PodUtil.h
//  Pods
//
//  Created by CoderAFI on 16/8/17.
//
//

#import <Foundation/Foundation.h>

@interface PodUtil : NSObject
//通过Pod 名字获取其所在的Bundle
+ (NSBundle *)bundleForPod:(NSString*)podName;

@end

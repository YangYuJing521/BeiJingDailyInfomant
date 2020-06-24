//
//  YJPodUtil.m
//
//  Created by 杨玉京 on 2020/6/22.
//
//

#import "YJPodUtil.h"

@implementation YJPodUtil

+ (NSBundle *)bundleForPod:(NSString*)podName {
    for (NSBundle* bundle in [NSBundle allBundles]) {
        NSURL *bundleURL = [bundle URLForResource:podName withExtension:@"bundle"];
        if (bundleURL) {
            return [NSBundle bundleWithURL:bundleURL];
        }
    }
    
    for (NSBundle* bundle in [NSBundle allBundles]) {
        NSArray* bundles = [self recursivePathsForResourcesOfType:@"bundle" name:podName inDirectory:[bundle bundlePath]];
        if (bundles.count > 0) {
            NSString *bundlePath = bundles.firstObject;
            return [NSBundle bundleWithPath:bundlePath];
        }
    }
    
    return nil;
}

+ (NSArray *)recursivePathsForResourcesOfType:(NSString *)type name:(NSString*)name inDirectory:(NSString *)directoryPath {
    
    NSMutableArray *filePaths = [[NSMutableArray alloc] init];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:directoryPath];
    
    NSString *filePath;
    
    while ((filePath = [enumerator nextObject]) != nil){
        if (!type || [[filePath pathExtension] isEqualToString:type]){
            if (!name || [[[filePath lastPathComponent] stringByDeletingPathExtension] isEqualToString:name]){
                [filePaths addObject:[directoryPath stringByAppendingPathComponent:filePath]];
            }
        }
    }
    
    return filePaths;
}

@end

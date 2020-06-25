//
//  ReadJsonHandler.m
//  BeiJingDailyInfomant
//
//  Created by 杨玉京 on 2020/6/25.
//

#import "ReadJsonHandler.h"

@implementation ReadJsonHandler

+(void)GetBaoLiaoTypesFromLocalJson:(Result)result{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BaoLiaoTypes" ofType:@"geojson"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSError *error;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result) result(dataDic, dataDic!= nil);
        });
    });
}
@end

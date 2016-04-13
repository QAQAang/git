//
//  SJLCleanCache.m
//  DailyNews
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SJLCleanCache.h"

@implementation SJLCleanCache

+(void)removeCache{
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //cache目录
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //判断目录是否存在
    if ([fileManager fileExistsAtPath:cachePath]) {
        //目录下的文件夹
        NSArray *childFile = [fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childFile) {
            //拼接路径
            NSString *file = [cachePath stringByAppendingPathComponent:fileName];
            //清除文件
            [fileManager removeItemAtPath:file error:nil];
        }
    }
}

+(void)removeCache:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childFile = [fileManager subpathsAtPath:path];
        for (NSString *file in childFile) {
            NSString *fileName = [path stringByAppendingPathComponent:file];
            [fileManager removeItemAtPath:fileName error:nil];
        }
    }
}

+(CGFloat)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断是否存在
    if ([fileManager fileExistsAtPath:path]) {
        long long  size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size ;
    }
    return 0;
}

+(CGFloat)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    CGFloat folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childFile = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childFile) {
            NSString *file = [path stringByAppendingPathComponent:fileName];
            folderSize+= [self fileSizeAtPath:file];
        }
        return folderSize / 1024.0 /1024.0;
    }
    return 0;
}

@end

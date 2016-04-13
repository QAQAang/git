//
//  SJLCleanCache.h
//  DailyNews
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SJLCleanCache : NSObject

//清除cache数据
+(void)removeCache;

//清除数据(带路径)
+(void)removeCache:(NSString *)path;

//计算文件大小
+(CGFloat)fileSizeAtPath:(NSString *)path;

//计算目录大小
+(CGFloat)folderSizeAtPath:(NSString *)path;

@end

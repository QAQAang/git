//
//  AA_NetWorkTool.h
//  ArtGoer
//
//  Created by dllo on 16/2/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^ProgressBlock)(NSProgress *progress);

typedef void(^SuccessBlock)(id result);

typedef void(^FailureBlock)(NSError *error);

// 返回值类型
typedef NS_ENUM(NSUInteger, ResponseType) {
    ResponseTypeDATA,
    ResponseTypeJSON,
    ResponseTypeXML,
};

// body体的类型
typedef NS_ENUM(NSUInteger, BodyType) {
    BodyTypeNormal,
    BodyTypeJSONString,
};

@interface AA_NetWorkTool : NSObject
/*
 GET请求
 *1 url
    url
 *2 parameter
    参数
 *3 httpHeader
    请求头
 *4 responseType
    返回值类型
 *5 progress
    进度
 *6 success
    成功
 *7 failure
    失败
 */

+ (void)getWithURL:(NSString *)url parameter:(NSDictionary *)parameter httpHeader:(NSDictionary *)header responseType:(ResponseType)responseType progress:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure;

+ (void)postWithURL:(NSString *)url body:(id)body bodyType:(BodyType)bodyType httpHeader:(NSDictionary *)header responseType:(ResponseType)responseType progress:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure;

@end

//
//  AA_adaptivelyHW.m
//  ArtGoer
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_adaptivelyHW.h"

@implementation AA_adaptivelyHW

+ (CGFloat)getHeight:(NSString *)text :(CGFloat)width :(CGFloat)fontSize{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.height;
}

+ (CGFloat)getWidth:(NSString *)text :(CGFloat)height :(CGFloat)fontSize{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.height;
}

@end

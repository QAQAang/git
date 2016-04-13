//
//  AA_adaptivelyHW.h
//  ArtGoer
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AA_adaptivelyHW : NSObject

+ (CGFloat)getHeight:(NSString *)text :(CGFloat)width :(CGFloat)fontSize;

+ (CGFloat)getWidth:(NSString *)text :(CGFloat)height :(CGFloat)fontSize;

@end

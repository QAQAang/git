//
//  AA_sqliteTools.h
//  ArtGoer
//
//  Created by dllo on 16/3/11.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AA_sqliteTools : NSObject

+ (BOOL)insertUserWithTitle:(NSString *)title PicUrl:(NSString *)picUrl Url:(NSString *)url Comment:(NSString *)commentUrl;

+ (NSMutableArray *)selectUserByTitle:(NSString *)title;

+ (void)deleteUserWithTitle:(NSString *)title;

@end

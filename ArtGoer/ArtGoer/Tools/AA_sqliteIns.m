//
//  AA_sqliteIns.m
//  ArtGoer
//
//  Created by dllo on 16/3/11.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AA_sqliteIns.h"
#import "FMDB.h"
#define SQLCREATE @"create table if not exists Institution (id integer primary key , name text , pic text , adress text);"
#define SQLSELECTALL @"select * from Institution"
#define SQLINSERT @"insert into Institution (name , pic , adress ) values ('%@' , '%@' , '%@' )", name, pic , adress
#define SQLDELETE @"delete from Institution where name = %@",title
#define SQLSELECTbyNANE @"select * from Institution where name = '%@'", title
#define SQLDELETEALL @"delete from Institution"

static FMDatabase *db;
static NSString *path;

@implementation AA_sqliteIns
/**只在第一次使用时会调用的方法 */

+ (void)initialize{
    path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"Institution.sqlite"];
    db = [FMDatabase databaseWithPath:filePath];
    [db open];
    /**id integer primary key创建自增一的id */
    NSString *sqlCreate = SQLCREATE;
    /**fmdb执行除查询外全部操作使用的语句 */
    [db executeUpdate:sqlCreate];
    [db close];
}

+ (NSMutableArray *)selectUserByTitle:(NSString *)title{
    [db open];
    FMResultSet *results;
    if (title) {
        results = [db executeQuery:[NSString stringWithFormat:SQLSELECTbyNANE]];
    }
    else
        results = [db executeQuery:SQLSELECTALL];
    
    NSMutableArray *array = [NSMutableArray array];
    while ([results next]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[results stringForColumn:@"name"] forKey:@"title"];
        [dic setObject:[results stringForColumn:@"pic"] forKey:@"picUrl"];
        [dic setObject:[results stringForColumn:@"adress"] forKey:@"url"];
        [array addObject:dic];
    }
    [db close];
    return array;
}

+ (BOOL)insertUserWithTitle:(NSString *)title PicUrl:(NSString *)picUrl Url:(NSString *)url{
    NSString *name = title;
    if ([AA_sqliteIns selectUserByTitle:name].count == 0) {
        [db open];
        NSString *name = title;
        NSString *pic = picUrl;
        NSString *adress = url;
        NSLog(@"%@",path);
        [db executeUpdate:[NSString stringWithFormat:SQLINSERT]];
        [db close];
        return YES;
    }
    else
        return NO;
}

+ (void)deleteUserAllItems{
    [db open];
    [db executeUpdateWithFormat:SQLDELETEALL];
    [db close];
}

+ (void)deleteUserWithTitle:(NSString *)title{
    [db open];
    [db executeUpdateWithFormat:SQLDELETE];
    [db close];
}
@end

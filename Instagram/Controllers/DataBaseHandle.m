//
//  DataBaseHandle.m
//  LessonSQLite
//
//  Created by lanou3g on 14-9-4.
//  Copyright (c) 2014年 sonege. All rights reserved.
//

#import "DataBaseHandle.h"
#import <sqlite3.h>
#import "UserVO.h"

@implementation DataBaseHandle

static DataBaseHandle * handle = nil;

+(DataBaseHandle *)shareInstance
{
    if (nil == handle) {
        handle = [[DataBaseHandle alloc] init];
        //打开数据库
        [handle openDB];
    }
    return handle;
}

static sqlite3 * db = nil;

//打开数据库
- (void)openDB
{
    //如果数据库已经打开，不需要执行后边的代码
    if (nil != db) {
        return;
    }
    //数据库存在document，数据库名字LanouStudent.sqlite
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSLog(@"documentPath == %@",documentPath);
    NSString * sqlitePath = [documentPath stringByAppendingPathComponent:@"UserManager.sqlite"];
    
    //打开数据库(如果打开的数据库不存在，直接创建一个空的)
    int result = sqlite3_open([sqlitePath UTF8String], &db);
    //判断数据库是否打开成功 SQLITE_OK代表0，表示正确
    if (result == SQLITE_OK) {
        //创建数据表(如果已经存在要创建的数据表，该操作无效)
        NSString * sql = @"CREATE TABLE groupName (name TEXT PRIMARY KEY UNIQUE);CREATE TABLE userVO (strID TEXT PRIMARY KEY UNIQUE, strName TEXT NOT NULL, groupName TEXT,url TEXT)";//创建多个表，后边加分号
        //执行sql语句
        sqlite3_exec(db, [sql UTF8String], NULL, NULL, NULL);
    }
}

//关闭数据库
- (void)closeDB
{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        //关闭数据库后，将db置为nil；打开数据库时需要使用db进行判断
        db = nil;
    }
}

- (void)insertGroup:(NSString *)groupName
{
    //打开数据库
    [self openDB];
    //定义stmt跟随指针
    sqlite3_stmt *stmt = nil;
    //sql语句
    NSString *sql = @"insert into groupName (name) values (?)";
    //验证sql语句是否正确
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    NSLog(@"%d",result);
    if (result == SQLITE_OK) {
        //sql语句正确,绑定插入的数据，即替换？下标从1开始
        sqlite3_bind_text(stmt, 1, [groupName UTF8String], -1, NULL);
        //执行sql语句
        sqlite3_step(stmt);
    }
    //释放stmt占用的内存
    sqlite3_finalize(stmt);
}

- (void)deleteGroup:(NSString *)groupName
{
    [self openDB];
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"delete from groupName where name = ?";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [groupName UTF8String], -1, NULL);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}

- (NSMutableArray *)selectAllGroup
{
    [self openDB];
    sqlite3_stmt * stmt = nil;
    NSString *sql = @"select * from groupName";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        //创建空的可变的数组，添加搜索到的学生对象
        NSMutableArray *groupArray = [NSMutableArray arrayWithCapacity:1];
        //执行sql语句，取值
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //根据sql语句，搜索到符合条件的数据(即某行数据)，取值
            //获取的数据表中属性的数量和顺序，与select和from之间添加的内容有关 number name gender age
            //取值时索引从0开始
            NSString *name =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            NSLog(@"%@",name);
            [groupArray addObject:name];
        }
        //搜索结束后，将结果stuArray返回(没有搜索到结果时，返回的是空数组)
        sqlite3_finalize(stmt);
        return groupArray;
    }
    sqlite3_finalize(stmt);
    return nil;
}

- (void)insertUser:(UserVO *)user
{
    //打开数据库
    [self openDB];
    //定义stmt跟随指针
    sqlite3_stmt *stmt = nil;
    //sql语句
    NSString *sql = @"insert into userVO (strID,strName,groupName,url) values (?,?,?,?)";
    //验证sql语句是否正确
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        //sql语句正确,绑定插入的数据，即替换？下标从1开始
        sqlite3_bind_text(stmt, 1, [user.strId UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [user.strName UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [@"未分组" UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [user.strAvataUrl UTF8String], -1, NULL);
        //执行sql语句
        sqlite3_step(stmt);
    }
    //释放stmt占用的内存
    sqlite3_finalize(stmt);
}


- (void)updateGroupName:(NSString *)groupName WithUserID:(NSString *)userID
{
    [self openDB];
    
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"update userVO set groupName = ? where strID = ?";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [groupName UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [userID UTF8String], -1, NULL);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}

- (NSMutableArray *)selectUsersWithGroupName:(NSString *)groupName
{
    [self openDB];
    
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"select strID,strName,url from userVO where groupName = ?";
    NSMutableArray *userArray = [NSMutableArray arrayWithCapacity:10];

    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        //执行sql语句之前，绑定?的数据
        sqlite3_bind_text(stmt, 1, [groupName UTF8String], -1, NULL);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            UserVO *user = [[UserVO alloc] init];
            
            user.strId = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            user.strName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            user.strAvataUrl = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            [userArray addObject:user];

        }
        sqlite3_finalize(stmt);
        return userArray;
    }
    sqlite3_finalize(stmt);
    return nil;
}


//- (NSMutableArray *)selectUsersWithUserID:(NSString *)userID
//{
//    [self openDB];
//    
//    sqlite3_stmt *stmt = nil;
//    NSString *sql = @"select strID,strName,url from userVO where strID = ?";
//    NSMutableArray *userArray = [NSMutableArray arrayWithCapacity:10];
//    
//    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
//    if (result == SQLITE_OK) {
//        //执行sql语句之前，绑定?的数据
//        sqlite3_bind_text(stmt, 1, [userID UTF8String], -1, NULL);
//        if (sqlite3_step(stmt) == SQLITE_ROW) {
//            UserVO *user = [[UserVO alloc] init];
//            
//            user.strId = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
//            user.strName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
//            user.strAvataUrl = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
//            [userArray addObject:user];
//            sqlite3_finalize(stmt);
//            return userArray;
//        }
//    }
//    sqlite3_finalize(stmt);
//    return nil;
//}

@end

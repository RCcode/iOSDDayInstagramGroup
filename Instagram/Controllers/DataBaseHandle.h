//
//  DataBaseHandle.h
//  LessonSQLite
//
//  Created by lanou3g on 14-9-4.
//  Copyright (c) 2014年 sonege. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserVO;
@interface DataBaseHandle : NSObject
//创建单例对象
+(DataBaseHandle *)shareInstance;

//打开数据库
- (void)openDB;
//关闭数据库
- (void)closeDB;

- (void)insertGroup:(NSString *)groupName;
- (void)deleteGroup:(NSString *)groupName;

- (NSMutableArray *)selectAllGroup;

- (void)insertUser:(UserVO *)user;
- (void)updateGroupName:(NSString *)groupName WithUserID:(NSString *)userID;
- (NSMutableArray *)selectUsersWithGroupName:(NSString *)groupName;



//添加学生
//- (void)insertStudent:(UserVO *)student;

////修改某个学生的性别
//- (void)updateStudentGender:(NSString *)gender forNumber:(NSInteger)number;
////根据学号删除某个学生
//- (void)deleteStudentForNumber:(NSInteger)number;
////获取所有学生的全部信息,返回的数组中存储的是student对象
//- (NSArray *)selectAllStudent;
////根据学号查询学生姓名
//- (NSString *)selectStudentNameForNumber:(NSInteger)number;
//
////收藏一个学生
//- (void)favoriteStudent:(UserVO *)user;
////根据学号获取学生对象
//- (UserVO *)selectStudentForNumber:(NSInteger)number;
@end

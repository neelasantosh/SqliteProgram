//
//  Databasehelper.m
//  SQLiteProgramming
//
//  Created by Rajesh on 15/12/15.
//  Copyright (c) 2015 CDAC. All rights reserved.
//

#import "Databasehelper.h"
#import <sqlite3.h>
#import "Student.h"
#import "Course.h"

@implementation Databasehelper

+(NSString *)dbPath
{
    //to find the path in the bundle
    
    NSBundle *bundle = [NSBundle mainBundle];
    //dbFile Path is Source path,we have to move it to destination
    NSString *dbFilePath = [bundle pathForResource:@"cdac" ofType:@"sqlite"];
    
    NSLog(@"db path is:%@",dbFilePath);
    //move db file from bundle to document dir
    
    NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    
    NSString *appDocDirPath = [arrayPath objectAtIndex:0];
    //dbpathInDocdir is destination path,dbfilepath is moved into this
    NSString *dbPathInDocdir = [NSString stringWithFormat:@"%@/%@",appDocDirPath,@"cdac.sqlite"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:dbPathInDocdir];
    if (!exist) {
        [fileManager copyItemAtPath:dbFilePath toPath:dbPathInDocdir error:nil];
    }
    NSLog(@"The new path is:%@",dbPathInDocdir);
    
    return dbPathInDocdir;
}

+(NSMutableArray *)getAllStudent
{
    NSMutableArray *arrayStudent = [[NSMutableArray alloc]init];
    
   //execute SQL on DataBase to get Student table
    
    NSString *query = @"select * from student";
    
    //open the database,sqlite3 is structure
    
    sqlite3 *database;
    //sqlite3_open(<#const char *filename#>, <#sqlite3 **ppDb#>)
    //call dbPath method and covert it to char usin UTF*String as *filename in above syntax
    //tis is like getreadable and getWritable
    int result = sqlite3_open([[Databasehelper dbPath] UTF8String], &database);
    
    if (result == SQLITE_OK)//sucess
    {
        sqlite3_stmt *stmt;
        //execute query
        int selectResult = sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, NULL);
        if (selectResult == SQLITE_OK)//sucess
        {
            //read one row at a time
            while(sqlite3_step(stmt) == SQLITE_ROW) //sucess in moving to next row
            {
                //read data of current row
                int rollno = sqlite3_column_int(stmt, 0);
                const unsigned char *name = sqlite3_column_text(stmt, 1);
                double percent = sqlite3_column_double(stmt, 2);
                int course_id = sqlite3_column_int(stmt, 3);
                
                Student *s1 = [[Student alloc]init];
                s1.rollo = rollno;
                s1.percent = percent;
                s1.course_id = course_id;
                s1.name = [NSString stringWithUTF8String:name];
                [arrayStudent addObject:s1];
                
                NSLog(@"%d,%s,%lf,%d",rollno,name,percent,course_id);
            }//eof while
        }//eof if
    }//eof if
    sqlite3_close(database);
    return arrayStudent;
}

+(NSMutableArray *)getAllCourses
{
    NSMutableArray *arrayCourses= [[NSMutableArray alloc]init];
    
    //execute SQL on DataBase to get Student table
    
    NSString *query = @"select * from course";
    
    //open the database,sqlite3 is structure
    
    sqlite3 *database;
    //sqlite3_open(<#const char *filename#>, <#sqlite3 **ppDb#>)
    //call dbPath method and covert it to char usin UTF*String as *filename in above syntax
    //tis is like getreadable and getWritable
    int result = sqlite3_open([[Databasehelper dbPath] UTF8String], &database);
    
    if (result == SQLITE_OK)//sucess
    {
        sqlite3_stmt *stmt;
        //execute query
        int selectResult = sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, NULL);
        if (selectResult == SQLITE_OK)//sucess
        {
            //read one row at a time
            while(sqlite3_step(stmt) == SQLITE_ROW) //sucess in moving to next row
            {
                //read data of current row
                int course_id = sqlite3_column_int(stmt, 0);
                const unsigned char *course_name = sqlite3_column_text(stmt, 1);
                //double percent = sqlite3_column_double(stmt, 2);
               // int course_id = sqlite3_column_int(stmt, 3);
                
                Course *s1 = [[Course alloc]init];
                s1.course_id = course_id;
                s1.course_name = [NSString stringWithUTF8String:course_name];
                [arrayCourses addObject:s1];
                
                NSLog(@"%d.%@",s1.course_id,s1.course_name);
            }//eof while
        }//eof if
    }//eof if
    sqlite3_close(database);
    return arrayCourses;
}

+(char *)insertStudent:(Student *)student
{
    char *err;
    NSString *query =[NSString stringWithFormat:@"insert into student(rollno,name,percent,course_id) values(%d,'%@',%f,%d)",student.rollo,student.name,student.percent,student.course_id];
    
    //open database and execute query
    
    sqlite3 *database;
    
    int openResult = sqlite3_open([[Databasehelper dbPath] UTF8String], &database);
    if (openResult == SQLITE_OK)//db is opened
    
    {
       
        int result = sqlite3_exec(database, [query UTF8String],NULL, NULL, &err);
        NSLog(@"error is %s,result is %d ",err,result);
    }
    
    sqlite3_close(database);
    return err;
}

+(char *)deleteStudent:(Student *)student
{
    char *err;
    NSString *query =[NSString stringWithFormat:@"delete from student where rollno = %d",student.rollo];
    
    //open database and execute query
    
    sqlite3 *database;
    
    int openResult = sqlite3_open([[Databasehelper dbPath] UTF8String], &database);
    if (openResult == SQLITE_OK)//db is opened
        
    {
        
        int result = sqlite3_exec(database, [query UTF8String],NULL, NULL, &err);
        NSLog(@"error is %s,result is %d ",err,result);
    }
    
    sqlite3_close(database);
    return err;
}

+(char *)insertCourse:(Course *)course
{
        char *err;
        NSString *query =[NSString stringWithFormat:@"insert into course(course_id,course_name,course_coordinator) values(%d,'%@','%@')",course.course_id,course.course_name,course.coordinator];
        
        //open database and execute query
        
        sqlite3 *database;
        
        int openResult = sqlite3_open([[Databasehelper dbPath] UTF8String], &database);
        if (openResult == SQLITE_OK)//db is opened
            
        {
            
            int result = sqlite3_exec(database, [query UTF8String],NULL, NULL, &err);
            NSLog(@"error is %s,result is %d ",err,result);
        }
        
        sqlite3_close(database);
        return err;
}

@end

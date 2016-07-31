//
//  Databasehelper.h
//  SQLiteProgramming
//
//  Created by Rajesh on 15/12/15.
//  Copyright (c) 2015 CDAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Course.h"

@interface Databasehelper : NSObject

+(NSString *)dbPath;


//methaod that will read data from db
+(NSMutableArray *)getAllStudent;

+(char *)insertStudent:(Student *)student;

+(char *)deleteStudent :(Student *)student;

+(char *)insertCourse:(Course *)course;

+(NSMutableArray *)getAllCourses;
@end

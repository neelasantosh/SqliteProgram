//
//  Course.m
//  SQLiteProgramming
//
//  Created by Rajesh on 15/12/15.
//  Copyright (c) 2015 CDAC. All rights reserved.
//

#import "Course.h"

@implementation Course
@synthesize course_id,coordinator,course_name;
-(NSString *)description
{
    NSString *str=[NSString stringWithFormat:@"%d.%@",course_id,course_name];
    return str;
}
@end

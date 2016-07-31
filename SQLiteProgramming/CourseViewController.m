//
//  CourseViewController.m
//  SQLiteProgramming
//
//  Created by Rajesh on 15/12/15.
//  Copyright (c) 2015 CDAC. All rights reserved.
//

#import "CourseViewController.h"
#import "Course.h"
#import "Databasehelper.h"

@interface CourseViewController ()

@end

@implementation CourseViewController
@synthesize textCourseID,textCourseName,textCoordinator,tableViewCourses,arrayCourses;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"Courses";
    arrayCourses = [Databasehelper getAllCourses];
    [tableViewCourses reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayCourses.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ActionAddCourse:(id)sender
{
    Course *c=[[Course alloc]init];
    c.course_id=[textCourseID.text intValue];
    c.course_name=textCourseName.text;
    c.coordinator=textCoordinator.text;
    
    [Databasehelper insertCourse:c];
}
@end

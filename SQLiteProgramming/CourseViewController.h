//
//  CourseViewController.h
//  SQLiteProgramming
//
//  Created by Rajesh on 15/12/15.
//  Copyright (c) 2015 CDAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textCourseID;
@property (strong, nonatomic) IBOutlet UITextField *textCourseName;
@property (strong, nonatomic) IBOutlet UITextField *textCoordinator;
- (IBAction)ActionAddCourse:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableViewCourses;

@property NSMutableArray *arrayCourses;
@end

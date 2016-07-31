//
//  ViewController.m
//  SQLiteProgramming
//
//  Created by Rajesh on 15/12/15.
//  Copyright (c) 2015 CDAC. All rights reserved.
//

#import "ViewController.h"
#import "Databasehelper.h"
#import "Student.h"
#import "Course.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize textName,textPercent,textRollno,pickerViewCourse,arrayCourses;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayCourses=[Databasehelper getAllCourses];
    
    pickerViewCourse.dataSource=self;
    pickerViewCourse.delegate=self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return arrayCourses.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *rowdata=@"";
    rowdata=[[arrayCourses objectAtIndex:row] description];
    return rowdata;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    

    Student *s =[[Student alloc]init];
    s.name = textName.text;
    s.rollo = [textRollno.text intValue];
    s.percent = [textPercent.text floatValue];
    
    
    int a=[pickerViewCourse selectedRowInComponent:0];
    Course *c=[arrayCourses objectAtIndex:a];
    s.course_id=c.course_id;

    char *error = [Databasehelper insertStudent:s];
    if (error == NULL)
    {
        textName.text = @"";
        textPercent.text =@"";
        textRollno.text = @"";
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"error" message:[NSString stringWithUTF8String:error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}
@end

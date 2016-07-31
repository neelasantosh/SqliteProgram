//
//  ViewController.h
//  SQLiteProgramming
//
//  Created by Rajesh on 15/12/15.
//  Copyright (c) 2015 CDAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textRollno;

@property (strong, nonatomic) IBOutlet UITextField *textName;
@property (strong, nonatomic) IBOutlet UITextField *textPercent;

@property (strong, nonatomic) IBOutlet UIPickerView *pickerViewCourse;
@property NSMutableArray *arrayCourses;
- (IBAction)submit:(id)sender;

@end


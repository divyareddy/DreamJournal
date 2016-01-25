//
//  NewGoalViewController.h
//  DreamJournal
//
//  Created by Divya Reddy on 15/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface NewGoalViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
- (IBAction)saveButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
- (IBAction)cancelButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *descriptionText;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
- (IBAction)datePickButton:(UIButton *)sender;
@property (strong, nonatomic)  UIDatePicker *datePicker;


@property (strong,nonatomic) UITapGestureRecognizer *singleTap;
@property (nonatomic,strong) UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UITextField *dateTextField;

@end

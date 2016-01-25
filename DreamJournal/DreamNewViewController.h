//
//  DreamNewViewController.h
//  DreamJournal
//
//  Created by Divya Reddy on 15/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "NIDropDown.h"
#import <Parse/Parse.h>
#import <CoreData/CoreData.h>
@interface DreamNewViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate,NIDropDownDelegate,UITextFieldDelegate>
{
        NIDropDown *dropDown;
}
@property (strong, nonatomic) IBOutlet UITextField *emotionTF;
- (IBAction)saveButtonClicked:(id)sender;

@property (copy, nonatomic) void (^addDateCompletionBlock)(void);


- (IBAction)cancelButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *dreamNameText;
@property (strong, nonatomic) IBOutlet UITextField *dreamDescText;
- (IBAction)datePickButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
- (IBAction)clarityClicked:(id)sender;
@property (strong,nonatomic) UITapGestureRecognizer *singleTap;
@property (strong, nonatomic)  UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *dateTF;
@property (strong, nonatomic) IBOutlet UIButton *moodButton;
- (IBAction)contactPicker:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *clarityButton;
- (IBAction)moodClicked:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *contactName;

@end

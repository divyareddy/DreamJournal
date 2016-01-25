//
//  DreamNewViewController.m
//  DreamJournal
//
//  Created by Divya Reddy on 15/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import "DreamNewViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import "SDCoreDataController.h"
#import "Reachability.h"
@interface DreamNewViewController ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObject *context;
@end

@implementation DreamNewViewController
@synthesize datePicker,singleTap;
@synthesize managedObjectContext;
@synthesize context;
@synthesize addDateCompletionBlock;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.dateLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *dateTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateTapped)];
    [self.dateLabel addGestureRecognizer:dateTapRecognizer];
    
    
    self.managedObjectContext = [[SDCoreDataController sharedInstance] newManagedObjectContext];
    self.context = [NSEntityDescription insertNewObjectForEntityForName:@"Dreams" inManagedObjectContext:self.managedObjectContext];

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)contactPicker:(id)sender {
    
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
}


- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    [self displayPerson:person];
     [self dismissViewControllerAnimated:YES completion:nil];
    
    return NO;
}


- (void)displayPerson:(ABRecordRef)person
{
    NSString* name = ( NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    self.contactName.text = name;
    
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = ( NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"[None]";
    }
   // self.phoneNumber.text = phone;
    CFRelease(phoneNumbers);
}
- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

- (IBAction)moodClicked:(UIButton *)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Normal", @"Happy", @"Sad", @"Bad", @"Good",nil];
   NSArray * arrImage = [[NSArray alloc] init];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
 
    
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}

- (IBAction)datePickButton:(id)sender {
    
    datePicker = [[UIDatePicker alloc] init];

    datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker addTarget:self action:@selector(dateHasChanged:) forControlEvents:UIControlEventValueChanged];
    CGSize pickerSize = [datePicker sizeThatFits:CGSizeZero];
    datePicker.frame = CGRectMake(0.0, 200, pickerSize.width, 460);
    datePicker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:datePicker];
    
    
    self.dateTF.inputView = datePicker;

    
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    //Hide keyBoard
    [self.view endEditing:YES];
    [self hidePicker];
    
}


- (void) dateTapped {
    [self singleTapGestureCaptured:singleTap];
    [datePicker removeFromSuperview];
    
}

- (void)dateHasChanged:(id) sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    self.dateTF.text = [dateFormatter stringFromDate:[self.datePicker date]];    //self.dateLabel.text = [formatter stringFromDate:self.datePicker.date];
    [self hidePicker];
    
}

- (void) showPicker {
    
    
    [UIView beginAnimations:@"SlideInPicker" context:nil];
    [UIView setAnimationDuration:0.5];
    self.datePicker.transform = CGAffineTransformMakeTranslation(0, -216);
    [UIView commitAnimations];
    
}

- (void) hidePicker {
    
    [UIView beginAnimations:@"SlideOutPicker" context:nil];
    [UIView setAnimationDuration:0.5];
    self.datePicker.transform = CGAffineTransformMakeTranslation(0, 216);
    [UIView commitAnimations];
    
}

- (IBAction)clarityClicked:(id)sender {
    
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Normal", @"Vivid", @"Blurry", @"Scary", nil];
    NSArray * arrImage = [[NSArray alloc] init];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
    
}
- (IBAction)saveButtonClicked:(id)sender {
    
    if ([self.dreamNameText.text isEqualToString:@""]&&[self.dateTF.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Input" message:@"Please enter atleast a name and date..." delegate:self cancelButtonTitle:Nil otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    else{
        
        Reachability* wifiReach = [Reachability reachabilityForLocalWiFi];
        
        NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
        
        if (netStatus!=ReachableViaWiFi)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No WIFI available!", @"AlertView")
                                                                message:NSLocalizedString(@"You have no network connection available. Please connect to a WIFI network.", @"AlertView")
                                                               delegate:self
                                                      cancelButtonTitle:NSLocalizedString(@"Cancel", @"AlertView")
                                                      otherButtonTitles:NSLocalizedString(@"Ok", @"AlertView"), nil];
            [alertView show];
        }
        else{
        
        PFObject *testObject = [PFObject objectWithClassName:@"Dreams"];

                 [testObject setObject:self.dreamNameText.text forKey:@"name"];
                 [testObject setObject:self.dateTF.text forKey:@"date"];
                 [testObject setObject:self.dreamDescText.text forKey:@"dreamdescription"];
                 [testObject setObject:self.moodButton.titleLabel.text forKey:@"mood"];
                 [testObject setObject:self.clarityButton.titleLabel.text forKey:@"clarity"];
                 [testObject setObject:self.emotionTF.text forKey:@"emotion"];
                 [testObject save];
                 
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Changes Saved" message:@"Successfully saved data" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                 [alert show];

    }
}
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"] invertedSet];
    
    //NSString *trimmedReplacement =
    //[[ string  componentsSeparatedByCharactersInSet:nonNumberSet]
     //componentsJoinedByString:@""];
    
    return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.dreamNameText) {
        [textField resignFirstResponder];
    }
    if (textField == self.dreamDescText) {
        [textField resignFirstResponder];
    }
    if (textField == self.emotionTF) {
        [textField resignFirstResponder];
    }
    if (textField == self.dateTF) {
        [textField resignFirstResponder];
    }
    
    
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


- (IBAction)cancelButtonClicked:(id)sender {
    
    self.dreamNameText.text = @"";
    self.dreamDescText.text = @"";
    self.moodButton.titleLabel.text = @"";
    self.clarityButton.titleLabel.text = @"";
    self.emotionTF.text = @"";
    self.dateTF.text = @"";
}
@end

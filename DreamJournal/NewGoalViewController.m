//
//  NewGoalViewController.m
//  DreamJournal
//
//  Created by Divya Reddy on 15/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import "NewGoalViewController.h"
#import "Reachability.h"

@interface NewGoalViewController ()

@end

@implementation NewGoalViewController
@synthesize datePicker,toolbar,singleTap;

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
    

    
    self.nameTextField.delegate = self;
    self.dateTextField.delegate = self;
    self.descriptionText.delegate = self;
    
    
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self.view addGestureRecognizer:singleTap];
    
    // Additional set up for date time Picker
    
    self.dateLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *dateTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateTapped)];
    [self.dateLabel addGestureRecognizer:dateTapRecognizer];
    
    // setting labels background
   // self.dateLabel.backgroundColor = [UIColor lightGrayColor];
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];

	// Do any additional setup after loading the view.
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameTextField) {
        [textField resignFirstResponder];
    }
    if (textField == self.dateTextField) {
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)datePickButton:(UIButton *)sender {
    
    datePicker = [[UIDatePicker alloc] init];
    toolbar= [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    
   
    datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker addTarget:self action:@selector(dateHasChanged:) forControlEvents:UIControlEventValueChanged];
    CGSize pickerSize = [datePicker sizeThatFits:CGSizeZero];
    datePicker.frame = CGRectMake(0.0, 200, pickerSize.width, 460);
    datePicker.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:datePicker];
    
    
    self.dateTextField.inputView = datePicker;

    
}

- (void)dateHasChanged:(id) sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    self.dateTextField.text = [dateFormatter stringFromDate:[self.datePicker date]];    //self.dateLabel.text = [formatter stringFromDate:self.datePicker.date];
    [self hidePicker];
    
}
- (IBAction)saveButtonClicked:(id)sender {
    
    if ([self.nameTextField.text isEqualToString:@""]&&[self.dateTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oh..." message:@"Please enter atleast a name and date..." delegate:self cancelButtonTitle:Nil otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    else{
        
        Reachability* wifiReach = [Reachability reachabilityForLocalWiFi];
        
        NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
        
        if (netStatus!=ReachableViaWiFi)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No WIFI available!", @"AlertView")
                                                                message:NSLocalizedString(@"You have no wifi connection available. Please connect to a WIFI network.", @"AlertView")
                                                               delegate:self
                                                      cancelButtonTitle:NSLocalizedString(@"Cancel", @"AlertView")
                                                      otherButtonTitles:NSLocalizedString(@"Ok", @"AlertView"), nil];
            [alertView show];
        }
        else{

        PFObject *testObject = [PFObject objectWithClassName:@"Goals"];
        [testObject setObject:self.nameTextField.text forKey:@"name"];
        [testObject setObject:self.dateTextField.text forKey:@"date"];
        [testObject setObject:self.descriptionText.text forKey:@"goaldescription"];
        [testObject save];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Changes Saved" message:@"Successfully saved data" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }
    
}
- (IBAction)cancelButtonPressed:(id)sender {
    
    self.nameTextField.text = @"";
    self.dateTextField.text=@"";
    self.descriptionText.text = @"";
}
@end

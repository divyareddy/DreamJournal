//
//  GoalsViewController.h
//  DreamJournal
//
//  Created by Divya Reddy on 15/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainViewAppDelegate.h"
@interface GoalsViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) NSArray *dates;
@property (nonatomic, strong) NSString *entityName;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
- (IBAction)refreshButtonTouched:(id)sender;


@end

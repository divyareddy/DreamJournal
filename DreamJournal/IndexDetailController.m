//
//  IndexDetailController.m
//  DreamJournal
//
//  Created by Divya Reddy on 16/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import "IndexDetailController.h"

@interface IndexDetailController ()

@end

@implementation IndexDetailController

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
    
    self.nameText.text = self.name;
    
    self.descText.text = self.description;
    
      self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

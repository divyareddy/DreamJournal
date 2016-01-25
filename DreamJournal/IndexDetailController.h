//
//  IndexDetailController.h
//  DreamJournal
//
//  Created by Divya Reddy on 16/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexDetailController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *nameText;
@property (strong, nonatomic) IBOutlet UITextView *descText;

@property (strong,nonatomic) NSString *name, *description;
@end

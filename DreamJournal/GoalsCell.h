//
//  GoalsCell.h
//  DreamJournal
//
//  Created by Divya Reddy on 17/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoalsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *goalName;

@property (strong, nonatomic) IBOutlet UILabel *goalDesc;
@property (strong, nonatomic) IBOutlet UILabel *goalDate;

@end

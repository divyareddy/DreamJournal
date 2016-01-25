//
//  DreamsCell.h
//  DreamJournal
//
//  Created by Divya Reddy on 20/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DreamsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dreamName;

@property (strong, nonatomic) IBOutlet UILabel *dreamDesc;
@property (strong, nonatomic) IBOutlet UILabel *dreamDate;
@property (strong, nonatomic) IBOutlet UILabel *mood;

@property (strong, nonatomic) IBOutlet UILabel *clarity;
@property (strong, nonatomic) IBOutlet UILabel *emotion;
@end

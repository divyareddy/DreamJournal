//
//  GoalsCell.m
//  DreamJournal
//
//  Created by Divya Reddy on 17/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import "GoalsCell.h"

@implementation GoalsCell
@synthesize goalDate,goalDesc,goalName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

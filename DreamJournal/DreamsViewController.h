//
//  DreamsViewController.h
//  DreamJournal
//
//  Created by Divya Reddy on 15/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Parse/Parse.h>

@interface DreamsViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) NSArray *dreams;
@property (nonatomic, strong) NSString *entityName;



@end

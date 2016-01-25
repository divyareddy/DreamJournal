//
//  Goals.h
//  DreamJournal
//
//  Created by Divya Reddy on 23/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Goals : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * goaldescription;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSDate * updatedAt;

@end

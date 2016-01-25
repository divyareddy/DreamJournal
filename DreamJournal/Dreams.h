//
//  Dreams.h
//  DreamJournal
//
//  Created by Divya Reddy on 23/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Dreams : NSManagedObject

@property (nonatomic, retain) NSString * clarity;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * dreamdescription;
@property (nonatomic, retain) NSString * emotion;
@property (nonatomic, retain) NSString * mood;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSDate * updatedAt;

@end

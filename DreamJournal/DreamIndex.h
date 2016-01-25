//
//  DreamIndex.h
//  DreamJournal
//
//  Created by Divya Reddy on 23/11/13.
//  Copyright (c) 2013 Swinburne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DreamIndex : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * meaning;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSString * objectId;

@end

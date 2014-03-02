//
//  Action.h
//  FinalYear_v0.2
//
//  Created by H QS on 14-2-25.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Date, Person, Place;

@interface Action : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *toDate;
@property (nonatomic, retain) NSSet *toPerson;
@property (nonatomic, retain) NSSet *toPlace;
@end

@interface Action (CoreDataGeneratedAccessors)

- (void)addToDateObject:(Date *)value;
- (void)removeToDateObject:(Date *)value;
- (void)addToDate:(NSSet *)values;
- (void)removeToDate:(NSSet *)values;

- (void)addToPersonObject:(Person *)value;
- (void)removeToPersonObject:(Person *)value;
- (void)addToPerson:(NSSet *)values;
- (void)removeToPerson:(NSSet *)values;

- (void)addToPlaceObject:(Place *)value;
- (void)removeToPlaceObject:(Place *)value;
- (void)addToPlace:(NSSet *)values;
- (void)removeToPlace:(NSSet *)values;

@end

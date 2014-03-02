//
//  Person.h
//  FinalYear_v0.4
//
//  Created by H QS on 14-2-25.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Date, Place;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *fromAction;
@property (nonatomic, retain) NSSet *toDate;
@property (nonatomic, retain) NSSet *toPlace;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addFromActionObject:(NSManagedObject *)value;
- (void)removeFromActionObject:(NSManagedObject *)value;
- (void)addFromAction:(NSSet *)values;
- (void)removeFromAction:(NSSet *)values;

- (void)addToDateObject:(Date *)value;
- (void)removeToDateObject:(Date *)value;
- (void)addToDate:(NSSet *)values;
- (void)removeToDate:(NSSet *)values;

- (void)addToPlaceObject:(Place *)value;
- (void)removeToPlaceObject:(Place *)value;
- (void)addToPlace:(NSSet *)values;
- (void)removeToPlace:(NSSet *)values;

@end

//
//  Person.h
//  FinalYear_v0.3
//
//  Created by H QS on 14-1-13.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Action, Date, Place;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *actionFromPerson;
@property (nonatomic, retain) NSSet *personToDate;
@property (nonatomic, retain) NSSet *personToPlace;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addActionFromPersonObject:(Action *)value;
- (void)removeActionFromPersonObject:(Action *)value;
- (void)addActionFromPerson:(NSSet *)values;
- (void)removeActionFromPerson:(NSSet *)values;

- (void)addPersonToDateObject:(Date *)value;
- (void)removePersonToDateObject:(Date *)value;
- (void)addPersonToDate:(NSSet *)values;
- (void)removePersonToDate:(NSSet *)values;

- (void)addPersonToPlaceObject:(Place *)value;
- (void)removePersonToPlaceObject:(Place *)value;
- (void)addPersonToPlace:(NSSet *)values;
- (void)removePersonToPlace:(NSSet *)values;

@end

//
//  Action.h
//  FinalYear_v0.3
//
//  Created by H QS on 14-1-13.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Date, Person, Place;

@interface Action : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *actionToPerson;
@property (nonatomic, retain) NSSet *actionToDate;
@property (nonatomic, retain) NSSet *actionToPlace;
@end

@interface Action (CoreDataGeneratedAccessors)

- (void)addActionToPersonObject:(Person *)value;
- (void)removeActionToPersonObject:(Person *)value;
- (void)addActionToPerson:(NSSet *)values;
- (void)removeActionToPerson:(NSSet *)values;

- (void)addActionToDateObject:(Date *)value;
- (void)removeActionToDateObject:(Date *)value;
- (void)addActionToDate:(NSSet *)values;
- (void)removeActionToDate:(NSSet *)values;

- (void)addActionToPlaceObject:(Place *)value;
- (void)removeActionToPlaceObject:(Place *)value;
- (void)addActionToPlace:(NSSet *)values;
- (void)removeActionToPlace:(NSSet *)values;

@end

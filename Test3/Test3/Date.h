//
//  Date.h
//  Test3
//
//  Created by H QS on 14-3-2.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Action, Date, Person, Place;

@interface Date : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *belongsToActions;
@property (nonatomic, retain) NSSet *belongsToPersons;
@property (nonatomic, retain) NSSet *belongsToPlace;
@property (nonatomic, retain) NSSet *hasManyDate;
@property (nonatomic, retain) NSSet *belongsToDate;
@end

@interface Date (CoreDataGeneratedAccessors)

- (void)addBelongsToActionsObject:(Action *)value;
- (void)removeBelongsToActionsObject:(Action *)value;
- (void)addBelongsToActions:(NSSet *)values;
- (void)removeBelongsToActions:(NSSet *)values;

- (void)addBelongsToPersonsObject:(Person *)value;
- (void)removeBelongsToPersonsObject:(Person *)value;
- (void)addBelongsToPersons:(NSSet *)values;
- (void)removeBelongsToPersons:(NSSet *)values;

- (void)addBelongsToPlaceObject:(Place *)value;
- (void)removeBelongsToPlaceObject:(Place *)value;
- (void)addBelongsToPlace:(NSSet *)values;
- (void)removeBelongsToPlace:(NSSet *)values;

- (void)addHasManyDateObject:(Date *)value;
- (void)removeHasManyDateObject:(Date *)value;
- (void)addHasManyDate:(NSSet *)values;
- (void)removeHasManyDate:(NSSet *)values;

- (void)addBelongsToDateObject:(Date *)value;
- (void)removeBelongsToDateObject:(Date *)value;
- (void)addBelongsToDate:(NSSet *)values;
- (void)removeBelongsToDate:(NSSet *)values;

@end

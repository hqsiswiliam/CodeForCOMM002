//
//  Person.h
//  Test3
//
//  Created by H QS on 14-3-2.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Action, Date, Person, Place;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *belongsToActions;
@property (nonatomic, retain) NSSet *hasManyDates;
@property (nonatomic, retain) NSSet *hasManyPlaces;
@property (nonatomic, retain) NSSet *hasManyPersons;
@property (nonatomic, retain) NSSet *belongsToPersons;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addBelongsToActionsObject:(Action *)value;
- (void)removeBelongsToActionsObject:(Action *)value;
- (void)addBelongsToActions:(NSSet *)values;
- (void)removeBelongsToActions:(NSSet *)values;

- (void)addHasManyDatesObject:(Date *)value;
- (void)removeHasManyDatesObject:(Date *)value;
- (void)addHasManyDates:(NSSet *)values;
- (void)removeHasManyDates:(NSSet *)values;

- (void)addHasManyPlacesObject:(Place *)value;
- (void)removeHasManyPlacesObject:(Place *)value;
- (void)addHasManyPlaces:(NSSet *)values;
- (void)removeHasManyPlaces:(NSSet *)values;

- (void)addHasManyPersonsObject:(Person *)value;
- (void)removeHasManyPersonsObject:(Person *)value;
- (void)addHasManyPersons:(NSSet *)values;
- (void)removeHasManyPersons:(NSSet *)values;

- (void)addBelongsToPersonsObject:(Person *)value;
- (void)removeBelongsToPersonsObject:(Person *)value;
- (void)addBelongsToPersons:(NSSet *)values;
- (void)removeBelongsToPersons:(NSSet *)values;

@end

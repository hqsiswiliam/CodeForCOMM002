//
//  Place.h
//  Test3
//
//  Created by H QS on 14-2-25.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Action, Date, Person;

@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *belongsToPersons;
@property (nonatomic, retain) NSSet *hasManyDates;
@property (nonatomic, retain) NSSet *belongsToActions;
@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addBelongsToPersonsObject:(Person *)value;
- (void)removeBelongsToPersonsObject:(Person *)value;
- (void)addBelongsToPersons:(NSSet *)values;
- (void)removeBelongsToPersons:(NSSet *)values;

- (void)addHasManyDatesObject:(Date *)value;
- (void)removeHasManyDatesObject:(Date *)value;
- (void)addHasManyDates:(NSSet *)values;
- (void)removeHasManyDates:(NSSet *)values;

- (void)addBelongsToActionsObject:(Action *)value;
- (void)removeBelongsToActionsObject:(Action *)value;
- (void)addBelongsToActions:(NSSet *)values;
- (void)removeBelongsToActions:(NSSet *)values;

@end

//
//  Person.h
//  Test3
//
//  Created by H QS on 14-2-25.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Action, Date;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *belongsToActions;
@property (nonatomic, retain) NSSet *hasManyPlaces;
@property (nonatomic, retain) NSSet *hasManyDates;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addBelongsToActionsObject:(Action *)value;
- (void)removeBelongsToActionsObject:(Action *)value;
- (void)addBelongsToActions:(NSSet *)values;
- (void)removeBelongsToActions:(NSSet *)values;

- (void)addHasManyPlacesObject:(NSManagedObject *)value;
- (void)removeHasManyPlacesObject:(NSManagedObject *)value;
- (void)addHasManyPlaces:(NSSet *)values;
- (void)removeHasManyPlaces:(NSSet *)values;

- (void)addHasManyDatesObject:(Date *)value;
- (void)removeHasManyDatesObject:(Date *)value;
- (void)addHasManyDates:(NSSet *)values;
- (void)removeHasManyDates:(NSSet *)values;

@end

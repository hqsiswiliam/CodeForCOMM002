//
//  Action.h
//  Test3
//
//  Created by H QS on 14-2-25.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Date;

@interface Action : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *hasManyPersons;
@property (nonatomic, retain) NSSet *hasManyPlaces;
@property (nonatomic, retain) NSSet *hasManyDates;
@end

@interface Action (CoreDataGeneratedAccessors)

- (void)addHasManyPersonsObject:(NSManagedObject *)value;
- (void)removeHasManyPersonsObject:(NSManagedObject *)value;
- (void)addHasManyPersons:(NSSet *)values;
- (void)removeHasManyPersons:(NSSet *)values;

- (void)addHasManyPlacesObject:(NSManagedObject *)value;
- (void)removeHasManyPlacesObject:(NSManagedObject *)value;
- (void)addHasManyPlaces:(NSSet *)values;
- (void)removeHasManyPlaces:(NSSet *)values;

- (void)addHasManyDatesObject:(Date *)value;
- (void)removeHasManyDatesObject:(Date *)value;
- (void)addHasManyDates:(NSSet *)values;
- (void)removeHasManyDates:(NSSet *)values;

@end

//
//  Date.h
//  Test3
//
//  Created by H QS on 14-2-25.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Date : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *belongsToPlace;
@property (nonatomic, retain) NSSet *belongsToActions;
@property (nonatomic, retain) NSSet *belongsToPersons;
@end

@interface Date (CoreDataGeneratedAccessors)

- (void)addBelongsToPlaceObject:(NSManagedObject *)value;
- (void)removeBelongsToPlaceObject:(NSManagedObject *)value;
- (void)addBelongsToPlace:(NSSet *)values;
- (void)removeBelongsToPlace:(NSSet *)values;

- (void)addBelongsToActionsObject:(NSManagedObject *)value;
- (void)removeBelongsToActionsObject:(NSManagedObject *)value;
- (void)addBelongsToActions:(NSSet *)values;
- (void)removeBelongsToActions:(NSSet *)values;

- (void)addBelongsToPersonsObject:(NSManagedObject *)value;
- (void)removeBelongsToPersonsObject:(NSManagedObject *)value;
- (void)addBelongsToPersons:(NSSet *)values;
- (void)removeBelongsToPersons:(NSSet *)values;

@end

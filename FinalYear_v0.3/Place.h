//
//  Place.h
//  FinalYear_v0.3
//
//  Created by H QS on 14-1-13.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Action, Date, Person;

@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *personFromPlace;
@property (nonatomic, retain) NSSet *actionFromPlace;
@property (nonatomic, retain) NSSet *placeToDate;
@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addPersonFromPlaceObject:(Person *)value;
- (void)removePersonFromPlaceObject:(Person *)value;
- (void)addPersonFromPlace:(NSSet *)values;
- (void)removePersonFromPlace:(NSSet *)values;

- (void)addActionFromPlaceObject:(Action *)value;
- (void)removeActionFromPlaceObject:(Action *)value;
- (void)addActionFromPlace:(NSSet *)values;
- (void)removeActionFromPlace:(NSSet *)values;

- (void)addPlaceToDateObject:(Date *)value;
- (void)removePlaceToDateObject:(Date *)value;
- (void)addPlaceToDate:(NSSet *)values;
- (void)removePlaceToDate:(NSSet *)values;

@end

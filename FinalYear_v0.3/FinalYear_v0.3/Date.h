//
//  Date.h
//  FinalYear_v0.3
//
//  Created by H QS on 14-1-13.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Action, Person, Place;

@interface Date : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *personFromDate;
@property (nonatomic, retain) NSSet *actionFromDate;
@property (nonatomic, retain) NSSet *placeFromDate;
@end

@interface Date (CoreDataGeneratedAccessors)

- (void)addPersonFromDateObject:(Person *)value;
- (void)removePersonFromDateObject:(Person *)value;
- (void)addPersonFromDate:(NSSet *)values;
- (void)removePersonFromDate:(NSSet *)values;

- (void)addActionFromDateObject:(Action *)value;
- (void)removeActionFromDateObject:(Action *)value;
- (void)addActionFromDate:(NSSet *)values;
- (void)removeActionFromDate:(NSSet *)values;

- (void)addPlaceFromDateObject:(Place *)value;
- (void)removePlaceFromDateObject:(Place *)value;
- (void)addPlaceFromDate:(NSSet *)values;
- (void)removePlaceFromDate:(NSSet *)values;

@end

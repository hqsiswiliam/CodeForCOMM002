//
//  Date.h
//  FinalYear_v0.2
//
//  Created by H QS on 14-2-25.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Action, Person, Place;

@interface Date : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *fromAction;
@property (nonatomic, retain) NSSet *fromPerson;
@property (nonatomic, retain) NSSet *fromPlace;
@end

@interface Date (CoreDataGeneratedAccessors)

- (void)addFromActionObject:(Action *)value;
- (void)removeFromActionObject:(Action *)value;
- (void)addFromAction:(NSSet *)values;
- (void)removeFromAction:(NSSet *)values;

- (void)addFromPersonObject:(Person *)value;
- (void)removeFromPersonObject:(Person *)value;
- (void)addFromPerson:(NSSet *)values;
- (void)removeFromPerson:(NSSet *)values;

- (void)addFromPlaceObject:(Place *)value;
- (void)removeFromPlaceObject:(Place *)value;
- (void)addFromPlace:(NSSet *)values;
- (void)removeFromPlace:(NSSet *)values;

@end

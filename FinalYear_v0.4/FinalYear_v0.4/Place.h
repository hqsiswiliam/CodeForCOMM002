//
//  Place.h
//  FinalYear_v0.4
//
//  Created by H QS on 14-2-25.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Date, Person;

@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *fromAction;
@property (nonatomic, retain) NSSet *fromPerson;
@property (nonatomic, retain) NSSet *toDate;
@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addFromActionObject:(NSManagedObject *)value;
- (void)removeFromActionObject:(NSManagedObject *)value;
- (void)addFromAction:(NSSet *)values;
- (void)removeFromAction:(NSSet *)values;

- (void)addFromPersonObject:(Person *)value;
- (void)removeFromPersonObject:(Person *)value;
- (void)addFromPerson:(NSSet *)values;
- (void)removeFromPerson:(NSSet *)values;

- (void)addToDateObject:(Date *)value;
- (void)removeToDateObject:(Date *)value;
- (void)addToDate:(NSSet *)values;
- (void)removeToDate:(NSSet *)values;

@end

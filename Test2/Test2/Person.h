//
//  Person.h
//  Test2
//
//  Created by H QS on 14-2-25.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *belongsToActions;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addBelongsToActionsObject:(NSManagedObject *)value;
- (void)removeBelongsToActionsObject:(NSManagedObject *)value;
- (void)addBelongsToActions:(NSSet *)values;
- (void)removeBelongsToActions:(NSSet *)values;

@end

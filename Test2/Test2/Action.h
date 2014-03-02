//
//  Action.h
//  Test2
//
//  Created by H QS on 14-2-25.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Action : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSSet *hasManyPerson;
@end

@interface Action (CoreDataGeneratedAccessors)

- (void)addHasManyPersonObject:(Person *)value;
- (void)removeHasManyPersonObject:(Person *)value;
- (void)addHasManyPerson:(NSSet *)values;
- (void)removeHasManyPerson:(NSSet *)values;

@end

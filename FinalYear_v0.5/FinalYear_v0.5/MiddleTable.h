//
//  MiddleTable.h
//  FinalYear_v0.5
//
//  Created by H QS on 14-3-6.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MiddleTable : NSManagedObject

@property (nonatomic, retain) NSNumber * idOfMyDate;
@property (nonatomic, retain) NSNumber * idOfPerson;
@property (nonatomic, retain) NSNumber * idOfPlace;
@property (nonatomic, retain) NSNumber * idOfThing;
@property (nonatomic, retain) NSNumber * idOfVerb;
@property (nonatomic, retain) NSNumber * row_id;

@end

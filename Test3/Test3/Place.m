//
//  Place.m
//  Test3
//
//  Created by H QS on 14-3-2.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "Place.h"
#import "Action.h"
#import "Date.h"
#import "Person.h"
#import "Place.h"


@implementation Place

@dynamic content;
@dynamic belongsToActions;
@dynamic belongsToPersons;
@dynamic hasManyDates;
@dynamic hasManyPlaces;
@dynamic belongsToPlaces;

@end

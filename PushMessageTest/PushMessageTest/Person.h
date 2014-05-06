//
//  Person.h
//  PushMessageTest
//
//  Created by H QS on 14-4-12.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kSetPersonInfoNotification;
extern NSString *const kSetPersonInfoKeyFirstName;
extern NSString *const kSetPersonInfoKeyLastName;
@interface Person : NSObject
@property(strong, nonatomic) NSString* firstName;
@property(strong, nonatomic) NSString* lastName;
@end

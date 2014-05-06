//
//  Person.m
//  PushMessageTest
//
//  Created by H QS on 14-4-12.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "Person.h"
@implementation Person{

}
- (void) handleSetPersonInfoNotification:(NSNotification *)paramNotification{
    
    self.firstName = paramNotification.userInfo[kSetPersonInfoKeyFirstName];
    self.lastName = paramNotification.userInfo[kSetPersonInfoKeyLastName];
    
}

- (instancetype) init{
    self = [super init];
    if (self != nil){
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        [center addObserver:self
                   selector:@selector(handleSetPersonInfoNotification:)
                       name:kSetPersonInfoNotification
                     object:[[UIApplication sharedApplication] delegate]];
        
    }
    return self;
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

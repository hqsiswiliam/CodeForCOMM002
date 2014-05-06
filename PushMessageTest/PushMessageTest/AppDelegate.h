//
//  AppDelegate.h
//  PushMessageTest
//
//  Created by H QS on 14-4-12.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const kSetPersonInfoNotification;
extern NSString *const kSetPersonInfoKeyFirstName;
extern NSString *const kSetPersonInfoKeyLastName;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

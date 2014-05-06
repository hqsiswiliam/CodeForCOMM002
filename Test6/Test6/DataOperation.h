//
//  DataOperation.h
//  Test4
//
//  Created by H QS on 14-3-5.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyDate.h"
#import "Verb.h"
#import "Thing.h"
#import "Person.h"
#import "Place.h"
#import "Element.h"
#import "MiddleTable.h"
#import "Latitude.h"
#import "Longtitude.h"
@interface DataOperation : NSObject
-(id)initWithManagedObjectContext:(NSManagedObjectContext*) moc;
-(BOOL)saveDataToDB:(NSString*) verb Thing:(NSString*)thing Person:(NSString*) person Place:(NSString*)place Date:(NSString*)date;
-(BOOL)saveDataToDB:(NSString*) verb Thing:(NSString*)thing Person:(NSString*) person Place:(NSString*)place Date:(NSString*)date Latitude:(NSString*)latitude Longtitude:(NSString*)longtitude;
-(NSArray*)retrieveAllQueryAsSentencesArray;

@end

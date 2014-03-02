//
//  OperationOnDataBase.h
//  Test3
//
//  Created by H QS on 14-2-25.
//  Copyright (c) 2014年 H QS. All rights reserved.
//
#import "Action.h"
#import "Person.h"
#import "Place.h"
#import "Date.h"
#import <Foundation/Foundation.h>

@interface OperationOnDataBase : NSObject
-(id)initWithManagedObjectContext:(NSManagedObjectContext*) moc;
-(BOOL)saveDataToDB:(NSString*) action Person:(NSString*) person Place:(NSString*)place Date:(NSString*)date;
-(NSArray*)retrieveAllQueryAsSentencesArray;
-(id)checkContentInDataModel:(NSString *)modelName content:(NSString*)content;
-(BOOL) deleteAllData;
-(BOOL)deletePersonsWithString:(NSString *)content;
-(BOOL)deleteActionsWithString:(NSString *)content;
-(BOOL)deletePlacesWithString:(NSString *)content;
-(BOOL)deleteDatesWithString:(NSString *)content;
@end

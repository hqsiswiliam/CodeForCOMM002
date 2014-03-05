//
//  DataOperation.h
//  Test4
//
//  Created by H QS on 14-3-5.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataOperation : NSObject
-(id)initWithManagedObjectContext:(NSManagedObjectContext*) moc;
-(BOOL)saveDataToDB:(NSString*) verb Thing:(NSString*)thing Person:(NSString*) person Place:(NSString*)place Date:(NSString*)date;
-(NSArray*)retrieveAllQueryAsSentencesArray;

@end

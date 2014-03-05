//
//  DataOperation.m
//  Test4
//
//  Created by H QS on 14-3-5.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "DataOperation.h"
#import "MyDate.h"
#import "Verb.h"
#import "Thing.h"
#import "Person.h"
#import "Place.h"
#import "Element.h"
#import "MiddleTable.h"

@implementation DataOperation{
    NSManagedObjectContext *_managedObjectContext;
}


-(id)initWithManagedObjectContext:(NSManagedObjectContext*) moc{
    self = [super init];
    if (!self) {
        return nil;
    }
    _managedObjectContext = moc;
    return self;
}
-(BOOL)saveDataToDB:(NSString*) verb Thing:(NSString*)thing Person:(NSString*) person Place:(NSString*)place Date:(NSString*)date{
//    MiddleTable* middleTable = [self LastIdOfMiddleTable];
    Verb* verbModel =nil;
//    if (verb!=nil) {
//        if ((verbModel=(Verb*)[self checkContent:verb InModel:@"Verb"])!=nil) {
//            //insert verbModel into New row in middleTable
//        }else{
//            //insert new one
//            verbModel = [NSEntityDescription insertNewObjectForEntityForName:@"Verb" inManagedObjectContext:_managedObjectContext];
//            verbModel.content = verb;
//            verbModel.row_id =[NSNumber numberWithInt:([[self LastIdOf:@"Verb"] intValue]+1)];
//        }
//    }
    

    NSError *error = nil;
    @try {
        verbModel = [NSEntityDescription insertNewObjectForEntityForName:@"Verb" inManagedObjectContext:_managedObjectContext];
        verbModel.content = verb;
        verbModel.row_id =[NSNumber numberWithInt:([[self LastIdOf:@"Verb"] intValue]+1)];
        if ([_managedObjectContext save:&error]) {
            return YES;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
//    if ([_managedObjectContext save:&error]) {
//        return YES;
//    }
    return NO;

}
//------------------
#pragma FetchRequest
//------------------
-(NSNumber*)LastIdOf:(NSString *)name{
    NSFetchRequest *fetchLast = [[NSFetchRequest alloc]initWithEntityName:name];
    [fetchLast setFetchLimit:1];
    //retrieve in descending order
    NSSortDescriptor *idSort = [[NSSortDescriptor alloc]initWithKey:@"id" ascending:NO];
    [fetchLast setSortDescriptors: @[idSort]];
    NSError *requestError = nil;
    NSArray *result = [_managedObjectContext executeFetchRequest:fetchLast error:&requestError];
    if (result!=nil) {
        NSNumber *idInModel = ((Element*)result[0]).row_id;
        return idInModel;
    }
    return 0;
}
//-(MiddleTable*)LastIdOfMiddleTable{
//    NSFetchRequest *fetchLast = [[NSFetchRequest alloc]initWithEntityName:@"MiddleTable"];
//    [fetchLast setFetchLimit:1];
//    //retrieve in descending order
//    NSSortDescriptor *idSort = [[NSSortDescriptor alloc]initWithKey:@"id" ascending:NO];
//    [fetchLast setSortDescriptors: @[idSort]];
//    NSError *requestError = nil;
//    NSArray *result = [_managedObjectContext executeFetchRequest:fetchLast error:&requestError];
//    if (result!=nil) {
//        return (MiddleTable*)(result[0]);
//    }
//    MiddleTable *t = [NSEntityDescription insertNewObjectForEntityForName:@"MiddleTable" inManagedObjectContext:_managedObjectContext];
//    t.row_id = 0;
//    NSError *savingError = nil;
//    [_managedObjectContext save:&savingError];
//    return t;
//}
-(NSArray*)retrieveAllQueryAsSentencesArray{
    NSError *error = nil;
    NSFetchRequest *fetchForVerb = [[NSFetchRequest alloc]initWithEntityName:@"Verb"];
    NSArray *verbs = [_managedObjectContext executeFetchRequest:fetchForVerb error:&error];
    for (Verb *v in verbs) {
        NSLog(@"id:%@, content:%@",v.row_id,v.content);
    }
    return nil;
}


//------------------
#pragma checkContent In model
//------------------
-(Element* )checkContent: (NSString*)content InModel:(NSString*)modelName{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:modelName];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"content == %@",content];
    [request setPredicate:predict];
    [request setFetchLimit:1];
    NSError *requestError = nil;
    NSArray *result = [_managedObjectContext executeFetchRequest:request error:&requestError];
    if ([result count]<1) {
        NSLog(@"No content matched in Action");
        return nil;
    }else{
        NSLog(@"Content found!");
    }
    return ((Element*)result[0]);
}
@end

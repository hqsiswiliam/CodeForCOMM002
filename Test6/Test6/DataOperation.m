//
//  DataOperation.m
//  Test4
//
//  Created by H QS on 14-3-5.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "DataOperation.h"


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
//check existing elements -> check existing sentences -> do saving or nothing.
-(BOOL)saveDataToDB:(NSString*) verb Thing:(NSString*)thing Person:(NSString*) person Place:(NSString*)place Date:(NSString*)date{
    Verb* verbModel =nil;
    Thing* thingModel = nil;
    Person* personModel = nil;
    Place* placeModel = nil;
    MyDate* dateModel = nil;
    long long row_id_verb = -1;
    long long row_id_thing = -1;
    long long row_id_person = -1;
    long long row_id_place = -1;
    long long row_id_my_date = -1;
    BOOL shouldDoSaveOperation = NO;
    //Data operation
    row_id_verb = [self insertContent:verb IntoDataModel:@"Verb" InstanceOfDataModel:verbModel];
    row_id_thing = [self insertContent:thing IntoDataModel:@"Thing" InstanceOfDataModel:thingModel];
    row_id_person = [self insertContent:person IntoDataModel:@"Person" InstanceOfDataModel:personModel];
    row_id_place = [self insertContent:place IntoDataModel:@"Place" InstanceOfDataModel:placeModel];
    row_id_my_date = [self insertContent:date IntoDataModel:@"MyDate" InstanceOfDataModel:dateModel];
    //Do middle table insert
    if (row_id_verb!=-1| row_id_thing!=-1|
        row_id_person!=-1|row_id_place!=-1|
        row_id_my_date!=-1) {
        if ([self checkExistanceInMiddleTable:row_id_verb Thing:row_id_thing Person:row_id_person Place:row_id_place Date:row_id_my_date]==nil) {
            MiddleTable *newRow = [NSEntityDescription insertNewObjectForEntityForName:@"MiddleTable" inManagedObjectContext:_managedObjectContext];
            newRow.row_id = [NSNumber numberWithLongLong:([[self LastIdOfMiddleTable] intValue]+1)];
            newRow.idOfVerb = [NSNumber numberWithLongLong:row_id_verb];
            newRow.idOfThing =  [NSNumber numberWithLongLong:row_id_thing];
            newRow.idOfPerson = [NSNumber numberWithLongLong:row_id_person];
            newRow.idOfPlace = [NSNumber numberWithLongLong:row_id_place];
            newRow.idOfMyDate = [NSNumber numberWithLongLong:row_id_my_date];
            shouldDoSaveOperation = YES;
        }
        
    }
    if (shouldDoSaveOperation) {
        NSError *error = nil;
        if ([_managedObjectContext save:&error]) {
            NSLog(@"Save Operation Done!!!");
            return YES;
        }
    }
    return NO;

}


-(BOOL)saveDataToDB:(NSString*) verb Thing:(NSString*)thing Person:(NSString*) person Place:(NSString*)place Date:(NSString*)date Latitude:(NSString*)latitude Longtitude:(NSString*)longtitude{
    Verb* verbModel =nil;
    Thing* thingModel = nil;
    Person* personModel = nil;
    Place* placeModel = nil;
    MyDate* dateModel = nil;
    Latitude *latModel = nil;
    Longtitude *longModel = nil;
    long long row_id_verb = -1;
    long long row_id_thing = -1;
    long long row_id_person = -1;
    long long row_id_place = -1;
    long long row_id_my_date = -1;
    long long row_id_latitude = -1;
    long long row_id_longtitude = -1;
    BOOL shouldDoSaveOperation = NO;
    //Data operation
    row_id_verb = [self insertContent:verb IntoDataModel:@"Verb" InstanceOfDataModel:verbModel];
    row_id_thing = [self insertContent:thing IntoDataModel:@"Thing" InstanceOfDataModel:thingModel];
    row_id_person = [self insertContent:person IntoDataModel:@"Person" InstanceOfDataModel:personModel];
    row_id_place = [self insertContent:place IntoDataModel:@"Place" InstanceOfDataModel:placeModel];
    row_id_my_date = [self insertContent:date IntoDataModel:@"MyDate" InstanceOfDataModel:dateModel];
    row_id_latitude = [self insertContent:latitude IntoDataModel:@"Latitude" InstanceOfDataModel:latModel];
    row_id_longtitude = [self insertContent:longtitude IntoDataModel:@"Longtitude" InstanceOfDataModel:longModel];
    //Do middle table insert
    if (row_id_verb!=-1| row_id_thing!=-1|
        row_id_person!=-1|row_id_place!=-1|
        row_id_my_date!=-1|row_id_latitude!=-1
        |row_id_longtitude!=-1) {
        if ([self checkExistanceInMiddleTable:row_id_verb Thing:row_id_thing Person:row_id_person Place:row_id_place Date:row_id_my_date]==nil) {
            MiddleTable *newRow = [NSEntityDescription insertNewObjectForEntityForName:@"MiddleTable" inManagedObjectContext:_managedObjectContext];
            newRow.row_id = [NSNumber numberWithLongLong:([[self LastIdOfMiddleTable] intValue]+1)];
            newRow.idOfVerb = [NSNumber numberWithLongLong:row_id_verb];
            newRow.idOfThing =  [NSNumber numberWithLongLong:row_id_thing];
            newRow.idOfPerson = [NSNumber numberWithLongLong:row_id_person];
            newRow.idOfPlace = [NSNumber numberWithLongLong:row_id_place];
            newRow.idOfMyDate = [NSNumber numberWithLongLong:row_id_my_date];
            newRow.idOfLatitude = [NSNumber numberWithLongLong:row_id_latitude];
            newRow.idOfLongtitude = [NSNumber numberWithLongLong:row_id_longtitude];
            shouldDoSaveOperation = YES;
        }
        
    }
    if (shouldDoSaveOperation) {
        NSError *error = nil;
        if ([_managedObjectContext save:&error]) {
            NSLog(@"Save Operation Done!!!");
            return YES;
        }
    }
    return NO;


}
-(NSArray*)retrieveAllQueryAsSentencesArray{
    NSMutableArray *arrayToReturn = [NSMutableArray array];
    NSArray *middleTables = [self fetchAllFor:@"MiddleTable"];
    for (MiddleTable *table in middleTables) {
        NSMutableString *sentence = [NSMutableString stringWithString:@""];
        if (table.idOfVerb!=[NSNumber numberWithLongLong:-1]) {
            Element *e = [self fetchFor:@"Verb" withRow_id:table.idOfVerb];
            [sentence appendString:e.content];
        }
        if (table.idOfThing!=[NSNumber numberWithLongLong:-1]) {
            Element *e = [self fetchFor:@"Thing" withRow_id:table.idOfThing];
            [sentence appendFormat:@" %@",e.content];
        }
        if (table.idOfPerson!=[NSNumber numberWithLongLong:-1]) {
            Element *e = [self fetchFor:@"Person" withRow_id:table.idOfPerson];
            [sentence appendFormat:@" to %@",e.content];
        }
        if (table.idOfPlace!=[NSNumber numberWithLongLong:-1]) {
            Element *e = [self fetchFor:@"Place" withRow_id:table.idOfPlace];
            [sentence appendFormat:@" at %@",e.content];
        }
        if (table.idOfMyDate!=[NSNumber numberWithLongLong:-1]) {
            Element *e = [self fetchFor:@"MyDate" withRow_id:table.idOfMyDate];
            [sentence appendFormat:@" on %@",e.content];
        }
        
        if (table.idOfLatitude!=[NSNumber numberWithLongLong:-1]) {
            Element *e = [self fetchFor:@"Latitude" withRow_id:table.idOfLatitude];
            [sentence appendFormat:@" Latitude:%@,",e.content];
        }
        
        if (table.idOfLongtitude!=[NSNumber numberWithLongLong:-1]) {
            Element *e = [self fetchFor:@"Longtitude" withRow_id:table.idOfLongtitude];
            [sentence appendFormat:@" Longtitude:%@",e.content];
        }
        if (![sentence isEqualToString:@""]) {
            [sentence appendString:@"."];
            NSLog(@"sentence:%@",sentence);
            [arrayToReturn addObject:sentence];
            
        }
    }
    if ([arrayToReturn count]>0) {
        NSLog(@"Retrieve Done!");
        return arrayToReturn;
    }
    return nil;
}
//------------------
#pragma FetchRequest
//------------------
-(NSNumber*)LastIdOf:(NSString *)name{
    NSFetchRequest *fetchLast = [[NSFetchRequest alloc]initWithEntityName:name];
    [fetchLast setFetchLimit:1];
    //retrieve in descending order
    NSSortDescriptor *idSort = [[NSSortDescriptor alloc]initWithKey:@"row_id" ascending:NO];
    [fetchLast setSortDescriptors: @[idSort]];
    NSError *requestError = nil;
    NSArray *result = [_managedObjectContext executeFetchRequest:fetchLast error:&requestError];
    if (result!=nil) {
        NSNumber *idInModel = ((Element*)result[0]).row_id;
        return idInModel;
    }
    return 0;
}
-(NSNumber*)LastIdOfMiddleTable{
    NSFetchRequest *fetchLast = [[NSFetchRequest alloc]initWithEntityName:@"MiddleTable"];
    [fetchLast setFetchLimit:1];
    //retrieve in descending order
    NSSortDescriptor *idSort = [[NSSortDescriptor alloc]initWithKey:@"row_id" ascending:NO];
    [fetchLast setSortDescriptors: @[idSort]];
    NSError *requestError = nil;
    NSArray *result = [_managedObjectContext executeFetchRequest:fetchLast error:&requestError];
    if (result!=nil) {
        return ((MiddleTable*)(result[0])).row_id;
    }
    MiddleTable *t = [NSEntityDescription insertNewObjectForEntityForName:@"MiddleTable" inManagedObjectContext:_managedObjectContext];
    t.row_id = 0;
    NSError *savingError = nil;
    [_managedObjectContext save:&savingError];
    return t.row_id;
}
-(NSArray *)fetchAllFor:(NSString*)dataModelName{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:dataModelName];
    NSArray *array = nil;
    NSError *e = nil;
    array = [_managedObjectContext executeFetchRequest:fetchRequest error:&e];
    return array;
}
-(Element *)fetchFor:(NSString*)dataModelName withRow_id:(NSNumber*)rowId{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:dataModelName];
    NSPredicate *row_id_predicate = [NSPredicate predicateWithFormat:@"row_id==%@",rowId];
    [fetchRequest setPredicate:row_id_predicate];
    [fetchRequest setFetchLimit:1];
    NSArray *array = nil;
    NSError *e = nil;
    array = [_managedObjectContext executeFetchRequest:fetchRequest error:&e];
    if ([array count]>0) {
        return (Element*)(array[0]);
    }
    return nil;
    
}
//------------------
#pragma save operation
//------------------
-(long long)insertContent:(NSString*)content IntoDataModel:(NSString*)modelName InstanceOfDataModel:(Element*)model{
    long long row_id = -1;
    if (content!=nil) {
        if ((model=[self checkContent:content InModel:modelName])!=nil) {
            row_id = [model.row_id intValue];
        }else{
            //insert new one
            model = [NSEntityDescription insertNewObjectForEntityForName:modelName inManagedObjectContext:_managedObjectContext];
            model.content = content;
            model.row_id =[NSNumber numberWithInt:([[self LastIdOf:modelName] intValue]+1)];
            row_id = [model.row_id intValue];
        }
    }
    return row_id;
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
//        NSLog(@"No content matched in %@", modelName);
        return nil;
    }else{
//        NSLog(@"Content found!");
    }
    return ((Element*)result[0]);
}

-(BOOL)checkIdInMiddleTable: (NSNumber*)row_id InModel:(NSString*)modelName{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:modelName];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"row_id == %@",row_id];
    [request setPredicate:predict];
    [request setFetchLimit:1];
    NSError *requestError = nil;
    NSArray *result = [_managedObjectContext executeFetchRequest:request error:&requestError];
    if ([result count]<1) {
        //        NSLog(@"No content matched in %@", modelName);
//        return nil;
        return NO;
    }else{
        //        NSLog(@"Content found!");
    }
//    return ((Element*)result[0]);
    return YES;
}
-(MiddleTable* )checkExistanceInMiddleTable:(long long)row_id_verb Thing:(long long) row_id_thing Person:(long long)row_id_person Place:(long long)row_id_place Date:(long long)row_id_date{
    //transform to NSNumber
    NSNumber *verb_id = [NSNumber numberWithLongLong:row_id_verb];
    NSNumber *thing_id = [NSNumber numberWithLongLong:row_id_thing];
    NSNumber *person_id = [NSNumber numberWithLongLong:row_id_person];
    NSNumber *place_id = [NSNumber numberWithLongLong:row_id_place];
    NSNumber *myDate_id = [NSNumber numberWithLongLong:row_id_date];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"MiddleTable"];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"idOfVerb == %@ && idOfThing==%@ && idOfPerson==%@ && idOfPlace==%@ && idOfMyDate==%@",verb_id, thing_id, person_id, place_id, myDate_id];
    [request setPredicate:predict];
    [request setFetchLimit:1];
    NSError *requestError = nil;
    NSArray *result = [_managedObjectContext executeFetchRequest:request error:&requestError];
    if ([result count]<1) {
//        NSLog(@"No content matched in MiddleTable");
        return nil;
    }else{
//        NSLog(@"Content found in MiddleTable!");
    }
    return ((MiddleTable*)result[0]);
}

-(void)autoDeleteEntity{
    
}

-(BOOL)deleteEntityWithContent:(NSString*)content InModelNamed:(NSString*)name{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:name];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"content == %@",content];
    [request setPredicate:predict];
    [request setFetchLimit:1];
    NSError *requestError = nil;
    NSArray *array = [_managedObjectContext executeFetchRequest:request error:&requestError];
    if ([array count]>0) {
        Element *e = (Element*)array[0];
        [_managedObjectContext deleteObject:e];
        if ([_managedObjectContext save:&requestError]) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)deleteEntityWithRowId:(NSString*)row_id InModelNamed:(NSString*)name{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:name];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"row_id == %lld",row_id];
    [request setPredicate:predict];
    [request setFetchLimit:1];
    NSError *requestError = nil;
    NSArray *array = [_managedObjectContext executeFetchRequest:request error:&requestError];
    if ([array count]>0) {
        Element *e = (Element*)array[0];
        [_managedObjectContext deleteObject:e];
        if ([_managedObjectContext save:&requestError]) {
            return YES;
        }
    }
    return NO;
}

@end

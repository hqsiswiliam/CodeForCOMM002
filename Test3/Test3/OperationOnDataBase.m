//
//  OperationOnDataBase.m
//  Test3
//
//  Created by H QS on 14-2-25.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "OperationOnDataBase.h"
@implementation OperationOnDataBase{
    NSManagedObjectContext *_managedObjectContext;
}


#pragma initializer of the class
-(id)initWithManagedObjectContext:(NSManagedObjectContext*) moc{
    self = [super init];
    if (!self) {
        return nil;
    }
    _managedObjectContext = moc;
    return self;
}


#pragma save action performed by this method
//Then we need to consider the situation that enquery did exists in database;
-(BOOL)saveDataToDB:(NSString*) action Person:(NSString*) person Place:(NSString*)place Date:(NSString*)date{
    if (action==nil) {
        NSLog(@"Please provide a action at least!!!");
        return NO;
    }
    
    Action *act=nil;
    Person *per=nil;
    Place *pla=nil;
    Date *dat=nil;
    if (action!=nil) {
        if ((act = [self checkContentInDataModel:@"Action" content:action])!=nil) {
        }else{
            act = [NSEntityDescription insertNewObjectForEntityForName:@"Action" inManagedObjectContext:_managedObjectContext];
            act.content = action;
        }
        if (person!=nil) {
            per = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_managedObjectContext];
            per.content = person;
            [per addBelongsToActionsObject:act];
            if (place!=nil) {
                pla = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:_managedObjectContext];
                pla.content = place;
                [pla addBelongsToPersons:[NSSet setWithObject:per]];
                if (date!=nil) {
                    dat = [NSEntityDescription insertNewObjectForEntityForName:@"Date" inManagedObjectContext:_managedObjectContext];
                    dat.content = date;
                    [dat addBelongsToPlace:[NSSet setWithObject:pla]];
                }
            }else if(date!=nil){
                dat = [NSEntityDescription insertNewObjectForEntityForName:@"Date" inManagedObjectContext:_managedObjectContext];
                dat.content = date;
                [dat addBelongsToPersons:[NSSet setWithObject:per]];
            }
        }
        else if(place!=nil){
            pla = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:_managedObjectContext];
            pla.content = place;
            [pla addBelongsToActionsObject:act];
            if (date!=nil) {
                dat = [NSEntityDescription insertNewObjectForEntityForName:@"Date" inManagedObjectContext:_managedObjectContext];
                dat.content = date;
                [dat addBelongsToPlace:[NSSet setWithObject:pla]];
            }
        }
        else if(date!=nil){
            dat = [NSEntityDescription insertNewObjectForEntityForName:@"Date" inManagedObjectContext:_managedObjectContext];
            dat.content = date;
            [dat addBelongsToActions:[NSSet setWithObject:act]];
        }
    }
    NSError *savingError = nil;
    if ([_managedObjectContext save:&savingError]) {
        NSLog(@"Save operation sucessful!");
        return YES;
    }
    return NO;
}



#pragma retrieve all data using action array solely
-(NSArray*)retrieveAllQueryAsSentencesArray{
    //using action array to find out all the possibles
    NSMutableArray *allQueries = [NSMutableArray array];
    NSFetchRequest *fetchForAction = [NSFetchRequest fetchRequestWithEntityName:@"Action"];
    NSError *fetchError = nil;
    NSArray *actions = [_managedObjectContext executeFetchRequest:fetchForAction error:&fetchError];
    for (Action *act in actions) {
        NSString *sentence = nil;
        if ([[act hasManyPersons] count]!=0) {
            for (Person *per in [act hasManyPersons]){
                if ([[per hasManyPlaces]count]!=0) {
                    for (Place* pla in [per hasManyPlaces]) {
                        if ([[pla hasManyDates]count]!=0) {
                            for (Date* dat in [pla hasManyDates]) {
                                sentence = [NSString stringWithFormat:@"%@ to %@ at %@ on %@", act.content, per.content, pla.content, dat.content];
                                [allQueries addObject:sentence];
                            }
                        }else{
                            sentence = [NSString stringWithFormat:@"%@ to %@ at %@", act.content, per.content, pla.content];
                            [allQueries addObject:sentence];
                        }
                    }
                }else if([per hasManyDates]!=0){
                    for (Date *dat in [per hasManyDates]) {
                        sentence = [NSString stringWithFormat:@"%@ to %@ on %@", act.content, per.content, dat.content];
                        [allQueries addObject:sentence];
                    }
                }
                if ([[per hasManyPlaces]count]==0&&[[per hasManyDates]count]==0) {
                    sentence = [NSString stringWithFormat:@"%@ to %@", act.content, per.content];
                    [allQueries addObject:sentence];
                }
            }
        }
        if([[act hasManyPlaces]count]!=0){
            for (Place* pla in [act hasManyPlaces]) {
                if ([[pla hasManyDates]count]!=0) {
                    for (Date* dat in [pla hasManyDates]) {
                        sentence = [NSString stringWithFormat:@"%@ at %@ on %@", act.content, pla.content, dat.content];
                        [allQueries addObject:sentence];
                    }
                }else{
                    sentence = [NSString stringWithFormat:@"%@ at %@", act.content,pla.content];
                    [allQueries addObject:sentence];
                }
            }
        }
        if([[act hasManyDates]count]!=0){
            for (Date* dat in [act hasManyDates]) {
                sentence = [NSString stringWithFormat:@"%@ on %@", act.content, dat.content];
                [allQueries addObject:sentence];
            }
        }else{
            sentence = [NSString stringWithFormat:@"%@", act.content];
            [allQueries addObject:sentence];
        }
    }
    if ([allQueries count]!=0) {
        return allQueries;
    }
    return nil;
}

#pragma clean all data in database
-(BOOL) deleteAllData{
    NSFetchRequest *fetchForAction = [NSFetchRequest fetchRequestWithEntityName:@"Action"];
    NSError *fetchError = nil;
    NSArray *actions = [_managedObjectContext executeFetchRequest:fetchForAction error:&fetchError];
    for (Action* a in actions) {
        [_managedObjectContext deleteObject:a];
    }
    NSError *commitError = nil;
    if ([_managedObjectContext save:&commitError]) {
        return YES;
    }
    return NO;
}

#pragma delete action with certain name
-(BOOL)deletePersonsWithString:(NSString *)content{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    NSError *fetchError = nil;
    NSArray *array = [_managedObjectContext executeFetchRequest:fetch error:&fetchError];
    for (Person *obj in array) {
        if([obj.content isEqualToString:content]){
            [_managedObjectContext deleteObject:obj];
        }
    }
    NSError *commitError = nil;
    if ([_managedObjectContext save:&commitError]) {
        return YES;
    }
    return NO;
}
-(BOOL)deleteActionsWithString:(NSString *)content{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Action"];
    NSError *fetchError = nil;
    NSArray *array = [_managedObjectContext executeFetchRequest:fetch error:&fetchError];
    for (Action *obj in array) {
        if([obj.content isEqualToString:content]){
            [_managedObjectContext deleteObject:obj];
        }
    }
    NSError *commitError = nil;
    if ([_managedObjectContext save:&commitError]) {
        return YES;
    }
    return NO;
}
-(BOOL)deletePlacesWithString:(NSString *)content{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
    NSError *fetchError = nil;
    NSArray *array = [_managedObjectContext executeFetchRequest:fetch error:&fetchError];
    for (Place *obj in array) {
        if([obj.content isEqualToString:content]){
            [_managedObjectContext deleteObject:obj];
        }
    }
    NSError *commitError = nil;
    if ([_managedObjectContext save:&commitError]) {
        return YES;
    }
    return NO;
}
-(BOOL)deleteDatesWithString:(NSString *)content{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Date"];
    NSError *fetchError = nil;
    NSArray *array = [_managedObjectContext executeFetchRequest:fetch error:&fetchError];
//    NSFetchRequest *fetch4action = [NSFetchRequest fetchRequestWithEntityName:@"Action"];
//    NSArray *array4action = [_managedObjectContext executeFetchRequest:fetch error:&fetchError];
//    NSFetchRequest *fetch4place = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
//    NSArray *array4place = [_managedObjectContext executeFetchRequest:fetch error:&fetchError];
//    NSFetchRequest *fetch4person = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
//    NSArray *array4person = [_managedObjectContext executeFetchRequest:fetch error:&fetchError];
    for (Date *obj in array) {
        if([obj.content isEqualToString:content]){
//            for (Action* a in array4action) {
//                if ([[a hasManyDates] containsObject:obj]) {
//                    [a removeHasManyDatesObject:obj];
//                }
//            }
//            for (Person* a in array4person) {
//                if ([[a hasManyDates] containsObject:obj]) {
//                    [a removeHasManyDatesObject:obj];
//                }
//            }
//            for (Place* a in array4place) {
//                if ([[a hasManyDates] containsObject:obj]) {
//                    [a removeHasManyDatesObject:obj];
//                }
//            }
            [_managedObjectContext deleteObject:obj];
        }
    }
    NSError *commitError = nil;
    if ([_managedObjectContext save:&commitError]) {
        return YES;
    }
    return NO;
}

#pragma find existed entity in database!
//return nil if object with content not found!!!
-(id)checkContentInDataModel:(NSString *)modelName content:(NSString*)content{
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
    return ((id)result[0]);
}

-(Action* )checkContentInActionModel: (NSString*)content{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Action"];
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
    NSLog(@"NUMBER=%d",[result count]);
    return ((Action*)result[0]);
}
@end

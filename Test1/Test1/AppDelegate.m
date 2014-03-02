//
//  AppDelegate.m
//  Test1
//
//  Created by H QS on 14-2-25.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
-(NSString *)getTimeString{
    NSDateFormatter *formatter;
    NSString        *dateString;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    dateString = [formatter stringFromDate:[NSDate date]];
    return dateString;
}
-(BOOL)saveDataTest{
    _managedObjectContext = [self managedObjectContext];
    @try {
        Action *action = [NSEntityDescription insertNewObjectForEntityForName:@"Action" inManagedObjectContext:_managedObjectContext];
        Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_managedObjectContext];
        Place *place = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:_managedObjectContext];
        Date *date = [NSEntityDescription insertNewObjectForEntityForName:@"Date" inManagedObjectContext:_managedObjectContext];
        action.content = [NSString stringWithFormat:@"Action in %@",[self getTimeString]];
        person.content = [NSString stringWithFormat:@"Person in %@", [self getTimeString]];
        place.content = [NSString stringWithFormat:@"Place in %@",[self getTimeString]];
        date.content = [NSString stringWithFormat:@"Date in %@", [self getTimeString]];
    }
    @catch (NSException *exception) {
        NSLog(@"Error catched in creating entity process!!!!!");
        NSLog(@"Error = %@", exception);
    }
    @finally {
    }
    
    
    @try {
        NSError *savingError = nil;
        if ([_managedObjectContext save:&savingError]) {
            NSLog(@"Save success in %@",[self getTimeString]);
            return YES;
        }else{
            NSLog(@"Error happen =%@", savingError);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Error catched in saving process!!!!!!!");
    }
    @finally {
        return NO;
    }
    return NO;
}

-(BOOL)readDataTest{
    NSFetchRequest *fetchForAction = [[NSFetchRequest alloc]initWithEntityName:@"Action"];
    NSFetchRequest *fetchForPerson = [[NSFetchRequest alloc]initWithEntityName:@"Person"];
    NSFetchRequest *fetchForPlace = [[NSFetchRequest alloc] initWithEntityName:@"Place"];
    NSFetchRequest *fetchForDate = [[NSFetchRequest alloc] initWithEntityName:@"Date"];
    NSError *requestError= nil;
    NSArray *actions = [_managedObjectContext executeFetchRequest:fetchForAction error:&requestError];
    NSArray *persons = [_managedObjectContext executeFetchRequest:fetchForPerson error:&requestError];
    NSArray *places = [_managedObjectContext executeFetchRequest:fetchForPlace error:&requestError];
    NSArray *dates = [_managedObjectContext executeFetchRequest:fetchForDate error:&requestError];
    //print data:
    if (actions!=nil&&persons!=nil&&places!=nil&&dates!=nil) {
        NSLog(@"Retrieve data success!");
        for (Action *a in actions) {
            NSLog(@"Action=\n%@",a.content);
        }
        for (Person *a in persons) {
            NSLog(@"Person=\n%@",a.content);
        }
        for (Place *a in places) {
            NSLog(@"Place=\n%@",a.content);
        }
        for (Date *a in dates) {
            NSLog(@"Date=\n%@",a.content);
        }
    }
    return NO;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self saveDataTest];
    [self readDataTest];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Test1" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Test1.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end

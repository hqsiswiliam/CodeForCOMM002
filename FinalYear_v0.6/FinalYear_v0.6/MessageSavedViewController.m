//
//  MessageSavedViewController.m
//  FinalYear_v0.1
//
//  Created by H QS on 14-1-7.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "MessageSavedViewController.h"
#import "AppDelegate.h"
#import "DataOperation.h"
@interface MessageSavedViewController (){
    DataOperation *_dataOperation;
    NSString *_db_verb;
    NSString *_db_thing;
    NSString *_db_person;
    NSString *_db_place;
    NSString *_db_date;
    NSString *_db_longtitude;
    NSString *_db_latitude;
    
}
@end

@implementation MessageSavedViewController




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.languageAnalysis = [[LanguageIdentify alloc]init];
        self.verb_subj = @"#################";
        self.person = @"#################";
        self.place  = @"#################";
        self.date = @"#################";
        self.longtitude=@"#################";
        self.latitude=@"#################";
    }
    return self;
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
//    [self performSelector:@selector(goBack) withObject:nil afterDelay:1.5f];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _db_verb = nil;
    _db_thing = nil;
    _db_person = nil;
    _db_place = nil;
    _db_date = nil;
    _db_latitude=nil;
    _db_longtitude = nil;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    _dataOperation = [[DataOperation alloc]initWithManagedObjectContext:managedObjectContext];
    NSMutableString *stringToDisplay;
    if (![self.verb_subj isEqualToString:@"#################"]) {
        stringToDisplay = [NSMutableString stringWithFormat:@"Action: %@\n",self.verb_subj];
//        _db_thing = [self.languageAnalysis lookingForNonce:self.verb_subj];
        _db_verb = [self.languageAnalysis lookingForVerb:self.verb_subj];
        NSRange rangeOfVerb = [self.verb_subj rangeOfString:_db_verb];
        _db_thing = [self.verb_subj substringFromIndex:rangeOfVerb.length];
        if (![_db_verb isEqual:@""]) {
            [stringToDisplay appendString:[NSString stringWithFormat:@"Verb in action: %@\n", _db_verb]];
        }
        if (![_db_thing isEqual:@""]) {
            if ([_db_thing hasPrefix:@" "]) {
                _db_thing = [_db_thing stringByTrimmingCharactersInSet:
                             [NSCharacterSet characterSetWithCharactersInString:@" "]];
            }
            [stringToDisplay appendString:[NSString stringWithFormat:@"Item in action: %@\n", _db_thing]];
        }
    }
    if (![self.person isEqualToString:@"#################"]) {
        _db_person = self.person;
        [stringToDisplay appendString:[NSString stringWithFormat:@"Person: %@\n", self.person]];
    }
    if (![self.place isEqualToString:@"#################"]) {
        _db_place = self.place;
        [stringToDisplay appendString:[NSString stringWithFormat:@"Place: %@\n", self.place]];
    }
    if (![self.date isEqualToString:@"#################"]) {
        _db_date = self.date;
        [stringToDisplay appendString:[NSString stringWithFormat:@"Date: %@\n", self.date]];
    }
    if (![self.latitude isEqualToString:@"#################"]) {
        _db_latitude = self.latitude;
        [stringToDisplay appendString:[NSString stringWithFormat:@"Latitude: %@\n", self.latitude]];
    }
    if (![self.longtitude isEqualToString:@"#################"]) {
        _db_longtitude = self.longtitude;
        [stringToDisplay appendString:[NSString stringWithFormat:@"Longtitude: %@\n", self.longtitude]];
    }
    self.displayLabel.text = stringToDisplay;
    [self saveSentence];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)saveSentence{
    if ([_dataOperation saveDataToDB:_db_verb Thing:_db_thing Person:_db_person Place:_db_place Date:_db_date Latitude:_db_latitude Longtitude:_db_longtitude]) {
        return YES;
    }
    return NO;
}

@end

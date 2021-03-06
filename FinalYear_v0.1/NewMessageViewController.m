//
//  NewMessageViewController.m
//  FinalYear_v0.1
//
//  Created by H QS on 14-1-7.
//  Copyright (c) 2014年 H QS. All rights reserved.
//
//THINGS here means action, person, place, and date
#import "NewMessageViewController.h"
#import "MessageSavedViewController.h"
@interface NewMessageViewController ()
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) NSArray *keyWords;
@property (strong, nonatomic) NSArray *THINGS;
@property (strong, nonatomic) NSDictionary *keyWordsAndTHINGS;
@property (strong, nonatomic) NSDictionary *THINGSAndIndex;

@end

@implementation NewMessageViewController

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.text = @"";
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//selector for the button
- (IBAction)saveButtonClicked:(id)sender {
    [self.textField resignFirstResponder];
    NSString *sentence = [self.textField text];
    NSArray* array = [self performWordExtract:sentence];
    MessageSavedViewController *m = [[MessageSavedViewController alloc]init];
    //set the string value to be displayed
    if (![array[0] isEqual:@""]) {
        m.verb_subj = array[0];
    }
    if (![array[1] isEqual:@""]) {
        m.person = array[1];
    }
    if (![array[2] isEqual:@""]) {
        m.place = array[2];
    }
    if (![array[3] isEqual:@""]) {
        m.date = array[3];
    }
    NSLog(@"FINE!!!!!");
    [self.navigationController pushViewController:m animated:YES];
}

//constructor of the class
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Create Message";
        self.tabBarItem.image = [UIImage imageNamed:@"NewMessageICON"];
        self.keyWords = @[@"++",@" to ", @" at ",@" on ",@"--"];
        self.THINGSAndIndex = [[NSDictionary alloc]initWithObjectsAndKeys:
                               0,@"action",
                               1,@"person",
                               2,@"place",
                               3,@"date",
                                nil];
        self.keyWordsAndTHINGS = [[NSDictionary alloc]initWithObjectsAndKeys:
                                  @"action",@"++",
                                  @"person",@" to ",
                                  @"place",@" at ",
                                  @"date",@" on ",
                                  nil];
        self.THINGS = [[NSArray alloc] initWithObjects:@"action",@"person",@"place",@"date", nil];
    }
    return self;
}

-(NSArray*)findKeyWordAndReturnIndex:(NSString *)modified_sentence{
    NSUInteger index = NSUIntegerMax;
    NSString *lastKey;
    NSArray *modified_keyWords = @[@" to ", @" at ",@" on ",@"--"];
    for (NSString* key in modified_keyWords) {
        if ([modified_sentence rangeOfString:key].location==NSNotFound) {
            continue;
        }else{
            if ([modified_sentence rangeOfString:key].location<index) {
                index =[modified_sentence rangeOfString:key].location;
                lastKey = key;
            }
        }
    }
    
    NSArray *arrary = @[[NSString stringWithFormat:@"%d",index], lastKey];
    return arrary;
}


-(NSArray *)performWordExtract:(NSString *)sentence {
    //0=verb+subject 1=person 2=place 3=date
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    NSString *modified_sentence = [NSString stringWithFormat:@"++%@--",sentence];
    NSArray* index_lastKey;
    NSString *lastKey = @"++";
    @try {
        for (NSString *value in self.keyWords) {
            if ([value isEqualToString:lastKey]) {
                if ([lastKey isEqualToString:@"--"]) {
                    break;
                }
                NSString *THINGS = [self.keyWordsAndTHINGS objectForKey:lastKey];
                NSLog(@"QQ%@",THINGS);
                int currentIndexFor_array = [self.THINGS indexOfObject:THINGS];
                NSLog(@"Current index: %d",currentIndexFor_array);
                modified_sentence = [modified_sentence substringFromIndex:lastKey.length];
                index_lastKey=[self findKeyWordAndReturnIndex:modified_sentence];
                array[currentIndexFor_array] = [modified_sentence substringToIndex:[index_lastKey[0] intValue]];
                modified_sentence = [modified_sentence substringFromIndex:[index_lastKey[0] intValue]];
                lastKey = index_lastKey[1];

            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Bug in process of word extraction catched!");
    }
    @finally {
        
    }
    NSLog(@"DESCRIPTION: %@", [array description]);
    return [array copy];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

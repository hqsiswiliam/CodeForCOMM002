//
//  MessageSavedViewController.m
//  FinalYear_v0.1
//
//  Created by H QS on 14-1-7.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "MessageSavedViewController.h"

@interface MessageSavedViewController ()
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
    NSMutableString *stringToDisplay;
    if (![self.verb_subj isEqualToString:@"#################"]) {
        stringToDisplay = [NSMutableString stringWithFormat:@"Action: %@\n",self.verb_subj];
        NSString *nonce = [self.languageAnalysis lookingForNonce:self.verb_subj];
        NSString *verb = [self.languageAnalysis lookingForVerb:self.verb_subj];
        if (![nonce isEqual:@""]) {
            [stringToDisplay appendString:[NSString stringWithFormat:@"Verb in action: %@\n", verb]];
        }
        if (![nonce isEqual:@""]) {
            [stringToDisplay appendString:[NSString stringWithFormat:@"Item in action: %@\n", nonce]];
        }
    }
    if (![self.person isEqualToString:@"#################"]) {
        [stringToDisplay appendString:[NSString stringWithFormat:@"Person: %@\n", self.person]];
    }
    if (![self.place isEqualToString:@"#################"]) {
        [stringToDisplay appendString:[NSString stringWithFormat:@"Place: %@\n", self.place]];
    }
    if (![self.date isEqualToString:@"#################"]) {
        [stringToDisplay appendString:[NSString stringWithFormat:@"Date: %@\n", self.date]];
    }
    self.displayLabel.text = stringToDisplay;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

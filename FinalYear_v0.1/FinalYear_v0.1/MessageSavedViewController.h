//
//  MessageSavedViewController.h
//  FinalYear_v0.1
//
//  Created by H QS on 14-1-7.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LanguageIdentify.h"
@interface MessageSavedViewController : UIViewController
@property(strong, nonatomic)NSString* verb_subj;
@property(strong, nonatomic)NSString* person;
@property(strong, nonatomic)NSString* place;
@property(strong, nonatomic)NSString* date;
@property (strong, nonatomic) IBOutlet UILabel *displayLabel;
@property LanguageIdentify *languageAnalysis;
@end

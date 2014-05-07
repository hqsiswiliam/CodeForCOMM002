//
//  LanguageIdentify.h
//  FinalYear_v0.1
//
//  Created by H QS on 14-1-8.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageIdentify : NSObject
@property(strong, nonatomic)NSString *outputString;
-(NSString*) lookingForNonce:(NSString *)inputString;
-(NSString*) lookingForVerb:(NSString *)inputString;
-(NSString *)searchWithSentenceAndOption:(NSString *)sentence option:(NSString *const)option;
@end

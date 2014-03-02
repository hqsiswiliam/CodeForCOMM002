//
//  LanguageIdentify.h
//  Language Identification In Foundation Class
//
//  Created by H QS on 14-1-8.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageIdentify : NSObject
@property(strong, nonatomic)NSString *outputString;
-(NSString*) lookingForNonce:(NSString *)inputString;
@end

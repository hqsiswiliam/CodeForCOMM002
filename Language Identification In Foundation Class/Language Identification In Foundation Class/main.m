//
//  main.m
//  Language Identification In Foundation Class
//
//  Created by H QS on 14-1-8.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LanguageIdentify.h"
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSString *question = @"return a book to John";
        LanguageIdentify *l = [[LanguageIdentify alloc]init];
        NSString *n = [l lookingForNonce:question];
        NSLog(@"%@",n);
        
    }
    return 0;
}


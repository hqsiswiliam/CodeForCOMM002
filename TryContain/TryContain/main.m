//
//  main.m
//  TryContain
//
//  Created by H QS on 14-1-13.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSString *string1 = @"Hello World";
        NSString *string2 = @"Hello Wolrd";
        NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:string1, nil];
        if ([array containsObject:string2]) {
            NSLog(@"Y");
        }else
            NSLog(@"N");
    }
    return 0;
}


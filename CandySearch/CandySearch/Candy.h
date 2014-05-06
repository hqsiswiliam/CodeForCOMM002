//
//  Candy.h
//  CandySearch
//
//  Created by H QS on 14-5-6.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Candy : NSObject{
    NSString *category;
    NSString *name;
}
@property(nonatomic, copy) NSString* category;
@property(nonatomic, copy) NSString* name;

+ (id)candyOfCategory:(NSString*)category name:(NSString*)name;

@end

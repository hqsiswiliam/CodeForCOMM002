//
//  Element.h
//  FinalYear_v0.6
//
//  Created by H QS on 14-3-27.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Element : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * row_id;

@end

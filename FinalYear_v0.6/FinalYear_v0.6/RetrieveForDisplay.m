//
//  RetrieveForDisplay.m
//  FinalYear_v0.6
//
//  Created by H QS on 14-4-1.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "RetrieveForDisplay.h"

@implementation RetrieveForDisplay
@synthesize sentences,verbs,persons,places,things,latitudes,longtitudes, myDates;
- (id)init
{
    self = [super init];
    if (self) {
        [self shouldCreate];
    }
    return self;
}

-(void)shouldCreate{
    self.sentences = [[NSMutableArray alloc]init];
    self.verbs = [[NSMutableArray alloc]init];
    self.persons = [[NSMutableArray alloc]init];
    self.places = [[NSMutableArray alloc]init];
    self.things = [[NSMutableArray alloc]init];
    self.latitudes = [[NSMutableArray alloc]init];
    self.longtitudes = [[NSMutableArray alloc]init];
    self.myDates = [[NSMutableArray alloc]init];
}
@end

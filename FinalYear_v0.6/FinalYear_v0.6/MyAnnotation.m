//
//  MyAnnotation.m
//  TestForMapKit
//
//  Created by H QS on 14-3-11.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
-(instancetype) initWithCoordinates:(CLLocationCoordinate2D) paramCoordinate title:(NSString*)paramTitle subtitle:(NSString*)paramSubtitle{
    self = [super init];
    if (self!=nil) {
        _coordinate = paramCoordinate;
        _title = paramTitle;
        _subtitle = paramSubtitle;
    }
    return self;
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    _coordinate = newCoordinate;
}
-(void)setTitle:(NSString *)title{
    _title = title;
}
-(void)setSubtitle:(NSString *)subtitle{
    _subtitle = subtitle;
}


@end

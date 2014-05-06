//
//  MyAnnotation.h
//  TestForMapKit
//
//  Created by H QS on 14-3-11.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyAnnotation : NSObject<MKAnnotation>
@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy, readonly) NSString *title;
@property(nonatomic,copy, readonly) NSString *subtitle;
-(instancetype) initWithCoordinates:(CLLocationCoordinate2D) paramCoordinate title:(NSString*)paramTitle subtitle:(NSString*)paramSubtitle;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
@end

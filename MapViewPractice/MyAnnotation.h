//
//  MyAnnotation.h
//  MapViewPractice
//
//  Created by H QS on 13-12-11.
//  Copyright (c) 2013年 H QS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation>

@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;
@property (readonly, nonatomic,copy) NSString *title;
@property (readonly, nonatomic,copy) NSString *subtitle;

- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates
                                title:(NSString *)paramTitle
                             subTitle:(NSString *)paramSubTitle;

@end

//
//  ViewController.h
//  MapViewPractice
//
//  Created by H QS on 13-12-11.
//  Copyright (c) 2013年 H QS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) MKMapView *myMapView;
@property (strong, nonatomic) CLLocationManager *myLocationManager;

@end

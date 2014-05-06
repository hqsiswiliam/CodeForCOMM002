//
//  MapViewController.h
//  TestForMapKit
//
//  Created by H QS on 14-3-9.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
@property (nonatomic, strong) MKMapView *myMapView;
@property (nonatomic, strong) CLLocationManager *coreLocationManager;
@property (nonatomic, strong) UILabel *label4Latitude;
@property (nonatomic, strong) UILabel *label4Longtitude;
@property (nonatomic, strong) UITextField *addressTextField;
@property (nonatomic, strong) CLGeocoder *myGeocoder;
@end

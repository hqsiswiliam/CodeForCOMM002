//
//  MapSearchViewController.h
//  TestForMapSearch
//
//  Created by H QS on 14-3-11.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapSearchViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
@property (nonatomic, strong) MKMapView *myMapView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) CLLocationManager *locationManger;
@end

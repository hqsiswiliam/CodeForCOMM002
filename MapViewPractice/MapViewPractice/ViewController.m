//
//  ViewController.m
//  MapViewPractice
//
//  Created by H QS on 13-12-11.
//  Copyright (c) 2013年 H QS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.myMapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    self.myMapView.mapType = MKMapTypeStandard;
    self.myMapView.delegate = self;
    self.myMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.myMapView];
    if ([CLLocationManager locationServicesEnabled]) {
        self.myLocationManager = [[CLLocationManager alloc]init];
        self.myLocationManager.delegate = self;
        [self.myLocationManager startUpdatingLocation];
    }else{NSLog(@"Location Service is not enabled!");}
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(50.82191692907181, -0.13811767101287842);
    MyAnnotation *annotation = [[MyAnnotation alloc]initWithCoordinates:location title:@"MyTitle" subTitle:@"SubTitle"];
    [self.myMapView addAnnotation: annotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
//    NSLog(@"Latitude: %f", newLocation.coordinate.latitude);
//    NSLog(@"Longtitude: %f", newLocation.coordinate.longitude);
}

@end

//
//  MapViewController.m
//  TestForMapKit
//
//  Created by H QS on 14-3-9.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "MapViewController.h"
#import "MyAnnotation.h"
@interface MapViewController (){
    CGSize _screenSize;
}

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if ([CLLocationManager locationServicesEnabled]) {
            self.coreLocationManager = [[CLLocationManager alloc]init];
            self.coreLocationManager.delegate = self;
            [self.coreLocationManager startUpdatingLocation];
        }else{
            NSLog(@"Location service disabled!");
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //get screen size first
    _screenSize = self.view.bounds.size;
    
    self.label4Latitude = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, _screenSize.width, 20)];
    self.label4Longtitude = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, _screenSize.width, 20)];
    
    self.label4Latitude.text = @"Latitude:";
    self.label4Longtitude.text = @"Longtitude:";
    self.myGeocoder = [[CLGeocoder alloc]init];
    [self.myGeocoder geocodeAddressString:@"Beijing" completionHandler:^(NSArray *placemarks, NSError *error){
        if ([placemarks count]>0 && error ==nil) {
            CLPlacemark *firstPlaceMark = placemarks[0];
            MyAnnotation *a = [[MyAnnotation alloc]initWithCoordinates:firstPlaceMark.location.coordinate title:@"Beijing" subtitle:@""];
            [self.myMapView addAnnotation:a];
        }
    }];
    self.myMapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 130, _screenSize.width, _screenSize.height/2)];
    self.myMapView.mapType = MKMapTypeStandard;
    self.myMapView.delegate = self;
    [self.view addSubview:self.myMapView];
    [self.view addSubview:self.label4Longtitude];
    [self.view addSubview:self.label4Latitude];
    [self.myMapView setUserTrackingMode:MKUserTrackingModeFollow];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma core location manager delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    if (manager == self.coreLocationManager) {
        NSLog(@"Location is %@, length of array is %lu", locations.lastObject, (unsigned long)[locations count]);
        self.label4Latitude.text = [NSString stringWithFormat:@"Latitude: %f",((CLLocation *)(locations.lastObject)).coordinate.latitude];
        self.label4Longtitude.text = [NSString stringWithFormat:@"Longtitude: %f",((CLLocation *)(locations.lastObject)).coordinate.longitude];
        CLLocationCoordinate2D location =((CLLocation *)(locations.lastObject)).coordinate;
        MyAnnotation *annotation = [[MyAnnotation alloc]initWithCoordinates:location title:@"Title" subtitle:@"Subtitle"];
        [self.myMapView addAnnotation:annotation];
    }
}

@end

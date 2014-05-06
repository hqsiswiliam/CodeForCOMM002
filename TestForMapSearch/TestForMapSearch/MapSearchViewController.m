//
//  MapSearchViewController.m
//  TestForMapSearch
//
//  Created by H QS on 14-3-11.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "MapSearchViewController.h"
#import "MyAnnotation.h"
@interface MapSearchViewController (){
    CGSize _screenSize;
    CLLocationCoordinate2D coordinate;
    MyAnnotation *_annotation;
    BOOL _pinMovedByUser;
    MKPinAnnotationView* _pinView;
}
@end

@implementation MapSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if ([CLLocationManager locationServicesEnabled]) {
            self.locationManger = [[CLLocationManager alloc]init];
            self.locationManger.delegate = self;
            [self.locationManger startUpdatingLocation];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Fail" message:@"Cannot open location service" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _pinMovedByUser = NO;
    _screenSize = self.view.bounds.size;
    self.myMapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 150, _screenSize.width, _screenSize.height-150)];
    self.myMapView.showsUserLocation = YES;
    self.myMapView.userTrackingMode = MKUserTrackingModeFollow;
    self.myMapView.delegate = self;
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 50, _screenSize.width, 20)];
    self.searchButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 80, _screenSize.width/2, 20)];
    self.searchButton.exclusiveTouch = NO;
    [self.searchButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.searchButton setTitle:@"Search" forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(searchForThings) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.searchButton];
    [self.view addSubview:self.myMapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchForThings{
    [self.textField resignFirstResponder];
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc]init];
    request.naturalLanguageQuery = self.textField.text;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    request.region = MKCoordinateRegionMake(coordinate, span);
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        for (MKMapItem *item in response.mapItems) {
            _annotation = [[MyAnnotation alloc]initWithCoordinates:item.placemark.location.coordinate title:item.name subtitle:item.phoneNumber];
            [self.myMapView addAnnotation:_annotation];
            _pinView = [[MKPinAnnotationView alloc]initWithAnnotation:_annotation reuseIdentifier:@"myPin"];
            break;
        }
    }];
}

#pragma mapView delegate
-(void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Failed" message:@"Couldn't get the user location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
}

#pragma For pin move by user.
-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    if (_pinView==nil) {
    }else{
        _pinView.annotation = annotation;
        
        _pinView.draggable = YES;
        _pinView.animatesDrop = YES;
    }
    return _pinView;
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        CLLocationCoordinate2D droppedAt = view.annotation.coordinate;
        NSLog(@"Pin dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
//        [self.myMapView removeAnnotations:self.myMapView.annotations];
//        _annotation = [[MyAnnotation alloc]initWithCoordinates:droppedAt title:@"" subtitle:@""];
//        [self.myMapView addAnnotation:_annotation];
        [_annotation setCoordinate:droppedAt];
    }
}

#pragma CLLocationManager delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    if (manager == self.locationManger &&_pinMovedByUser==NO) {
        CLLocationCoordinate2D location =((CLLocation *)(locations.lastObject)).coordinate;
        coordinate = location;
    }
}

@end

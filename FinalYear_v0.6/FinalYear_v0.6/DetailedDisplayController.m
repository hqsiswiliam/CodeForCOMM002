//
//  DetailedDisplayController.m
//  FinalYear_v0.6
//
//  Created by H QS on 14-4-7.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "DetailedDisplayController.h"
#import "MyAnnotation.h"
@interface DetailedDisplayController (){
    CLLocationCoordinate2D _locationCoor;
}

@end

@implementation DetailedDisplayController
@synthesize sentence, latitude,longtitude,myDate,person,place;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        sentence=@"";
        latitude=@"";
        longtitude=@"";
        myDate=@"";
        place=@"";
        person=@"";
        self.map_view=[[MKMapView alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![place isEqualToString:@""]) {
        if (![longtitude isEqualToString:@""]&&![latitude isEqualToString:@""]) {
            [self.locationNotSet setHidden:YES];
            _locationCoor.latitude = [latitude doubleValue];
            _locationCoor.longitude = [longtitude doubleValue];
            [self putAnnotationToMap];
        }else{
            [self.map_view setOpaque:0.1f];
        }
    }
    self.sentence_label.text = sentence;
    self.time_label.text =myDate;
}

-(void)putAnnotationToMap{
    MKCoordinateRegion region;
    MyAnnotation *a = [[MyAnnotation alloc]initWithCoordinates:_locationCoor title:place subtitle:@""];
    [self.map_view addAnnotation:a];
    [self.map_view setCenterCoordinate:_locationCoor];
    region.center = _locationCoor;
    MKCoordinateSpan span;
    CLLocationDegrees zoomLevel = 0.01;//the smaller, the more accurency
    span.latitudeDelta  = zoomLevel; // values for zoom
    span.longitudeDelta = zoomLevel;
    region.span = span;
    [self.map_view setRegion:region animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

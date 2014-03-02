//
//  FirstViewController.h
//  LanguageExtraction
//
//  Created by H QS on 13-12-11.
//  Copyright (c) 2013年 H QS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface FirstViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *InputField;
- (IBAction)saveInfo:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *repeatField;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end

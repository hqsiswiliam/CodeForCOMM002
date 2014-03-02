//
//  ViewController.h
//  NLP
//
//  Created by H QS on 13-12-11.
//  Copyright (c) 2013年 H QS. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
@interface ViewController : UIViewController<MKMapViewDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *inputField;
@property (strong, nonatomic) IBOutlet UILabel *outputField;
@property (strong, nonatomic) IBOutlet MKMapView *myMapView;
- (NSString *) wordsExtract:(NSString*)wordPoint startWord:(NSString*)startword sentence:(NSString*)sentenceToBreak;
@end

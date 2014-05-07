//
//  DetailedDisplayController.h
//  FinalYear_v0.6
//
//  Created by H QS on 14-4-7.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface DetailedDisplayController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *locationNotSet;
@property (strong, nonatomic) IBOutlet MKMapView *map_view;
@property (strong, nonatomic) IBOutlet UILabel *time_label;
@property (strong, nonatomic) IBOutlet UILabel *sentence_label;
@property (strong, nonatomic) NSString *sentence;
@property (strong, nonatomic) NSString *myDate;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longtitude;
@property(strong, nonatomic)NSString* person;
@property(strong, nonatomic)NSString* place;
@end

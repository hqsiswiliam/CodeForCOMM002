//
//  NewMessageViewController.m
//  FinalYear_v0.1
//
//  Created by H QS on 14-1-7.
//  Copyright (c) 2014年 H QS. All rights reserved.
//
//THINGS here means action, person, place, and date
#import "NewMessageViewController.h"
#import "MessageSavedViewController.h"
#import "AppDelegate.h"
#import "MyAnnotation.h"
@interface NewMessageViewController ()
@property (strong, nonatomic) MKMapView *mapViewInScreen;
@property (strong, nonatomic) IBOutlet UIButton *saveButtion;
@property (strong, nonatomic) IBOutlet UIButton *clearFormButton;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) NSArray *keyWords;
@property (strong, nonatomic) NSArray *THINGS;
@property (strong, nonatomic) NSDictionary *keyWordsAndTHINGS;
@property (strong, nonatomic) NSDictionary *THINGSAndIndex;
@property (strong, nonatomic) UILabel *placeStates;


@end

@implementation NewMessageViewController{
    CLLocationManager *locationManager;
    CLLocationCoordinate2D _coordinate;
    CLLocationCoordinate2D _userlocation;
    MyAnnotation *_mapAnnotation;
    UIView* accessoryView;
    MKPinAnnotationView* _pinView;
    BOOL _pinIsSet;
    NSString *_loc_latitude;
    NSString *_loc_longtitude;
}
- (IBAction)clearMessage:(id)sender {
    self.textField.text = @"";
    _loc_latitude = @"";
    _loc_longtitude=@"";
    _placeStates.hidden = YES;
    _mapAnnotation = nil;
    [self.mapViewInScreen removeAnnotations:self.mapViewInScreen.annotations];
    [self.mapViewInScreen setCenterCoordinate:_userlocation animated:YES];
}
#pragma textField
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    textField.text = @"";
    [self.mapViewInScreen setCenterCoordinate:_userlocation animated:YES];
    if (accessoryView==nil) {
        [self createAccessory];
    }
    [textField setInputAccessoryView:accessoryView];
    self.mapViewInScreen.opaque = 1.0;
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.placeStates.hidden = YES;
    _loc_latitude=@"";
    _loc_longtitude=@"";
    NSString *sentence = [self.textField text];
    NSArray* array = [self performWordExtract:sentence];
    NSLog(@"Place: %@",array[2]);
    if (![array[2] isEqual:@""]) {
        self.placeStates.text = @"Searching for place...";
        self.mapViewInScreen.opaque = 0.5;
        self.placeStates.hidden = NO;
        MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc]init];
        request.naturalLanguageQuery = array[2];
        MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
        request.region = MKCoordinateRegionMake(_coordinate, span);
        MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
        [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
            if ([response.mapItems count]<1) {
                self.placeStates.text = @"Place not found!";
                self.placeStates.hidden = NO;
                self.mapViewInScreen.opaque = 0.5;
                _mapAnnotation = nil;
                [self.mapViewInScreen removeAnnotations:self.mapViewInScreen.annotations];
            }
            for (MKMapItem *item in response.mapItems) {
                if (_mapAnnotation!=nil) {
                    [_mapAnnotation setCoordinate:item.placemark.location.coordinate];
                    [_mapAnnotation setTitle:array[2]];
                    [self.mapViewInScreen setCenterCoordinate:item.placemark.location.coordinate];
                    _coordinate = item.placemark.location.coordinate;
                    _loc_longtitude = [NSString stringWithFormat:@"%f",_coordinate.longitude];
                    _loc_latitude = [NSString stringWithFormat:@"%f",_coordinate.latitude];
                    //for label
                    self.placeStates.hidden = YES;
                    self.mapViewInScreen.opaque = 1.0;
                }else{
                    _mapAnnotation = [[MyAnnotation alloc]initWithCoordinates:item.placemark.location.coordinate title:array[2] subtitle:@""];
                    [self.mapViewInScreen addAnnotation:_mapAnnotation];
                    //create annotaionView
                    _pinView = [[MKPinAnnotationView alloc]initWithAnnotation:_mapAnnotation reuseIdentifier:@"Place"];
                    //end of creation
                    NSLog(@"Annotation Added!");
                    _coordinate = item.placemark.location.coordinate;
                    [self.mapViewInScreen setCenterCoordinate:item.placemark.location.coordinate];
                    _pinIsSet = YES;
                    _loc_longtitude = [NSString stringWithFormat:@"%f",_coordinate.longitude];
                    _loc_latitude = [NSString stringWithFormat:@"%f",_coordinate.latitude];
                    //for label
                    self.placeStates.hidden = YES;
                    self.mapViewInScreen.opaque = 1.0;
                }
                break;
            }
            
        }];
    }else{
        [self.mapViewInScreen removeAnnotation:_mapAnnotation];
        _mapAnnotation=nil;
        self.placeStates.text = @"Place not entered!";
        self.placeStates.hidden = NO;
        self.mapViewInScreen.opaque = 0.1;
        _mapAnnotation = nil;
        [self.mapViewInScreen removeAnnotations:self.mapViewInScreen.annotations];
    }
    [textField resignFirstResponder];
    return YES;
}

-(void)createAccessory{
    NSInteger buttonWidth = self.view.bounds.size.width/5;
    NSInteger screenWidthForButton = self.view.bounds.size.width;
    CGFloat buttonRadius = 5.0;
    accessoryView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, screenWidthForButton, 40.0)];
    [accessoryView setBackgroundColor:[UIColor whiteColor]];
    UIButton *button_at = [UIButton buttonWithType:UIButtonTypeSystem];
    [button_at setFrame:CGRectMake(screenWidthForButton*0.4, 10, buttonWidth, 20)];
    [button_at setTitle:@"at" forState:UIControlStateNormal];
    [button_at setBackgroundColor:[UIColor whiteColor]];
    button_at.layer.cornerRadius = buttonRadius;
    button_at.clipsToBounds = YES;
    button_at.tag = 0;
    [button_at addTarget:self action:@selector(handleAccessoryButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView addSubview:button_at];
    
    UIButton *button_to = [UIButton buttonWithType:UIButtonTypeSystem];
    [button_to setFrame:CGRectMake(screenWidthForButton*0.1, 10, buttonWidth, 20)];
    [button_to setTitle:@"to" forState:UIControlStateNormal];
    [button_to setBackgroundColor:[UIColor whiteColor]];
    button_to.layer.cornerRadius = buttonRadius;
    button_to.clipsToBounds = YES;
    button_to.tag = 1;
    [button_to addTarget:self action:@selector(handleAccessoryButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView addSubview:button_to];
    
    UIButton *button_on = [UIButton buttonWithType:UIButtonTypeSystem];
    [button_on setFrame:CGRectMake(screenWidthForButton*0.7, 10, buttonWidth, 20)];
    [button_on setTitle:@"on" forState:UIControlStateNormal];
    [button_on setBackgroundColor:[UIColor whiteColor]];
    button_on.layer.cornerRadius = buttonRadius;
    button_on.clipsToBounds = YES;
    button_on.tag = 2;
    [button_on addTarget:self action:@selector(handleAccessoryButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView addSubview:button_on];
    
}

-(void)handleAccessoryButtonEvent:(id)sender{
    if (((UIButton*)sender).tag==0) {
        NSString *tempString = [NSString stringWithFormat:@"%@ %@ ",self.textField.text, @"at"];
        self.textField.text = tempString;
    }else if (((UIButton*)sender).tag==1) {
        NSString *tempString = [NSString stringWithFormat:@"%@ %@ ",self.textField.text, @"to"];
        self.textField.text = tempString;
    }else if (((UIButton*)sender).tag==2) {
        NSString *tempString = [NSString stringWithFormat:@"%@ %@ ",self.textField.text, @"on"];
        self.textField.text = tempString;
    }
}
#pragma Button
//selector for the button
- (IBAction)saveButtonClicked:(id)sender {
    
    [self.textField resignFirstResponder];
    NSString *sentence = [[self.textField text] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSArray* array = [self performWordExtract:sentence];
    MessageSavedViewController *m = [[MessageSavedViewController alloc]init];
    if ([array[0] isEqual:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Action Needed!" message:@"Please provide an action for the message" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    //set the string value to be displayed
    if (![array[0] isEqual:@""]) {
        m.verb_subj = array[0];
    }
    if (![array[1] isEqual:@""]) {
        m.person = array[1];
    }
    if (![array[2] isEqual:@""]) {
        m.place = array[2];
    }
    if (![array[3] isEqual:@""]) {
        m.date = array[3];
    }
    if (![_loc_latitude isEqualToString:@""]) {
        m.latitude = _loc_latitude;
    }
    if (![_loc_longtitude isEqualToString:@""]) {
        m.longtitude = _loc_longtitude;
    }
    m.whole_sentence = sentence;
    NSLog(@"FINE!!!!!");
    [self clearMessage:nil];
    [self.navigationController pushViewController:m animated:YES];
}

//constructor of the class
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pinIsSet = NO;
        self.title = @"Create Message";
        self.tabBarItem.image = [UIImage imageNamed:@"NewMessageICON"];
        self.keyWords = @[@"++",@" to ", @" at ",@" on ",@"--"];
        self.THINGSAndIndex = [[NSDictionary alloc]initWithObjectsAndKeys:
                               0,@"action",
                               1,@"person",
                               2,@"place",
                               3,@"date",
                                nil];
        self.keyWordsAndTHINGS = [[NSDictionary alloc]initWithObjectsAndKeys:
                                  @"action",@"++",
                                  @"person",@" to ",
                                  @"place",@" at ",
                                  @"date",@" on ",
                                  nil];
        self.THINGS = [[NSArray alloc] initWithObjects:@"action",@"person",@"place",@"date", nil];
        if ([CLLocationManager locationServicesEnabled]) {
            locationManager = [[CLLocationManager alloc]init];
            locationManager.delegate = self;
            [locationManager startUpdatingLocation];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Fail" message:@"Cannot open location service" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    return self;
}

-(NSArray*)findKeyWordAndReturnIndex:(NSString *)modified_sentence{
    NSUInteger index = NSUIntegerMax;
    NSString *lastKey;
    NSArray *modified_keyWords = @[@" to ", @" at ",@" on ",@"--"];
    for (NSString* key in modified_keyWords) {
        if ([modified_sentence rangeOfString:key].location==NSNotFound) {
            continue;
        }else{
            if ([modified_sentence rangeOfString:key].location<index) {
                index =[modified_sentence rangeOfString:key].location;
                lastKey = key;
            }
        }
    }
    
    NSArray *arrary = @[[NSString stringWithFormat:@"%lu",(unsigned long)index], lastKey];
    return arrary;
}


-(NSArray *)performWordExtract:(NSString *)sentence {
    //0=verb+subject 1=person 2=place 3=date
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    NSString *modified_sentence = [NSString stringWithFormat:@"++%@--",sentence];
    NSArray* index_lastKey;
    NSString *lastKey = @"++";
    @try {
        while (YES) {
            if ([lastKey isEqualToString:@"--"]) {
                break;
            }
            for (NSString *value in self.keyWords) {
                if ([value isEqualToString:lastKey]) {
                    if ([lastKey isEqualToString:@"--"]) {
                        break;
                    }
                    NSString *THINGS = [self.keyWordsAndTHINGS objectForKey:lastKey];
//                    NSLog(@"QQ%@",THINGS);
                    unsigned long currentIndexFor_array = [self.THINGS indexOfObject:THINGS];
//                    NSLog(@"Current index: %lu",currentIndexFor_array);
                    modified_sentence = [modified_sentence substringFromIndex:lastKey.length];
                    index_lastKey=[self findKeyWordAndReturnIndex:modified_sentence];
                    array[currentIndexFor_array] = [modified_sentence substringToIndex:[index_lastKey[0] intValue]];
                    modified_sentence = [modified_sentence substringFromIndex:[index_lastKey[0] intValue]];
                    lastKey = index_lastKey[1];
                    
                }
            }
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"Bug in process of word extraction catched!");
    }
    @finally {
        
    }
    return [array copy];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configMapView];
    self.saveButtion.layer.cornerRadius = 5;
    [self.saveButtion setClipsToBounds:YES];
    self.clearFormButton.layer.cornerRadius = 5;
    [self.clearFormButton setClipsToBounds:YES];

    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}


//the height and width are all calculated as points
-(void)configMapView{
    self.placeStates = [[UILabel alloc]initWithFrame:CGRectMake(0,self.textField.frame.origin.y+self.textField.frame.size.height+5,self.view.bounds.size.width,220 )];
    self.placeStates.textAlignment=NSTextAlignmentCenter;
    self.placeStates.font = [UIFont systemFontOfSize:35];
    self.placeStates.textColor = [UIColor grayColor];
    self.placeStates.hidden = YES;
    int mapHeight = 220;
    NSLog(@"Height:%f",self.view.bounds.size.height);

    if (self.view.frame.size.width>500) {
        mapHeight+=88;
        NSLog(@"Height:%f",self.view.bounds.size.width);
    }
    self.mapViewInScreen = [[MKMapView alloc]initWithFrame:CGRectMake(0,self.textField.frame.origin.y+self.textField.frame.size.height+5, self.view.bounds.size.width,mapHeight )];
    self.mapViewInScreen.showsUserLocation = YES;
    self.mapViewInScreen.delegate = self;
    self.mapViewInScreen.userTrackingMode = MKUserTrackingModeFollow;
    [self.view addSubview:self.mapViewInScreen];
    [self.view addSubview:self.placeStates];
    _pinIsSet = NO;
    _loc_latitude=@"";
    _loc_longtitude=@"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma Mapview delegate
-(void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Failed" message:@"Couldn't get the user location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion region;
    if (_pinIsSet==NO) {
        _coordinate = userLocation.coordinate;
    }
    region.center = _coordinate;
    MKCoordinateSpan span;
    CLLocationDegrees zoomLevel = 0.01;//the smaller, the more accurency
    span.latitudeDelta  = zoomLevel; // values for zoom
    span.longitudeDelta = zoomLevel;
    region.span = span;
    [mapView setRegion:region animated:NO];
}

#pragma Corelocation Manager

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    if (manager == locationManager) {
        CLLocationCoordinate2D location =((CLLocation *)(locations.lastObject)).coordinate;
        _userlocation = location;
    }
}

#pragma For pin move by user.
-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if (_pinView==nil) {
    }else{
        _pinView.annotation = annotation;
        _pinView.canShowCallout = YES;
        _pinView.draggable = YES;
        _pinView.animatesDrop = YES;
    }
    return _pinView;
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        CLLocationCoordinate2D droppedAt = view.annotation.coordinate;
        [_mapAnnotation setCoordinate:droppedAt];
        //update location
        _loc_latitude = [NSString stringWithFormat:@"%f",droppedAt.latitude];
        _loc_longtitude = [NSString stringWithFormat:@"%f",droppedAt.longitude];
    }
}



@end

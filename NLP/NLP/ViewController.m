//
//  ViewController.m
//  NLP
//
//  Created by H QS on 13-12-11.
//  Copyright (c) 2013年 H QS. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize inputField,outputField,myMapView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    myMapView = [[MKMapView alloc]init];
    myMapView.mapType = MKMapTypeSatellite;
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(50.82191692907181, -0.13811767101287842);
    MyAnnotation *annotation = [[MyAnnotation alloc]initWithCoordinates:location title:@"MyTitle" subTitle:@"SubTitle"];
    [myMapView addAnnotation:annotation];
    myMapView.showsUserLocation = YES;
    [self.view addSubview:myMapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) wordsExtract:(NSString*)wordPoint startWord:(NSString*)startword sentence:(NSString*)sentenceToBreak{
    NSRange range1 = [sentenceToBreak rangeOfString:startword];
    NSRange range2 = [sentenceToBreak rangeOfString:wordPoint];
    NSString *temp = [sentenceToBreak substringToIndex:range2.location];
    unsigned int realstartlocation = range1.location + range1.length;
    NSUInteger location1 = realstartlocation;
    NSString *temp2 = [temp substringFromIndex:location1];
    return temp2;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *modifiedText = [[NSString alloc] initWithFormat:@"++%@--",inputField.text];
    if ([[segue identifier]isEqualToString:@"SAVEDATA" ]) {
        DetailViewController *detailcontroller = [segue destinationViewController];
        detailcontroller.passedData = inputField.text;
        detailcontroller.action = [self wordsExtract:@"to" startWord:@"++" sentence:modifiedText];
        detailcontroller.name = [self wordsExtract:@"at" startWord:@"to" sentence:modifiedText];
        detailcontroller.place = [self wordsExtract:@"on" startWord:@"at" sentence:modifiedText];
        detailcontroller.time = [self wordsExtract:@"--" startWord:@"on" sentence:modifiedText];
    }
    
    
}
#pragma for UIAlertView
//Do some check before transfer to another segue
-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"SAVEDATA"]) {
        //blur the focus of inputField
        [inputField resignFirstResponder];
        NSString *modifiedText = [[NSString alloc] initWithFormat:@"++%@--",inputField.text];
        //need to be complete using regular expression
        if ([modifiedText rangeOfString:@"to"].location==NSNotFound
            |[modifiedText rangeOfString:@"at"].location==NSNotFound
            |[modifiedText rangeOfString:@"on"].location==NSNotFound) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter as format" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            [alert show];
            inputField.text = @"";
            return NO;
        }
        return YES;
    }
    return YES;
}

//listener/delegate for UIAlertView!
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"OK"]) {
        NSLog(@"User Press OK");
    }else if([buttonTitle isEqualToString:@"Cancel"]){
        NSLog(@"User Press Cancel");
    }
}
@end

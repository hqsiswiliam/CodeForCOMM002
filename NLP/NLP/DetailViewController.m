//
//  DetailViewController.m
//  NLP
//
//  Created by H QS on 13-12-12.
//  Copyright (c) 2013年 H QS. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize passedData, displayLabel,action,name,time,actionLabel,timeLabel,nameLabel,place,placeLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    displayLabel.text = passedData;
    actionLabel.text = action;
    nameLabel.text = name;
    timeLabel.text = time;
    placeLabel.text = place;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

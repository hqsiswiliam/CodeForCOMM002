//
//  ViewController.m
//  TestForWordRecommendation
//
//  Created by H QS on 14-3-20.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController{
    UIView *accessoryView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (accessoryView==nil) {
        [self createAccessory];
    }
    [textField setInputAccessoryView:accessoryView];
    return YES;
}

-(void)createAccessory{
    NSInteger buttonWidth = self.view.bounds.size.width/5;
    NSInteger screenWidthForButton = self.view.bounds.size.width;
    CGFloat buttonRadius = 5.0;
    accessoryView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, screenWidthForButton, 40.0)];
    [accessoryView setBackgroundColor:[UIColor lightGrayColor]];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

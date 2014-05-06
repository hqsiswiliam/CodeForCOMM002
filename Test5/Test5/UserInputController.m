//
//  UserInputController.m
//  Test5
//
//  Created by H QS on 14-3-6.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "UserInputController.h"

@interface UserInputController (){
    UILabel *_label;
    CGSize _screenBound;
}
@end

@implementation UserInputController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _screenBound = self.view.bounds.size;
    NSLog(@"%f",_screenBound.width);
    _label = [[UILabel alloc]initWithFrame:CGRectMake(_screenBound.width/4, _screenBound.height/10,_screenBound.width/2, 20)];
    _label.text = @"Hello User";
    [self.view addSubview:_label];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

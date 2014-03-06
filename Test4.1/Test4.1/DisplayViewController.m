//
//  DisplayViewController.m
//  Test4.1
//
//  Created by H QS on 14-3-5.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "DisplayViewController.h"
static NSString *TableViewCellIdentifier = @"MyCells";
@interface DisplayViewController ()

@end

@implementation DisplayViewController{
    NSArray *_dataArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithNSArray:(NSArray *)array{
    self = [super init];
    _dataArray = array;
    NSLog(@"FASDASD:%@",[_dataArray description]);
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
    self.myTableView.dataSource = self;
    self.myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.myTableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:self.myTableView]) {
        return [_dataArray count];
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger number = 0;
    if ([tableView isEqual:self.myTableView]) {
        switch (section) {
            case 0:
                number = [_dataArray count];
                break;
                
            default:
                break;
        }
    }
    return number;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = nil;
    if ([tableView isEqual:self.myTableView]) {
        cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = _dataArray[indexPath.row];
    }
    return cell;
}

@end

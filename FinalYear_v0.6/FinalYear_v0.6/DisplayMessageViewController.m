//
//  DisplayMessageViewController.m
//  FinalYear_v0.1
//
//  Created by H QS on 14-1-7.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "DisplayMessageViewController.h"
#import "AppDelegate.h"
#import "DataOperation.h"
#import "RetrieveForDisplay.h"
#import "DetailedDisplayController.h"
static NSString* myCell = @"myCell";
@interface DisplayMessageViewController (){
    DataOperation *_dataOperation;
    RetrieveForDisplay* _retrieveForDisplay;
//    NSArray *_arrayForDisplay;
}
@end

@implementation DisplayMessageViewController
@synthesize displayDataView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Display Message";
        self.tabBarItem.image = [UIImage imageNamed:@"DisplayMessageICON"];
        _retrieveForDisplay = [[RetrieveForDisplay alloc]init];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [self fetchWholeSentence];
    [self createTableView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTableView{
//    self.displayDataView = [[UITableView alloc]initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, self.view.bounds.size.height-88) style:UITableViewStylePlain];
//    self.displayDataView = [[UITableView alloc]init];
    self.displayDataView.dataSource = self;
    self.displayDataView.delegate = self;
    [self.displayDataView registerClass:[UITableViewCell class] forCellReuseIdentifier:myCell];
    [self.view addSubview:self.displayDataView];
}

-(void)fetchWholeSentence{
    //assign appdelegate's MOC to the class's MOC
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    _dataOperation = [[DataOperation alloc]initWithManagedObjectContext:self.managedObjectContext];
    //fetch begin!
    _retrieveForDisplay = [_dataOperation retrieveAllQueryAsRetriveForDisplay];
}

#pragma fetch controller protocol
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.displayDataView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    if (type==NSFetchedResultsChangeInsert) {
        [self.displayDataView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    if (type==NSFetchedResultsChangeDelete) {
        [self.displayDataView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.displayDataView endUpdates];
}

#pragma dataSourceDelegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = nil;
    if ([tableView isEqual:self.displayDataView]) {
        cell = [tableView dequeueReusableCellWithIdentifier:myCell forIndexPath:indexPath];
        cell.textLabel.text = _retrieveForDisplay.sentences[indexPath.row];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger number = 0;
    if ([tableView isEqual:self.displayDataView]) {
        switch (section) {
            case 0:
                number = [_retrieveForDisplay.sentences count];
                break;
                
            default:
                break;
        }
    }
    return number;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:self.displayDataView]) {
        return [_retrieveForDisplay.sentences count];
    }
    return 0;
}




#pragma deletePractice
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    //    [super setEditing:editing animated:animated];
    [self.displayDataView setEditing:editing animated:animated];
}

//delete entity!!!!
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        @try {
            
        }
        @catch (NSException *exception) {
            NSLog(@"Deleting process ERROR!");
        }
        @finally {
            
        }
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        DetailedDisplayController *detailed_con = [[DetailedDisplayController alloc]init];
        detailed_con.sentence = _retrieveForDisplay.sentences[indexPath.row];
        detailed_con.person = _retrieveForDisplay.persons[indexPath.row];
        detailed_con.place = _retrieveForDisplay.places[indexPath.row];
        detailed_con.myDate = _retrieveForDisplay.myDates[indexPath.row];
        detailed_con.latitude = _retrieveForDisplay.latitudes[indexPath.row];
        detailed_con.longtitude = _retrieveForDisplay.longtitudes[indexPath.row];
        [self.navigationController pushViewController:detailed_con animated:YES];
    }
    
}
@end

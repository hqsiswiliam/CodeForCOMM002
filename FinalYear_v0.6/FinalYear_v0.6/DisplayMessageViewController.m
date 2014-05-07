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
    RetrieveForDisplay* _filteredResults;
}
@end

@implementation DisplayMessageViewController
@synthesize displayDataView,search_bar,search_controller;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Display Message";
        self.tabBarItem.image = [UIImage imageNamed:@"DisplayMessageICON"];
        _retrieveForDisplay = [[RetrieveForDisplay alloc]init];
        //add a search button on the right
        UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchBar)];
        self.navigationItem.rightBarButtonItem = search;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [self hideSearchBar];
}

-(void)viewDidDisappear:(BOOL)animated{
    [self hideSearchBar];
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self fetchWholeSentence];
    [self createTableView];
    [self createSearchBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTableView{
    [self.search_bar setFrame:CGRectZero];
    [self.view updateConstraints];
    self.displayDataView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-0) style:UITableViewStylePlain];
//    self.displayDataView = [[UITableView alloc]init];
    self.displayDataView.dataSource = self;
    self.displayDataView.delegate = self;
    [self.displayDataView registerClass:[UITableViewCell class] forCellReuseIdentifier:myCell];
    [self.view addSubview:self.displayDataView];
    
}

-(void)createSearchBar{
    //in case of crash
    _filteredResults = [[RetrieveForDisplay alloc]init];
    _filteredResults.sentences = [NSMutableArray arrayWithCapacity:2];
    //start to build search bar
    search_bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [self.view addSubview:search_bar];
    search_controller = [[UISearchDisplayController alloc]initWithSearchBar:search_bar contentsController:self];
    search_bar.hidden = YES;
    //set delegate
    search_bar.delegate = self;
    search_controller.delegate = self;
    search_controller.searchResultsDataSource = self;
    search_controller.searchResultsTableView.delegate = self;
    //register table cell for search display
    [search_controller.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Search"];
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
    }else if ([tableView isEqual:search_controller.searchResultsTableView]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Search" forIndexPath:indexPath];
        cell.textLabel.text = _filteredResults.sentences[indexPath.row];
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
    if ([tableView isEqual:search_controller.searchResultsTableView]) {
        switch (section) {
            case 0:
                number = [_filteredResults.sentences count];
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
    }else if([tableView isEqual:search_controller.searchResultsTableView]){
        return [_filteredResults.sentences count];
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
    if ([tableView isEqual:self.displayDataView]) {
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
    }else if([tableView isEqual:search_controller.searchResultsTableView]){
        DetailedDisplayController *detailed_con = [[DetailedDisplayController alloc]init];
        NSString* sentenceInFil = _filteredResults.sentences[indexPath.row];
        NSInteger indexIn_retrieveForDisplay = [_retrieveForDisplay.sentences indexOfObject:sentenceInFil];
        detailed_con.sentence = _retrieveForDisplay.sentences[indexIn_retrieveForDisplay];
        detailed_con.person = _retrieveForDisplay.persons[indexIn_retrieveForDisplay];
        detailed_con.place = _retrieveForDisplay.places[indexIn_retrieveForDisplay];
        detailed_con.myDate = _retrieveForDisplay.myDates[indexIn_retrieveForDisplay];
        detailed_con.latitude = _retrieveForDisplay.latitudes[indexIn_retrieveForDisplay];
        detailed_con.longtitude = _retrieveForDisplay.longtitudes[indexIn_retrieveForDisplay];
        
        [self.navigationController pushViewController:detailed_con animated:YES];
        
    }
    
    
}

#pragma for search button
-(void)showSearchBar{
    search_bar.hidden = NO;
    [self.displayDataView setFrame:CGRectMake(0, search_bar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-search_bar.frame.size.height)];
    [search_bar becomeFirstResponder];
}
-(void)hideSearchBar{
    [search_controller setActive:NO];
    search_bar.hidden = YES;
    [search_bar resignFirstResponder];
    [self.displayDataView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
}
#pragma handle search bar delegates
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    search_bar.hidden = YES;
    [self.displayDataView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    _filteredResults.sentences = [NSMutableArray arrayWithArray:[_retrieveForDisplay.sentences filteredArrayUsingPredicate:resultPredicate]];
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString
                               scope:[[search_controller.searchBar scopeButtonTitles] objectAtIndex:search_controller.searchBar.selectedScopeButtonIndex]];
    NSLog(@"%@",[_filteredResults.sentences description]);
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self filterContentForSearchText:search_bar.text
                               scope:[[search_controller.searchBar scopeButtonTitles] objectAtIndex:search_controller.searchBar.selectedScopeButtonIndex]];
    return YES;
}


@end

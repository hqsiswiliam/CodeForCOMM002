//
//  MainViewController.m
//  TableSearchTest
//
//  Created by H QS on 14-5-6.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "MainViewController.h"
#import "tvc.h"
@interface MainViewController (){
    NSArray *contents;
    NSArray *filterContents;
}

@end

@implementation MainViewController
@synthesize displayTableView,searchBar,searchController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        contents = @[@"A",@"B",@"C"];
        filterContents = [[NSArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    tvc *td = [[tvc alloc]init];
    [td start];
    displayTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 144, self.view.frame.size.width, self.view.frame.size.height-144)];
    [self.view addSubview:displayTableView];
    [displayTableView setDelegate: self];
    [displayTableView setDataSource: self];
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 100,self.view.frame.size.width, 44)];
    [self.view addSubview:searchBar];
    searchBar.delegate = self;
    searchController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    searchController.delegate = self;
    searchController.searchResultsDataSource = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
//    NSLog(@"85 called");
    cell.textLabel.text = contents[indexPath.row];
    if ([tableView isEqual:self.searchController.searchResultsTableView]) {
        cell.textLabel.text = filterContents[indexPath.row];
        NSLog(@"88 called");
    }
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:searchController.searchResultsTableView]) {
        return [filterContents count];
        NSLog(@"87 called");

        
    }
    if ([tableView isEqual:displayTableView]) {
        return [contents count];

    }
    
    return 0;
}

#pragma for search bar
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    filterContents = [contents filteredArrayUsingPredicate:resultPredicate];
    
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchController.searchBar scopeButtonTitles] objectAtIndex:self.searchController.searchBar.selectedScopeButtonIndex]];
    NSLog(@"%@",[filterContents description]);
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self filterContentForSearchText:searchBar.text
                               scope:[[self.searchController.searchBar scopeButtonTitles] objectAtIndex:self.searchController.searchBar.selectedScopeButtonIndex]];
    NSLog(@"%@",[filterContents description]);
    [self.searchController.searchResultsTableView reloadData];
    return YES;
}

@end

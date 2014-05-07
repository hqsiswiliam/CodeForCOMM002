//
//  CandyTableViewController.m
//  CandySearch
//
//  Created by H QS on 14-5-6.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "CandyTableViewController.h"
#import "Candy.h"
@interface CandyTableViewController ()

@end

@implementation CandyTableViewController
@synthesize candyArray, candySearchBar,filteredCandyArray;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    candyArray = [NSArray arrayWithObjects:
                  [Candy candyOfCategory:@"chocolate" name:@"chocolate bar"],
                  [Candy candyOfCategory:@"chocolate" name:@"chocolate chip"],
                  [Candy candyOfCategory:@"chocolate" name:@"dark chocolate"],
                  [Candy candyOfCategory:@"hard" name:@"lollipop"],
                  [Candy candyOfCategory:@"hard" name:@"candy cane"],
                  [Candy candyOfCategory:@"hard" name:@"jaw breaker"],
                  [Candy candyOfCategory:@"other" name:@"caramel"],
                  [Candy candyOfCategory:@"other" name:@"sour chew"],
                  [Candy candyOfCategory:@"other" name:@"peanut butter cup"],
                  [Candy candyOfCategory:@"other" name:@"gummi bear"], nil];
    self.filteredCandyArray = [NSMutableArray arrayWithCapacity:[candyArray count]];
    [self.tableView reloadData];
    CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + candySearchBar.bounds.size.height;
    self.tableView.bounds = newBounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredCandyArray count];
    } else {
        return [candyArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Create a new Candy Object
    Candy *candy = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        candy = [filteredCandyArray objectAtIndex:indexPath.row];
    } else {
        candy = [candyArray objectAtIndex:indexPath.row];
    }
    // Configure the cell
    cell.textLabel.text = candy.name;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredCandyArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    filteredCandyArray = [NSMutableArray arrayWithArray:[candyArray filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end

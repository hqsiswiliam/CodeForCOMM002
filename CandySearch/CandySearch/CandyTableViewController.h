//
//  CandyTableViewController.h
//  CandySearch
//
//  Created by H QS on 14-5-6.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandyTableViewController : UITableViewController<UISearchBarDelegate, UISearchDisplayDelegate>
@property (strong,nonatomic) NSArray *candyArray;
@property IBOutlet UISearchBar *candySearchBar;
@property (strong,nonatomic) NSMutableArray *filteredCandyArray;
@end

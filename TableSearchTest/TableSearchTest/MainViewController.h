//
//  MainViewController.h
//  TableSearchTest
//
//  Created by H QS on 14-5-6.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>

@property (strong, nonatomic) UITableView *displayTableView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchDisplayController *searchController;
@end

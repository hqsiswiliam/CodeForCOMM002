//
//  DisplayMessageViewController.h
//  FinalYear_v0.1
//
//  Created by H QS on 14-1-7.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayMessageViewController : UIViewController<UITableViewDelegate, NSFetchedResultsControllerDelegate, UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic, strong) UITableView *displayDataView;
@property(nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) UISearchBar *search_bar;
@property(nonatomic, strong) UISearchDisplayController *search_controller;
@end

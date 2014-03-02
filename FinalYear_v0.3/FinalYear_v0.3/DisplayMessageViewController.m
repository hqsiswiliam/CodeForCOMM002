//
//  DisplayMessageViewController.m
//  FinalYear_v0.1
//
//  Created by H QS on 14-1-7.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "DisplayMessageViewController.h"
#import "AppDelegate.h"
static NSString* myCell = @"myCell";
@interface DisplayMessageViewController ()
@end

@implementation DisplayMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Display Message";
        self.tabBarItem.image = [UIImage imageNamed:@"DisplayMessageICON"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createTableView];
    [self fetchWholeSentence];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTableView{
    self.displayDataView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.displayDataView.dataSource = self;
    self.displayDataView.delegate = self;
    [self.displayDataView registerClass:[UITableViewCell class] forCellReuseIdentifier:myCell];
    [self.view addSubview:self.displayDataView];
}

-(void)fetchWholeSentence{
    //assign appdelegate's MOC to the class's MOC
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
    //fetch begin
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"content" ascending:YES];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Sentence"];
    fetchRequest.sortDescriptors = @[sort];
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    NSError *fetchError = nil;
    if ([self.fetchedResultsController performFetch:&fetchError]) {
        NSLog(@"Fetch Successful");
    }else{
        NSLog(@"Fetch Failed!");
    }
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
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:myCell forIndexPath:indexPath];
    Sentence *wholeSentence = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = wholeSentence.content;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return sectionInfo.numberOfObjects;
}

#pragma deletePractice
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    //    [super setEditing:editing animated:animated];
    [self.displayDataView setEditing:editing animated:animated];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        @try {
            Sentence *sentenceToDelete =[self.fetchedResultsController objectAtIndexPath:indexPath];
            [self.managedObjectContext deleteObject:sentenceToDelete];
            NSError *saveError = nil;
            [self.managedObjectContext save:&saveError];
        }
        @catch (NSException *exception) {
            NSLog(@"Deleting process ERROR!");
        }
        @finally {
            
        }
        
    }
}
@end

//
//  tvc.m
//  TableSearchTest
//
//  Created by H QS on 14-5-6.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "tvc.h"

@implementation tvc{
    NSArray *contents;
}
-(void)start{
    contents = @[@"A",@"B",@"C"];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = contents[indexPath.row];
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contents count];
}

@end

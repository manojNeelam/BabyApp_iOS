//
//  CommonScreeingListVC.m
//  BabyApp
//
//  Created by Vishal Kolhe on 06/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "CommonScreeingListVC.h"
#import "CommonScreeingCell.h"
#import "CommonScreeingData.h"

@implementation CommonScreeingListVC
@synthesize listOfObjects, navTitle;

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.commonVCNavigationItem.title = self.navTitle;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listOfObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CommonScreeingCell";
    CommonScreeingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    CommonScreeingData *data = [listOfObjects objectAtIndex:indexPath.row];
    [cell populateData:data];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

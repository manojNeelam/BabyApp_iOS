//
//  CommonSelectionListVC.m
//  BabyApp
//
//  Created by Vishal Kolhe on 02/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "CommonSelectionListVC.h"
#import "CommonSelectionCell.h"

@interface CommonSelectionListVC ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *list;
}
@end

@implementation CommonSelectionListVC
@synthesize keyString;

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CommonSelectionCell";
    CommonSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell.lblTitle setText:[list objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate selectedValue:[list objectAtIndex:indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadData
{
    NSMutableArray *tempData = [NSMutableArray array];

    if([self.keyString isEqualToString:@"Gender"])
    {
        [tempData addObject:@"Mail"];
        [tempData addObject:@"Female"];
    }
    else if([self.keyString isEqualToString:@"Ethnic"])
    {
        [tempData addObject:@"Hispanic or Latino"];
        [tempData addObject:@"American Indian or Alaska Native"];
        [tempData addObject:@"Asian"];
        [tempData addObject:@"Black or African American"];
        [tempData addObject:@"Native Hawaiian or Pacific Islander"];
        [tempData addObject:@"White"];
    }
    else if([self.keyString isEqualToString:@"Delivery"])
    {
        [tempData addObject:@"Normal delivery"];
        [tempData addObject:@"Cesarean delivery"];
    }
    else if([self.keyString isEqualToString:@"MinScore"])
    {
        [tempData addObject:@"1"];
        [tempData addObject:@"2"];
        [tempData addObject:@"3"];
        [tempData addObject:@"4"];
        [tempData addObject:@"5"];
        [tempData addObject:@"6"];
        [tempData addObject:@"7"];
        [tempData addObject:@"8"];
        [tempData addObject:@"9"];
    }
    else if([self.keyString isEqualToString:@"MaxScore"])
    {
        [tempData addObject:@"1"];
        [tempData addObject:@"2"];
        [tempData addObject:@"3"];
        [tempData addObject:@"4"];
        [tempData addObject:@"5"];
        [tempData addObject:@"6"];
        [tempData addObject:@"7"];
        [tempData addObject:@"8"];
        [tempData addObject:@"9"];
    }
    else
    {
        [tempData addObject:@"Yes"];
        [tempData addObject:@"No"];
        
        
    }
    
    list = tempData;

    
    [self.tableView reloadData];

}

@end

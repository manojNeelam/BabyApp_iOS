//
//  ImmunisationsVC.m
//  BabyApp
//
//  Created by Jiten on 09/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "ImmunisationsVC.h"
#import "AllImmunisationCell.h"
#import "DueImmunisationCell.h"
#import "ConnectionsManager.h"
#import "WSConstant.h"
#import "NSUserDefaults+Helpers.h"

#import "ImmunisationData.h"
#import "ImmunisationBaseDate.h"

@interface ImmunisationsVC () <UITableViewDataSource,UITableViewDelegate, ServerResponseDelegate>
{
    NSArray *immunisationList, *immunisationDueList, *immunisationDoneList;
}
@end

@implementation ImmunisationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIFont *font = [UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [self.segmentImu setTitleTextAttributes:attributes
                                   forState:UIControlStateNormal];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tool"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickAddNew:)];
    self.imuNavigationItem.rightBarButtonItem = rightButton;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[self numfromString:[NSUserDefaults retrieveObjectForKey:USERID]] forKey:@"user_id"];
    [dict setObject:[self numfromString:[NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID]] forKey:@"child_id"];
    
    
    [[ConnectionsManager sharedManager] readAllImmunisation:dict withdelegate:self];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)onClickAddNew:(id)sender
{
    UIViewController *newImmunisation = [self.storyboard instantiateViewControllerWithIdentifier:@"NewImmunisationVC_SB_ID"];
    [self.navigationController pushViewController:newImmunisation animated:YES];
}

-(NSNumber *)numfromString:(NSString *)aStr
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:aStr];
    
    return myNumber;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentImu.selectedSegmentIndex == 0)
    {
        ImmunisationBaseDate *base = [immunisationList objectAtIndex:section];
        return base.listOfData.count;
    }
    else if(self.segmentImu.selectedSegmentIndex == 1)
    {
        ImmunisationBaseDate *base = [immunisationDoneList objectAtIndex:section];
        return base.listOfData.count;
    }
    else
    {
        ImmunisationBaseDate *base = [immunisationDueList objectAtIndex:section];
        return base.listOfData.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.segmentImu.selectedSegmentIndex == 0)
    {
        return immunisationList.count;
    }
    else if(self.segmentImu.selectedSegmentIndex == 1)
    {
        return immunisationDoneList.count;
    }
    else
    {
        return immunisationDueList.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentImu.selectedSegmentIndex == 0)
    {
        AllImmunisationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllImmunisationCell"];
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.lblNext.layer.cornerRadius = 8.0f;
        cell.lblNext.clipsToBounds = YES;
        
        if(indexPath.section == 0)
        {
            [cell.indicatorView setBackgroundColor:self.baseSegmentView.backgroundColor];
            [cell.lblLine setHidden:NO];
            [cell.lblDate setText:@"10/04/13"];
            [cell.lblDate setTextColor:[UIColor colorWithRed:200.0f/255.0f green:199.0f/255.0f blue:204.0f/255.0f alpha:1.0f]];
            [cell.lblNext setHidden:YES];
            [cell.imgNotePad setHidden:NO];
            
        }
        else if(indexPath.section == 1)
        {
            if(indexPath == 0)
            {
                [cell.indicatorView setBackgroundColor:self.baseSegmentView.backgroundColor];
                [cell.lblLine setHidden:YES];
                [cell.lblDate setText:@"12/04/13"];
                [cell.lblDate setTextColor:[UIColor colorWithRed:200.0f/255.0f green:199.0f/255.0f blue:204.0f/255.0f alpha:1.0f]];
                [cell.lblNext setHidden:YES];
            }
            else
            {
                [cell.indicatorView setBackgroundColor:cell.lblNext.backgroundColor];
                [cell.lblLine setHidden:YES];
                [cell.lblDate setText:@"15/04/13"];
                [cell.lblDate setTextColor:cell.lblNext.backgroundColor];
                [cell.lblNext setHidden:NO];
                [cell.imgNotePad setHidden:YES];
            }
        }
        
        
        return cell;
    }
    if (self.segmentImu.selectedSegmentIndex == 1)
    {
        AllImmunisationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllImmunisationCell"];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        if(indexPath.section == 0)
        {
            [cell.indicatorView setBackgroundColor:self.baseSegmentView.backgroundColor];
            [cell.lblLine setHidden:YES];
            [cell.lblTitle setText:@"First Dose"];
            [cell.lblDate setText:@"10/04/13"];
            [cell.lblDate setTextColor:[UIColor colorWithRed:200.0f/255.0f green:199.0f/255.0f blue:204.0f/255.0f alpha:1.0f]];
            [cell.lblNext setHidden:YES];
            [cell.imgNotePad setHidden:NO];
        }
        else if(indexPath.section == 1)
        {
            [cell.indicatorView setBackgroundColor:self.baseSegmentView.backgroundColor];
            [cell.lblLine setHidden:YES];
            [cell.lblTitle setText:@"First Dose"];
            [cell.lblDate setText:@"12/04/13"];
            [cell.lblDate setTextColor:[UIColor colorWithRed:200.0f/255.0f green:199.0f/255.0f blue:204.0f/255.0f alpha:1.0f]];
            [cell.lblNext setHidden:YES];
            [cell.imgNotePad setHidden:NO];
        }
        else if(indexPath.section == 2)
        {
            if(indexPath == 0)
            {
                [cell.indicatorView setBackgroundColor:self.baseSegmentView.backgroundColor];
                [cell.lblLine setHidden:YES];
                [cell.lblTitle setText:@"First Dose"];
                [cell.lblDate setText:@"12/08/13"];
                [cell.lblDate setTextColor:[UIColor colorWithRed:200.0f/255.0f green:199.0f/255.0f blue:204.0f/255.0f alpha:1.0f]];
                [cell.lblNext setHidden:YES];
                [cell.imgNotePad setHidden:NO];
            }
            else
            {
                [cell.indicatorView setBackgroundColor:self.baseSegmentView.backgroundColor];
                [cell.lblLine setHidden:YES];
                [cell.lblTitle setText:@"Second Dose"];
                [cell.lblDate setText:@"03/02/13"];
                [cell.lblDate setTextColor:[UIColor colorWithRed:200.0f/255.0f green:199.0f/255.0f blue:204.0f/255.0f alpha:1.0f]];
                [cell.lblNext setHidden:YES];
                [cell.imgNotePad setHidden:YES];
            }
        }
        
        return cell;
    }
    else
    {
        DueImmunisationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DueImmunisationCell"];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        if(indexPath.section == 0)
        {
            [cell.indicatorView setBackgroundColor:[UIColor colorWithRed:244.0f/255.0f green:76.0f/255.0f blue:101.0f/255.0f alpha:1.0f]];
            [cell.lblTitle setText:@"HepB"];
            [cell.lblDate setText:@"15/04/13"];
            [cell.lblDate setTextColor:[UIColor colorWithRed:244.0f/255.0f green:76.0f/255.0f blue:101.0f/255.0f alpha:1.0f]];
            [cell.lblDose setText:@"Second Dose"];
        }
        else if(indexPath.section == 1)
        {
            if(indexPath == 0)
            {
                [cell.indicatorView setBackgroundColor:[UIColor colorWithRed:244.0f/255.0f green:76.0f/255.0f blue:101.0f/255.0f alpha:1.0f]];
                [cell.lblTitle setText:@"Dpat Dose"];
                [cell.lblDate setText:@"10/09/13"];
                [cell.lblDate setTextColor:[UIColor colorWithRed:200.0f/255.0f green:199.0f/255.0f blue:204.0f/255.0f alpha:1.0f]];
                [cell.lblDose setText:@"Third Dose"];
            }
            else
            {
                [cell.indicatorView setBackgroundColor:[UIColor colorWithRed:244.0f/255.0f green:76.0f/255.0f blue:101.0f/255.0f alpha:1.0f]];
                [cell.lblTitle setText:@"Polio"];
                [cell.lblDate setText:@"10/04/13"];
                [cell.lblDate setTextColor:[UIColor colorWithRed:200.0f/255.0f green:199.0f/255.0f blue:204.0f/255.0f alpha:1.0f]];
                [cell.lblDose setText:@"Second Dose"];
            }
        }
        return cell;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = tableView.frame;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 41)];
    [headerView setBackgroundColor:[UIColor colorWithRed:231.0f/255.0f green:231.0/255.0f blue:235.0f/255.0f alpha:1.0]];
    
    UILabel *lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, frame.size.width-40, 21)];
    [lblHeader setText:@"Section title"];
    [lblHeader setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi" size:15]];
    [lblHeader setTextColor:[UIColor colorWithRed:143.0f/255.0f green:143.0f/255.0f blue:149.0f/255.0f alpha:1.0f]];
    
    [headerView addSubview:lblHeader];
    
    if (self.segmentImu.selectedSegmentIndex == 0)
    {
        ImmunisationBaseDate *base = [immunisationList objectAtIndex:section];
        [lblHeader setText:base.sectionName];
    }
    else if(self.segmentImu.selectedSegmentIndex == 1)
    {
        ImmunisationBaseDate *base = [immunisationDueList objectAtIndex:section];
        [lblHeader setText:base.sectionName];
    }
    else
    {
        ImmunisationBaseDate *base = [immunisationDoneList objectAtIndex:section];
        [lblHeader setText:base.sectionName];
    }
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (IBAction)onClickSwitch:(id)sender
{
    if (self.segmentImu.selectedSegmentIndex == 0)
    {
        [self.tableView reloadData];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tool"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickAddNew:)];
        self.imuNavigationItem.rightBarButtonItem = rightButton;
        
        
    }
    else if(self.segmentImu.selectedSegmentIndex == 1)
    {
        [self.tableView reloadData];
        
        [self.imuNavigationItem setRightBarButtonItem:nil];
        
    }
    else if(self.segmentImu.selectedSegmentIndex == 2)
    {
        [self.tableView reloadData];
        [self.imuNavigationItem setRightBarButtonItem:nil];
    }
}


-(void)success:(id)response
{
    NSDictionary *dict = response;
    id statusStr_ = [dict objectForKey:@"status"];
    NSString *statusStr;
    
    if([statusStr_ isKindOfClass:[NSNumber class]])
    {
        statusStr = [statusStr_ stringValue];
    }
    else
    {
        statusStr = statusStr_;
    }
    if([statusStr isEqualToString:@"1"])
    {
        NSDictionary *dataDict = [dict objectForKey:@"data"];
        
        NSArray *listImmuniHolder = [dataDict objectForKey:@"immunisation"];
        if(listImmuniHolder.count)
        {
            NSMutableArray *temp = [NSMutableArray array];
            for(NSDictionary *dict in listImmuniHolder)
            {
                ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict dueStatus:NO];
                [temp addObject:immunisationData];
            }
            immunisationDueList = [temp mutableCopy];
            
            
            NSMutableArray *tempDone = [NSMutableArray array];
            for(NSDictionary *dict in listImmuniHolder)
            {
                ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict dueStatus:YES];
                [tempDone addObject:immunisationData];
            }
            immunisationDoneList = [tempDone mutableCopy];
            
            NSMutableArray *tempAll = [NSMutableArray array];
            for(NSDictionary *dict in listImmuniHolder)
            {
                ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict];
                [tempAll addObject:immunisationData];
            }
            immunisationList = [tempAll mutableCopy];
            
            [self.tableView reloadData];
        }
    }
}

-(void)failure:(id)response
{
    
}
@end

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

@interface ImmunisationsVC () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation ImmunisationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tool"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickAddNew:)];
    self.imuNavigationItem.rightBarButtonItem = rightButton;
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)onClickAddNew:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentImu.selectedSegmentIndex == 0)
    {
        if(section == 0)
        {
            return 1;
        }
        else
        {
            return 2;
        }
    }
    else if(self.segmentImu.selectedSegmentIndex == 1)
    {
        if(section == 0)
        {
            return 1;
        }
        else if (section == 1)
        {
            return 1;
        }
        else
        {
            return 2;
        }
    }
    else
    {
        if(section == 0)
        {
            return 1;
        }
        else
        {
            return 2;
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.segmentImu.selectedSegmentIndex == 0)
    {
        return 2;
        
    }
    else if(self.segmentImu.selectedSegmentIndex == 1)
    {
        return 3;
        
    }
    else
    {
        return 3;
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
            [cell.lblDate setTextColor:[UIColor lightGrayColor]];
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
                [cell.lblDate setTextColor:[UIColor lightGrayColor]];
                [cell.lblNext setHidden:YES];
            }
            else
            {
                [cell.indicatorView setBackgroundColor:cell.lblNext.backgroundColor];
                [cell.lblLine setHidden:YES];
                [cell.lblDate setText:@"15/04/13"];
                [cell.lblDate setTextColor:[UIColor redColor]];
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
            [cell.lblDate setTextColor:[UIColor lightGrayColor]];
            [cell.lblNext setHidden:YES];
            [cell.imgNotePad setHidden:NO];
        }
        else if(indexPath.section == 1)
        {
            [cell.indicatorView setBackgroundColor:self.baseSegmentView.backgroundColor];
            [cell.lblLine setHidden:YES];
            [cell.lblTitle setText:@"First Dose"];
            [cell.lblDate setText:@"12/04/13"];
            [cell.lblDate setTextColor:[UIColor lightGrayColor]];
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
                [cell.lblDate setTextColor:[UIColor lightGrayColor]];
                [cell.lblNext setHidden:YES];
                [cell.imgNotePad setHidden:NO];
            }
            else
            {
                [cell.indicatorView setBackgroundColor:self.baseSegmentView.backgroundColor];
                [cell.lblLine setHidden:YES];
                [cell.lblTitle setText:@"Second Dose"];
                [cell.lblDate setText:@"03/02/13"];
                [cell.lblDate setTextColor:[UIColor lightGrayColor]];
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
            [cell.indicatorView setBackgroundColor:[UIColor redColor]];
            [cell.lblTitle setText:@"HepB"];
            [cell.lblDate setText:@"15/04/13"];
            [cell.lblTitle setFont:[UIFont boldSystemFontOfSize:15]];
            [cell.lblDate setTextColor:[UIColor redColor]];
            [cell.lblDose setText:@"Second Dose"];
        }
        else if(indexPath.section == 1)
        {
            if(indexPath == 0)
            {
                [cell.indicatorView setBackgroundColor:[UIColor redColor]];
                [cell.lblTitle setText:@"Dpat Dose"];
                [cell.lblTitle setFont:[UIFont boldSystemFontOfSize:15]];
                [cell.lblDate setText:@"10/09/13"];
                [cell.lblDate setTextColor:[UIColor lightGrayColor]];
                [cell.lblDose setText:@"Third Dose"];
            }
            else
            {
                [cell.indicatorView setBackgroundColor:[UIColor redColor]];
                [cell.lblTitle setText:@"Polio"];
                [cell.lblTitle setFont:[UIFont boldSystemFontOfSize:15]];
                [cell.lblDate setText:@"10/04/13"];
                [cell.lblDate setTextColor:[UIColor lightGrayColor]];
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
    
    UILabel *lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, frame.size.width-40, 21)];
    [lblHeader setText:@"Section title"];
    [headerView addSubview:lblHeader];
    
    if (self.segmentImu.selectedSegmentIndex == 0)
    {
        if(section == 0)
        {
            [lblHeader setText:@"BCG (TUBERCULOSIS)"];
        }
        if(section == 1)
        {
            [lblHeader setText:@"HEPATITIS B"];
        }
        else
        {
            [lblHeader setText:@"dpAt (DIPTHERIA PERTUSSIS, TETANUS)"];
        }
    }
    else if(self.segmentImu.selectedSegmentIndex == 1)
    {
        if(section == 0)
        {
            [lblHeader setText:@"BCG (TUBERCULOSIS)"];
        }
        if(section == 1)
        {
            [lblHeader setText:@"HEPATITIS B"];
        }
        else
        {
            [lblHeader setText:@"dpAt (DIPTHERIA PERTUSSIS, TETANUS)"];
        }
    }
    else
    {
        if(section == 0)
        {
            [lblHeader setText:@"BCG (TUBERCULOSIS)"];
        }
        if(section == 1)
        {
            [lblHeader setText:@"dpAt (DIPTHERIA PERTUSSIS, TETANUS)"];
        }
        else
        {
            [lblHeader setText:@"POLIO"];
        }
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
@end

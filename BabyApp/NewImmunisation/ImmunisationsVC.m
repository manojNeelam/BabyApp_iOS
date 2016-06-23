//
//  ImmunisationsVC.m
//  BabyApp
//
//  Created by Jiten on 09/04/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#define kMAX_SECTION_SIZE 100

#define UnCheck @"unCheck"
#define Check   @"checkBox"

#import "ImmunisationsVC.h"
#import "AllImmunisationCell.h"
#import "DueImmunisationCell.h"
#import "ConnectionsManager.h"
#import "WSConstant.h"
#import "NSUserDefaults+Helpers.h"

#import "ImmunisationData.h"
#import "ImmunisationBaseDate.h"
#import "AppDelegate.h"

#import "NewImmunisationVC.h"

@interface ImmunisationsVC () <UITableViewDataSource,UITableViewDelegate, ServerResponseDelegate>
{
    NSArray *immunisationTypeList, *immunisationDueTypeList, *immunisationDoneTypeList, *immunisationDateList, *immunisationDueDateList, *immunisationDoneDateList, *immunisationList, *immunisationDueList, *immunisationDoneList;
    
    BOOL isDate;
    
}
@end

@implementation ImmunisationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.segmentDateType setSelectedSegmentIndex:1];
    
    
    NSLog(@"ImmunisationsVC PAge");
    
    isDate = YES;
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    UIFont *font = [UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [self.segmentImu setTitleTextAttributes:attributes
                                   forState:UIControlStateNormal];
    
   UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tool"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickAddNew:)];

    
 //   UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"imununisation_new2.jpg"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickAddNew:)];

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
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate setListOfChildrens:nil];

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ImmunisationData *immunisationData;
    
    if (self.segmentImu.selectedSegmentIndex == 0)
    {
        ImmunisationBaseDate *base = [immunisationList objectAtIndex:indexPath.section];
        immunisationData = [[base listOfData] objectAtIndex:indexPath.row];
        
        immunisationData.is_done = !immunisationData.is_done;
        
        [self update:immunisationData withStatus:!immunisationData.is_done];
    }
    else if(self.segmentImu.selectedSegmentIndex == 1)
    {
        
        ImmunisationBaseDate *base = [immunisationDoneList objectAtIndex:indexPath.section];
        immunisationData = [[base listOfData] objectAtIndex:indexPath.row];
        
        immunisationData.is_done = !immunisationData.is_done;
    }
    else
    {
        ImmunisationBaseDate *base = [immunisationDueList objectAtIndex:indexPath.section];
        immunisationData = [[base listOfData] objectAtIndex:indexPath.row];
        
        immunisationData.is_done = !immunisationData.is_done;
        
    }
    
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentImu.selectedSegmentIndex == 0)
    {
        AllImmunisationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllImmunisationCell"];
        [cell.lblDate setTextAlignment:NSTextAlignmentLeft];
        cell.lblNext.layer.cornerRadius = 5.0f;
        [cell.lblNext setClipsToBounds:YES];
        
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        [cell.imgNotePad setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickEditImmunisation:)];
        [cell.imgNotePad addGestureRecognizer:tap];
        [cell.imgNotePad setTag:indexPath.section * kMAX_SECTION_SIZE + indexPath.item];

        
        
        ImmunisationBaseDate *base = [immunisationList objectAtIndex:indexPath.section];
        if(base.listOfData)
        {
            ImmunisationData *immunisationData = [[base listOfData] objectAtIndex:indexPath.row];
            
            if(!immunisationData.is_done)
            {
                [cell.btnCheck setBackgroundImage:[UIImage imageNamed:UnCheck] forState:UIControlStateNormal];
                [cell.lblLine setHidden:YES];
                [cell.lblNext setHidden:NO];
                
                [cell.lblTitle setText:immunisationData.sequence];
                
                [cell.imgNotePad setHidden:YES];
                
            }
            else
            {
                [cell.btnCheck setBackgroundImage:[UIImage imageNamed:Check] forState:UIControlStateNormal];
                [cell.lblLine setHidden:NO];
                [cell.lblNext setHidden:YES];
                
                [cell.lblTitle setText:immunisationData.sequence];
                
                [cell.imgNotePad setHidden:NO];
                
            }
        }
        
        
        /*cell.lblNext.layer.cornerRadius = 8.0f;
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
         
         AllImmunisationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllImmunisationCell"];
         
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
         }*/
        
        return cell;
    }
    
    if (self.segmentImu.selectedSegmentIndex == 1)
    {
        AllImmunisationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllImmunisationCell"];
        [cell.lblDate setTextAlignment:NSTextAlignmentLeft];
        cell.lblNext.layer.cornerRadius = 5.0f;
        [cell.lblNext setClipsToBounds:YES];
        
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        [cell.imgNotePad setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickEditImmunisation:)];
        [cell.imgNotePad addGestureRecognizer:tap];
        [cell.imgNotePad setTag:indexPath.section * kMAX_SECTION_SIZE + indexPath.item];

        
        ImmunisationBaseDate *base = [immunisationDoneList objectAtIndex:indexPath.section];
        if(base.listOfData)
        {
            ImmunisationData *immunisationData = [[base listOfData] objectAtIndex:indexPath.row];
            
            if(immunisationData.is_done)
            {
                [cell.btnCheck setBackgroundImage:[UIImage imageNamed:UnCheck] forState:UIControlStateNormal];
                [cell.lblLine setHidden:NO];
                [cell.lblNext setHidden:YES];
                
                [cell.lblTitle setText:immunisationData.sequence];
                
                [cell.imgNotePad setHidden:YES];
                
            }
            else
            {
                [cell.btnCheck setBackgroundImage:[UIImage imageNamed:Check] forState:UIControlStateNormal];
                [cell.lblLine setHidden:YES];
                [cell.lblNext setHidden:NO];
                
                [cell.lblTitle setText:immunisationData.sequence];
                
                [cell.imgNotePad setHidden:NO];
                
            }
        }
        
        /*if(indexPath.section == 0)
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
         }*/
        
        return cell;
    }
    else
    {
        DueImmunisationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DueImmunisationCell"];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        
        ImmunisationBaseDate *base = [immunisationDueList objectAtIndex:indexPath.section];
        if(base.listOfData.count)
        {
            ImmunisationData *immunisationData = [[base listOfData] objectAtIndex:indexPath.row];
            
            if(immunisationData.is_done)
            {
                [cell.btnCheck setBackgroundImage:[UIImage imageNamed:UnCheck] forState:UIControlStateNormal];
                [cell.lblDate setText:immunisationData.date_given];
                
                [cell.lblTitle setText:immunisationData.sequence];
            }
            else
            {
                [cell.btnCheck setBackgroundImage:[UIImage imageNamed:Check] forState:UIControlStateNormal];
                [cell.lblDate setText:immunisationData.date_given];
                [cell.lblTitle setText:immunisationData.sequence];
                
            }
        }
        
        
        /*if(indexPath.section == 0)
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
         }*/
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
        ImmunisationBaseDate *base = [immunisationDoneList objectAtIndex:section];
        [lblHeader setText:base.sectionName];
    }
    else
    {
        ImmunisationBaseDate *base = [immunisationDueList objectAtIndex:section];
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

-(void)onClickEditImmunisation:(UITapGestureRecognizer *)sender
{
    ImmunisationData *immunisationData;
    
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:gesture.view.tag % kMAX_SECTION_SIZE
                                                inSection:(gesture.view.tag / kMAX_SECTION_SIZE)];
    
    if (self.segmentImu.selectedSegmentIndex == 0)
    {
        ImmunisationBaseDate *base = [immunisationList objectAtIndex:indexPath.section];
        if(base.listOfData)
        {
             immunisationData = [[base listOfData] objectAtIndex:indexPath.row];
        }
    }
    if (self.segmentImu.selectedSegmentIndex == 1)
    {
        ImmunisationBaseDate *base = [immunisationDoneList objectAtIndex:indexPath.section];
        if(base.listOfData)
        {
             immunisationData = [[base listOfData] objectAtIndex:indexPath.row];
        }
    }
    
    NewImmunisationVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewImmunisationVC_SB_ID"];
    vc.immunisationData = immunisationData;
    [self.navigationController pushViewController:vc animated:YES];
    
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
        
        NSDictionary *listImmuniHolder = [dataDict objectForKey:@"immunisation"];
        if([listImmuniHolder isKindOfClass:[NSArray class]])
        {
            if(listImmuniHolder.count)
            {
                
                //type
                
                
                NSMutableArray *temp = [NSMutableArray array];
                for(NSDictionary *dict in listImmuniHolder)
                {
                    ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict dueStatus:NO];
                    if(immunisationData && immunisationData != nil && immunisationData.listOfData.count)
                    {
                        [temp addObject:immunisationData];
                    }
                }
                immunisationDueList = [temp mutableCopy];
                
                
                NSMutableArray *tempDone = [NSMutableArray array];
                for(NSDictionary *dict in listImmuniHolder)
                {
                    ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict dueStatus:YES];
                    if(immunisationData && immunisationData != nil && immunisationData.listOfData.count)
                    {
                        [tempDone addObject:immunisationData];
                    }
                    
                    
                }
                immunisationDoneList = [tempDone mutableCopy];
                
                NSMutableArray *tempAll = [NSMutableArray array];
                for(NSDictionary *dict in listImmuniHolder)
                {
                    ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict];
                    
                    if(immunisationData && immunisationData != nil && immunisationData.listOfData.count)
                    {
                        [tempAll addObject:immunisationData];
                    }
                    
                }
                immunisationList = [tempAll mutableCopy];
                
                [self.tableView reloadData];
            }
        }
        else
        {
            NSArray *typeArray = [listImmuniHolder objectForKey:@"type"];
            
            NSArray *dateArray = [listImmuniHolder objectForKey:@"date"];
            
            
            if(typeArray.count)
            {
                NSMutableArray *temp = [NSMutableArray array];
                for(NSDictionary *dict in typeArray)
                {
                    ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict dueStatus:NO];
                    if(immunisationData && immunisationData != nil && immunisationData.listOfData.count)
                    {
                        [temp addObject:immunisationData];
                    }
                }
                immunisationDueTypeList = [temp mutableCopy];
                
                
                NSMutableArray *tempDone = [NSMutableArray array];
                for(NSDictionary *dict in typeArray)
                {
                    ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict dueStatus:YES];
                    if(immunisationData && immunisationData != nil && immunisationData.listOfData.count)
                    {
                        [tempDone addObject:immunisationData];
                    }
                    
                    
                }
                immunisationDoneTypeList = [tempDone mutableCopy];
                
                NSMutableArray *tempAll = [NSMutableArray array];
                for(NSDictionary *dict in typeArray)
                {
                    ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict];
                    
                    if(immunisationData && immunisationData != nil && immunisationData.listOfData.count)
                    {
                        [tempAll addObject:immunisationData];
                    }
                }
                immunisationTypeList = [tempAll mutableCopy];
            }
            if(dateArray.count)
            {
                NSMutableArray *temp = [NSMutableArray array];
                for(NSDictionary *dict in dateArray)
                {
                    ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict dueStatus:NO];
                    if(immunisationData && immunisationData != nil && immunisationData.listOfData.count)
                    {
                        [temp addObject:immunisationData];
                    }
                }
                immunisationDueDateList = [temp mutableCopy];
                
                
                NSMutableArray *tempDone = [NSMutableArray array];
                for(NSDictionary *dict in dateArray)
                {
                    ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict dueStatus:YES];
                    if(immunisationData && immunisationData != nil && immunisationData.listOfData.count)
                    {
                        [tempDone addObject:immunisationData];
                    }
                    
                    
                }
                immunisationDoneDateList = [tempDone mutableCopy];
                
                NSMutableArray *tempAll = [NSMutableArray array];
                for(NSDictionary *dict in dateArray)
                {
                    ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict];
                    
                    if(immunisationData && immunisationData != nil && immunisationData.listOfData.count)
                    {
                        [tempAll addObject:immunisationData];
                    }
                    
                }
                immunisationDateList = [tempAll mutableCopy];
            }
            
            [self onSwitchDateType:nil];
            
            [self.tableView reloadData];
        }
        
       
        
        
        /*if(listImmuniHolder.count)
        {
            
            //type
            
            
            NSMutableArray *temp = [NSMutableArray array];
            for(NSDictionary *dict in listImmuniHolder)
            {
                ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict dueStatus:NO];
                if(immunisationData && immunisationData != nil && immunisationData.listOfData.count)
                {
                    [temp addObject:immunisationData];
                }
            }
            immunisationDueList = [temp mutableCopy];
            
            
            NSMutableArray *tempDone = [NSMutableArray array];
            for(NSDictionary *dict in listImmuniHolder)
            {
                ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict dueStatus:YES];
                if(immunisationData && immunisationData != nil && immunisationData.listOfData.count)
                {
                    [tempDone addObject:immunisationData];
                }
                
                
            }
            immunisationDoneList = [tempDone mutableCopy];
            
            NSMutableArray *tempAll = [NSMutableArray array];
            for(NSDictionary *dict in listImmuniHolder)
            {
                ImmunisationBaseDate *immunisationData = [[ImmunisationBaseDate alloc] initwithDueDictionary:dict];
                
            if(immunisationData && immunisationData != nil && immunisationData.listOfData.count)
            {
                [tempAll addObject:immunisationData];
            }
                
            }
            immunisationList = [tempAll mutableCopy];
            
            [self.tableView reloadData];
        }*/
    }
}

-(void)failure:(id)response
{
    
}

-(void)update:(ImmunisationData *)immunisationData withStatus:(BOOL)isStatus
{
    //get_vaccine_type_detail
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:immunisationData.immuId forKey:@"immunisation_id"];
    [dict setObject:[NSNumber numberWithBool:isStatus] forKey:@"status"];
    
    [[ConnectionsManager sharedManager] updateImmunisation:dict withdelegate:self];
}

- (IBAction)onSwitchDateType:(id)sender
{
    if (self.segmentDateType.selectedSegmentIndex == 0)
    {
        
        //Date
        
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Immunisation"];
        [self.navigationController pushViewController:vc animated:NO];
        
        //immunisationDueList = immunisationDueDateList;
        //immunisationDoneList = immunisationDoneDateList;
        //immunisationList = immunisationDateList;
    }
    else
    {
        
        immunisationDueList = immunisationDueTypeList;
        immunisationDoneList = immunisationDoneTypeList;
        immunisationList = immunisationTypeList;
    }
   [self.tableView reloadData];
    
}
@end

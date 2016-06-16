//
//  immunisationTableViewController.m
//  BabyApp
//
//  Created by Charan Giri on 28/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "immunisationTableViewController.h"
#import "immunisationMainTableViewCell.h"
#import "immunisationSecondaryTableViewCell.h"
#import "ConnectionsManager.h"

#import "NSUserDefaults+Helpers.h"
#import "WSConstant.h"

#import "ImmunisationBaseDate.h"

@interface immunisationTableViewController ()<ServerResponseDelegate>
{
     NSArray *immunisationTypeList, *immunisationDueTypeList, *immunisationDoneTypeList, *immunisationDateList, *immunisationDueDateList, *immunisationDoneDateList, *immunisationList, *immunisationDueList, *immunisationDoneList;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation immunisationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Immunisations"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.navigationItem.rightBarButtonItem = [self addLeftButton];
    [self callreadAllImmunisation];
    
    [self.tableView reloadData];
    
}
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

-(UIBarButtonItem *)addLeftButton
{
    //UIImage *buttonImage = [UIImage imageNamed:@"calender_EvryDay"];
    
    //UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //[aButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    //aButton.frame = CGRectMake(0.0, 0.0, 20,20);
    
    UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calender_EvryDay"] style:UIBarButtonItemStyleDone target:self action:@selector(showCalender)];
    
    return aBarButtonItem;
}

-(void)showCalender
{
    //calenderSegue
    
    [self performSegueWithIdentifier:@"calenderSegue" sender:self];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
        return 90;
    }
    return 60;
}
/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 NSString *sectionName;
 
 switch (section)
 {
 case 0:
 sectionName = @"APR 2016";
 break;
 case 1:
 sectionName = @"MAR 2016";
 break;
 case 2:
 sectionName = @"FEB 2016";
 break;
 
 case 3:
 sectionName=  @"JAN 2016";
 break;
 // ...
 default:
 sectionName = @"";
 break;
 }
 return sectionName;
 }
 */


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ImmunisationBaseDate *base = [immunisationList objectAtIndex:section];
    return base.listOfData.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return immunisationList.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *header = @"customHeader";
    
    UITableViewHeaderFooterView *vHeader;
    
    vHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:header];
    
    if (!vHeader) {
        vHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:header];
    }
    
    NSString *sectionName;
    
    switch (section)
    {
        case 0:
            sectionName = @"APR 2016";
            break;
        case 1:
            sectionName = @"MAR 2016";
            break;
        case 2:
            sectionName = @"FEB 2016";
            break;
            
        case 3:
            sectionName=  @"JAN 2016";
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    
    
    vHeader.textLabel.text = sectionName;
    vHeader.textLabel.textColor=[UIColor lightGrayColor];
    
    return vHeader;
}

/*-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = tableView.frame;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 41)];
    [headerView setBackgroundColor:[UIColor colorWithRed:231.0f/255.0f green:231.0/255.0f blue:235.0f/255.0f alpha:1.0]];
    
    UILabel *lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, frame.size.width-40, 21)];
    [lblHeader setText:@"Section title"];
    [lblHeader setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi" size:15]];
    [lblHeader setTextColor:[UIColor colorWithRed:143.0f/255.0f green:143.0f/255.0f blue:149.0f/255.0f alpha:1.0f]];
    
    [headerView addSubview:lblHeader];
    
    ImmunisationBaseDate *base = [immunisationList objectAtIndex:section];
    [lblHeader setText:base.sectionName];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    //if(section == ...)
    //{
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    UIFont *myFont = [UIFont fontWithName:@"AvenirNextLTPro-Demi" size:15];
    [headerView.textLabel setFont:myFont];
    
    //}
}*/

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}*/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        
        immunisationMainTableViewCell *cell = (immunisationMainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"mainCell"];
        cell.colorLabel.layer.cornerRadius = cell.colorLabel.frame.size.width/2;
        [cell.colorLabel setClipsToBounds:YES];
        
        cell.backgroundColor=[UIColor whiteColor];
        cell.dateLabel.text=@"30";
        cell.monthLabel.text=@"Apr";
        cell.mainLabel.text=@"HepB(D1)";
        cell.subTitleLabel.text=@"Hepatits B vaccine, first dose";
        cell.titleLabel.text=@"Birth";
        
        return cell;
    }
    else
    {
        immunisationSecondaryTableViewCell *cell = (immunisationSecondaryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"secondCell"];
        cell.colorLabel.layer.cornerRadius = cell.colorLabel.frame.size.width/2;
        [cell.colorLabel setClipsToBounds:YES];
        
        cell.backgroundColor=[UIColor whiteColor];
        cell.subtitleLabel.text=@"Bacillus calmette-Guerin";
        cell.titleLabel.text=@"BCG";
        
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ImmunisationsSegue" sender:self];
}

//


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(NSNumber *)numfromString:(NSString *)aStr
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:aStr];
    
    return myNumber;
    
}


#pragma mark - reade immunisation
//all_immunisation_read
-(void)callreadAllImmunisation
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[self numfromString:[NSUserDefaults retrieveObjectForKey:USERID]] forKey:@"user_id"];
    [params setObject:[self numfromString:[NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID]] forKey:@"child_id"];
    
    
    //NSDictionary *params = @{@"user_id":@64,
                             //@"child_id":@10};
    [[ConnectionsManager sharedManager] readAllImmunisation:params withdelegate:self
     ];
    //    [[ConnectionsManager sharedManager] getVaccineType:nil withdelegate:self
    //     ];
    //    getVaccineType
}

#pragma mark - serverreseponse delegate
-(void)success:(id)response
{
    NSLog(@"read immunisation respone : %@",response);
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
    NSLog(@"read immunisation failure respone : %@",response);
    
}


- (IBAction)onSwitchDateType:(id)sender {
    if (self.segmentDateType.selectedSegmentIndex == 0)
    {
        immunisationDueList = immunisationDueDateList;
        immunisationDoneList = immunisationDoneDateList;
        immunisationList = immunisationDateList;
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

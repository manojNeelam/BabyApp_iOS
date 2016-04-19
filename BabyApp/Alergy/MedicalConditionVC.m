//
//  MedicalConditionVC.m
//  BabyApp
//
//  Created by Vishal Kolhe on 05/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "MedicalConditionVC.h"
#import "ConditionData.h"
#import "MedicalConditionCell.h"
#import "AllergyConditionVC.h"
#import "WSConstant.h"
#import "NSUserDefaults+Helpers.h"
#import "ConnectionsManager.h"

@interface MedicalConditionVC () <ServerResponseDelegate>
{
    
}
@end

@implementation MedicalConditionVC
@synthesize listOfObjects;

-(void)viewDidLoad
{
    [super viewDidLoad];
    //[self loadData];
    
    
}

-(void)loadAlergyList
{
    //get_allergy_list
    
    NSString *childID = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    if(childID && childID != nil)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:childID forKey:@"child_id"];
        [[ConnectionsManager sharedManager] getMedicalList:dict withdelegate:self];
    }
    else
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"52" forKey:@"child_id"];
        [[ConnectionsManager sharedManager] getMedicalList:dict withdelegate:self];
    }
}

-(void)loadData
{
    NSMutableArray *temp = [NSMutableArray array];
    
    ConditionData *drugData = [[ConditionData alloc] init];
    drugData.condition = @"Condition1";
    drugData.desc = @"Aenean solicitudin, forem quis bibendum auctor, nisi elit conseques ipdum, Aenean solicitudin, forem quis bibendum auctor, nisi elit conseques ipdum";
    
    [temp addObject:drugData];
    
    drugData = [[ConditionData alloc] init];
    drugData.condition = @"Condition2";
    drugData.desc = @"Aenean solicitudin, forem quis bibendum auctor, nisi elit conseques ipdum, Aenean solicitudin, forem quis bibendum auctor, nisi elit conseques ipdum";
    
    [temp addObject:drugData];
    
    drugData = [[ConditionData alloc] init];
    drugData.condition = @"Condition23";
    drugData.desc = @"Aenean solicitudin, forem quis bibendum auctor, nisi elit conseques ipdum, Aenean solicitudin, forem quis bibendum auctor, nisi elit conseques ipdum";
    
    listOfObjects = temp;
    
    [self.tableView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadAlergyList];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listOfObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MedicalConditionCell";
    MedicalConditionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    ConditionData *data = [listOfObjects objectAtIndex:indexPath.row];
    cell.editButton.tag=indexPath.row+100;
    [cell.editButton addTarget:self
                        action:@selector(editMedical:) forControlEvents:UIControlEventTouchDown];
    [cell populateData:data];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (IBAction)AddButtonAction:(id)sender {
    UIStoryboard *storyboard = self.navigationController.storyboard;
    
    AllergyConditionVC *detailPage = [storyboard
                                      instantiateViewControllerWithIdentifier:@"AllergyConditionVC_SB_ID"];
    
    [self.navigationController pushViewController:detailPage animated:YES];
    
}

-(IBAction)editMedical:(UIButton *)sender
{
    ConditionData *drugData = [listOfObjects objectAtIndex:sender.tag-100];
    
    UIStoryboard *storyboard = self.navigationController.storyboard;
    
    AllergyConditionVC *detailPage = [storyboard
                                      instantiateViewControllerWithIdentifier:@"AllergyConditionVC_SB_ID"];
    detailPage.coditionData = drugData;
    [self.navigationController pushViewController:detailPage animated:YES];
    
}


-(void)success:(id)response
{
    /*
     {
     data =     {
     "allergy list" =         (
     );
     "child_id" = 52;
     };
     message = success;
     status = 1;
     }
     */
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
        NSArray *alleryList = [dataDict objectForKey:@"medical condition list"];
        if(alleryList.count)
        {
            
            NSMutableArray *temp = [NSMutableArray array];
            
            for(NSDictionary *dict in alleryList)
            {
                //drugTitle, *reaction, *date, *status
                ConditionData *drug = [[ConditionData alloc] init];
                drug.condition = [dict objectForKey:@"condition"];
                drug.desc = [dict objectForKey:@"notes"];
                drug.condID = [dict objectForKey:@"id"];
                
                [temp addObject:drug];
                
            }
            
            listOfObjects = temp;
            
        }
        [self.tableView reloadData];
    }
}

-(void)failure:(id)response
{
    
}
@end

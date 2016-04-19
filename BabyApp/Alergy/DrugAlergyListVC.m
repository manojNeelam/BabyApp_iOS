//
//  DrugAlergyListVC.m
//  BabyApp
//
//  Created by Vishal Kolhe on 04/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "DrugAlergyListVC.h"
#import "DrugAlergyCell.h"
#import "DrugAlergyData.h"
#import "AddAllergyVC.h"
#import "ConnectionsManager.h"
#import "NSUserDefaults+Helpers.h"
#import "WSConstant.h"


@implementation DrugAlergyListVC
@synthesize listOfObjects;

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
}

-(void)loadData
{
    //    NSMutableArray *temp = [NSMutableArray array];
    //
    //    DrugAlergyData *drugData = [[DrugAlergyData alloc] init];
    //    drugData.drugTitle = @"Panadol";
    //    drugData.reaction = @"Reaction: Anaphylaxis";
    //    drugData.date = @"Date: 05/0612016";
    //    drugData.status = @"Confirmed: allergy";
    //
    //    [temp addObject:drugData];
    //
    //    drugData = [[DrugAlergyData alloc] init];
    //    drugData.drugTitle = @"Drug 2";
    //    drugData.reaction = @"Reaction: Anaphylaxis";
    //    drugData.date = @"Date: 05/0612016";
    //    drugData.status = @"Confirmed: allergy";
    //
    //    [temp addObject:drugData];
    //
    //    drugData = [[DrugAlergyData alloc] init];
    //    drugData.drugTitle = @"Drug 3";
    //    drugData.reaction = @"Reaction: Anaphylaxis";
    //    drugData.date = @"Date: 05/0612016";
    //    drugData.status = @"Confirmed: allergy";
    //
    //    [temp addObject:drugData];
    //
    //    listOfObjects = temp;
    NSString *childID = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    if(childID.length > 0)
    {
        NSDictionary *params = @{@"child_id": childID};
        [self getDrugAllergyList:params];
    }
    

    //    [self.tableView reloadData];
    
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
    static NSString *cellIdentifier = @"DrugAlergyCell";
    DrugAlergyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    DrugAlergyData *data = [listOfObjects objectAtIndex:indexPath.row];
    cell.btnEdit.tag=indexPath.row+100;
    [cell.btnEdit addTarget:self
                     action:@selector(editAlergy:) forControlEvents:UIControlEventTouchDown];
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
- (IBAction)addDrug:(id)sender {
    UIStoryboard *storyboard = self.navigationController.storyboard;
    
    AddAllergyVC *detailPage = [storyboard
                                instantiateViewControllerWithIdentifier:@"AddAllergyVC_SB_ID"];
    
    [self.navigationController pushViewController:detailPage animated:YES];
    
    
}
-(void)editAlergy:(id)sender
{
    UIStoryboard *storyboard = self.navigationController.storyboard;
    
    AddAllergyVC *detailPage = [storyboard
                                instantiateViewControllerWithIdentifier:@"AddAllergyVC_SB_ID"];
    
    [self.navigationController pushViewController:detailPage animated:YES];
}
#pragma mark - get Drug allergy Api
-(void)getDrugAllergyList:(NSDictionary *)param
{
    [[ConnectionsManager sharedManager] getAlergyList:param withdelegate:self];
}


#pragma mark - ServerResponseDelegate
-(void)success:(id)response
{
    
    NSLog(@"Success Response of get_allergy_list : %@ ",response);
    NSDictionary *responseDict = (NSDictionary *)response;
    dispatch_async(dispatch_get_main_queue()
                   , ^{
                       
                       if ([responseDict[@"status"] boolValue]) {
                           
                           
                           NSArray *allergyListArry = responseDict[@"allergy_list"];
                           listOfObjects = [NSMutableArray new];
                           for (NSDictionary *allerguDict in allergyListArry) {
                               //                               {
                               //                                   "id" : "1",
                               //                                   "drug_name" : "Hep B",
                               //                                   "allergic_reaction" : "Hepatitis”,
                               //                                   "date" : "Hep B",
                               //                                   "status" : "1"
                               //                               },
                               
                               DrugAlergyData *drugData = [[DrugAlergyData alloc] init];
                               drugData.drugID = allerguDict[@"id"];
                               drugData.reaction = allerguDict[@"allergic_reaction"];
                               
                               drugData.drugTitle = allerguDict[@"drug_name"];
                               
                               drugData.status = allerguDict[@"status"];
                               
                               drugData.date = allerguDict[@"date"];
                               [listOfObjects addObject:drugData];
                               
                               
                               
                           }
                           [self.tableView reloadData];
                       }
                       
                   });
}
-(void)failure:(id)response
{
    NSLog(@"Failure Response of the add immunisation : %@ ",response);
    
}


@end

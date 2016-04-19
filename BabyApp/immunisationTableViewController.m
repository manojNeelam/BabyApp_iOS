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

@interface immunisationTableViewController ()<ServerResponseDelegate>

@end

@implementation immunisationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
     self.navigationItem.rightBarButtonItem = [self addLeftButton];
    [self callreadAllImmunisation];
}
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

-(UIBarButtonItem *)addLeftButton
{
    UIImage *buttonImage = [UIImage imageNamed:@"teeth.png"];
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [aButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    aButton.frame = CGRectMake(0.0, 0.0, 40,40);
    
    UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    
    [aButton addTarget:self action:@selector(showCalender) forControlEvents:UIControlEventTouchUpInside];
    
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
    vHeader.textLabel.textColor=[UIColor grayColor];
    
    return vHeader;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
    
    immunisationMainTableViewCell *cell = (immunisationMainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"mainCell"];
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

#pragma mark - reade immunisation
//all_immunisation_read
-(void)callreadAllImmunisation
{
    NSDictionary *params = @{@"user_id":@64,
                             @"child_id":@10};
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
}
-(void)failure:(id)response
{
    NSLog(@"read immunisation failure respone : %@",response);

}


@end

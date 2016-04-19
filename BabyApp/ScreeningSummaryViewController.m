//
//  ScreeningSummaryViewController.m
//  BabyApp
//
//  Created by Sarvajeet Singh on 3/20/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "ScreeningSummaryViewController.h"
#import "HealthBookletViewController.h"

#define Period @"period"
#define DueStatus @"dueStatus"

@interface ScreeningSummaryViewController ()

- (IBAction)openHealthBook:(id)sender;
@property (strong, nonatomic) NSArray *screeningSummaryArray;

@end

@implementation ScreeningSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title =@"Screening Summary";

    self.screeningSummaryArray = @[@{Period     : @"4-8 weeks",
                                     DueStatus  : @"Taken: 10/02/2016"
                                     },
                                   @{Period     : @"3-5 months",
                                     DueStatus  : @"Next due: 15/02/2016"
                                     },
                                   @{Period     : @"6-12 months",
                                     DueStatus  : @"Set reminder"
                                     },
                                   @{Period     : @"15-18 months",
                                     DueStatus  : @"Set reminder"
                                     },
                                   @{Period     : @"2-3 years",
                                     DueStatus  : @"Set reminder"
                                     },
                                   @{Period     : @"4-6 years",
                                     DueStatus  : @"Set reminder"
                                     }];
    
    [self.screeningSummaryTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TableView Delegate and data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.screeningSummaryArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"screenSummary"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"screenSummary"];
    }
    
    NSDictionary *info = [self.screeningSummaryArray objectAtIndex:[indexPath row]];
    [cell.textLabel setText:[info objectForKey:Period]];
    [cell.detailTextLabel setText:[info objectForKey:DueStatus]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
  //   [self performSegueWithIdentifier:@"screeningsummarydetailsegu" sender:self];
}


- (IBAction)openHealthBook:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    
    HealthBookletViewController *healthVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"Health"];
    
    
    [self.navigationController pushViewController:healthVC animated:YES];
    
    
}
@end

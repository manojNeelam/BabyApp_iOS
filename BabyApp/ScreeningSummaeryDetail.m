//
//  ScreeningSummaeryDetail.m
//  BabyApp
//
//  Created by Sarvajeet Singh on 3/21/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "ScreeningSummaeryDetail.h"
#import "ScreenSumaryDetailCell.h"
#define lbl @"detailText"
#define DetailStatus @"State"

@interface ScreeningSummaeryDetail ()
@property (strong, nonatomic) NSArray *screeningSummaryDetailArray;

@end

@implementation ScreeningSummaeryDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"Screening Summary";

    self.screeningSummaryDetailArray = @[@{lbl     : @"I ensure that blosters,pillows,blankets and plastics bags are kept away from my baby to avoid unintentional suffocation.I always place my baby to sleep on his back.",
                                     DetailStatus  : @"YES"
                                     },
                                   @{lbl     : @"I do not use a sarong cradle for my child nor allow him/her  to the same bed as me to avoid rolling onto and suffocating him/her.My baby ",
                                     DetailStatus  : @"Next due: 15/02/2016"
                                     },
                                   @{lbl     : @"I ensure that blosters,pillows,blankets and plastics bags are kept away from my baby to avoid unintentional suffocation.I always place my baby to sleep on his back.",
                                     DetailStatus  : @"Set reminder"
                                     },
                                   @{lbl     : @"15-18 months",
                                     DetailStatus  : @"Set reminder"
                                     },
                                   @{lbl     : @"2-3 years",
                                     DetailStatus  : @"Set reminder"
                                     },
                                  ];
    
    [self.screeningSummaryDetailTable reloadData];}



#pragma mark - TableView Delegate and data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.screeningSummaryDetailArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScreenSumaryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreenSummaryDetail"];
   
    NSDictionary *info = [self.screeningSummaryDetailArray objectAtIndex:[indexPath row]];
    NSLog(@"info=%@",info);
    [cell.detailLabel setText:[info objectForKey:lbl]];
    [cell.statusBtn setBackgroundColor:[UIColor grayColor]];
    [[cell.statusBtn layer] setCornerRadius:cell.statusBtn.frame.size.width/2];
    [cell.statusBtn setClipsToBounds:YES];
    [cell.contentView updateConstraintsIfNeeded];
    [cell layoutIfNeeded];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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

@end

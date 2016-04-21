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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"screenSummary2"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"screenSummary2"];
        
        
        UILabel *lblName=nil;
        lblName=[[UILabel alloc] initWithFrame:CGRectMake(20,8, self.view.frame.size.width-70, 30)];
        lblName.tag=10;
        [cell.contentView addSubview:lblName];
        
        
        UILabel *lblName2=nil;
        lblName2=[[UILabel alloc] initWithFrame:CGRectMake(20,35,self.view.frame.size.width-70, 30)];
        lblName2.tag=20;
        [cell.contentView addSubview:lblName2];
        
        [lblName setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi"
                                         size:18]];
        [lblName2 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi" size:14]];
        [lblName2 setTextColor:[UIColor colorWithRed:108.0/255.0 green:107.0/255.0 blue:108.0/255.0 alpha:1.0]];
        
        
        UIButton *btIcon=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-40,10,25,25)];
        btIcon.tag=30;
        [cell.contentView addSubview:btIcon];
        [btIcon setContentMode:UIViewContentModeScaleAspectFill];
        [btIcon setClipsToBounds:YES];


        [btIcon setUserInteractionEnabled:NO];
        cell.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
    // [lblName setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    // [lblName2 setFont:[UIFont fontWithName:@"HelveticaNeueCyr-Light" size:12]];
    
  //  [lblName setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi" size:18]];
    
    
  //  [lblName2 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:14]];
    

    
    
    NSDictionary *info = [self.screeningSummaryArray objectAtIndex:[indexPath row]];
    //[cell.textLabel setText:[info objectForKey:Period]];
   // [cell.detailTextLabel setText:[info objectForKey:DueStatus]];
    
    UILabel *lblName=[cell.contentView viewWithTag:10];
    UILabel *lblName2=[cell.contentView viewWithTag:20];

    [lblName setText:[info objectForKey:Period]];
    [lblName2 setText:[info objectForKey:DueStatus]];
    
    UIButton *btIcon=[cell.contentView viewWithTag:30];
    
    [btIcon setBackgroundImage:[UIImage imageNamed:@"Screenings-checked_03.png"] forState:UIControlStateNormal];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    UIButton *btIcon=[cell.contentView viewWithTag:30];
    
    if([[btIcon backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"unCheck"]])
    {
        [btIcon setBackgroundImage:[UIImage imageNamed:@"Screenings-checked_03.png"] forState:UIControlStateNormal];
    }
    else
    {
        [btIcon setBackgroundImage:[UIImage imageNamed:@"unCheck"] forState:UIControlStateNormal];
    }
    
    //   [self performSegueWithIdentifier:@"screeningsummarydetailsegu" sender:self];
}


- (IBAction)openHealthBook:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    
    HealthBookletViewController *healthVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"Health"];
    
    
    [self.navigationController pushViewController:healthVC animated:YES];
    
    
}
@end

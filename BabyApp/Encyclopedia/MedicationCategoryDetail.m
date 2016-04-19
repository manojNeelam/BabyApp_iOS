//
//  MedicationCategoryDetail.m
//  BabyApp
//
//  Created by Atul Awasthi on 18/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "MedicationCategoryDetail.h"

@interface MedicationCategoryDetail ()

@end

@implementation MedicationCategoryDetail
@synthesize medicationCategoryDetailTable;

NSArray *arraymedicationCategoryDetail;
NSDictionary *d;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedMedicationLbl"];
    
    
    d=(NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedMedicationDetail"];
    NSLog(@"MedicationCategoryDetail d=%@",d);

    
    arraymedicationCategoryDetail=[NSArray arrayWithObjects:self.navigationItem.title,@"SIDE EFFECTS",@"DOSAGE",@"OTHER INFO", nil];
    
    
    
    medicationCategoryDetailTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60)];
    [self.view addSubview:medicationCategoryDetailTable];
    medicationCategoryDetailTable.dataSource=self;
    medicationCategoryDetailTable.delegate=self;
    
  }

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Stores"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Stores"];
        
        
        UILabel *lblName=nil;
        
        lblName=[[UILabel alloc] initWithFrame:CGRectMake(10,5, medicationCategoryDetailTable.frame.size.width-30, 35)];
        lblName.tag=10;
        [cell.contentView addSubview:lblName];
        
        
        UILabel *lblName2=nil;
        
        lblName2=[[UILabel alloc] initWithFrame:CGRectMake(10,30,medicationCategoryDetailTable.frame.size.width-30, 80)];
        lblName2.tag=20;
        [cell.contentView addSubview:lblName2];
        [lblName setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
        [lblName2 setFont:[UIFont fontWithName:@"HelveticaNeueCyr-Light" size:16]];
        
        
        [lblName2 setLineBreakMode:NSLineBreakByWordWrapping];
        [lblName2 setNumberOfLines:0];
        
    }
    UILabel *lblName=[cell.contentView viewWithTag:10];
    UILabel *lblName2=[cell.contentView viewWithTag:20];
    
    if(indexPath.row==0)
    {
        [cell setBackgroundColor:[UIColor colorWithRed:37.0/255.0 green:146.0/255.0 blue:142.0/255.0 alpha:1.0]];
        [lblName setTextColor:[UIColor whiteColor]];
        [lblName2 setTextColor:[UIColor whiteColor]];
        [lblName setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20]];
        
        [lblName2 setText:[d objectForKey:@"description"]];
        
        
        lblName2.frame=CGRectMake(10,40,medicationCategoryDetailTable.frame.size.width-30,110);
    }
    else if(indexPath.row==1)
    {
        [cell setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:223.0/255.0 alpha:1.0]];
        [lblName2 setTextColor:[UIColor grayColor]];
        [lblName setTextColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
        [lblName2 setText:[d objectForKey:@"sideeffects"]];
        
    }
    else if(indexPath.row==2)
    {
        [cell setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:242.0/255.0 alpha:1.0]];
        [lblName2 setTextColor:[UIColor grayColor]];
        [lblName setTextColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
        [lblName2 setText:[d objectForKey:@"dosage"]];
        
    }
    
    else
    {
        [cell setBackgroundColor:[UIColor whiteColor]];
        [lblName2 setTextColor:[UIColor grayColor]];
        [lblName setTextColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
        [lblName2 setText:[d objectForKey:@"otherinfo"]];
        
    }
    
    
    
    
    [lblName setText:[arraymedicationCategoryDetail objectAtIndex:indexPath.row]];
    
    
    
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"didDeselectRowAtIndexPath");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arraymedicationCategoryDetail.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 170;
    }
    else
    {
        return 110;
    }
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

//
//  ImmunisationType.m
//  BabyApp
//
//  Created by Atul Awasthi on 17/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "ImmunisationType.h"

@interface ImmunisationType ()

@end

@implementation ImmunisationType
@synthesize immunisationDetailTable;
NSArray *arrayImmunisationType;
NSDictionary *d2;

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.title = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedMedicationLbl"];
    
    
      d2=(NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedImmunisationTypeDetail"];
    NSLog(@"ImmunisationType d=%@",d2);
    
    
    arrayImmunisationType=[NSArray arrayWithObjects:self.navigationItem.title,@"INFO",@"OTHER INFO",@"LEARN MORE", nil];
    
    
    
    immunisationDetailTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60)];
    [self.view addSubview:immunisationDetailTable];
    immunisationDetailTable.dataSource=self;
    immunisationDetailTable.delegate=self;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Stores"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Stores"];
        
        
        UILabel *lblName=nil;
        
        lblName=[[UILabel alloc] initWithFrame:CGRectMake(20,15, immunisationDetailTable.frame.size.width-40, 25)];
        lblName.tag=10;
        [cell.contentView addSubview:lblName];
        
        
        UILabel *lblName2=nil;
        
        lblName2=[[UILabel alloc] initWithFrame:CGRectMake(20,35,immunisationDetailTable.frame.size.width-40, 40)];
        lblName2.tag=20;
        [cell.contentView addSubview:lblName2];
        [lblName setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
        [lblName2 setFont:[UIFont fontWithName:@"HelveticaNeueCyr-Light" size:16]];
        
        
      //  [lblName2 setLineBreakMode:NSLineBreakByWordWrapping];
        [lblName2 setNumberOfLines:0];
        
        UILabel *lblName3=nil;
        
        lblName3=[[UILabel alloc] initWithFrame:CGRectMake(20,30,immunisationDetailTable.frame.size.width-30, 80)];
        lblName3.tag=30;
        [cell.contentView addSubview:lblName3];
        
        
    }
    UILabel *lblName=[cell.contentView viewWithTag:10];
    UILabel *lblName2=[cell.contentView viewWithTag:20];
    
    if(indexPath.row==0)
    {
        UILabel *lblName3=[cell.contentView viewWithTag:30];
        [cell setBackgroundColor:[UIColor colorWithRed:38.0/255.0 green:148.0/255.0 blue:143.0/255.0 alpha:1.0]];
        [lblName setTextColor:[UIColor whiteColor]];
        [lblName2 setTextColor:[UIColor colorWithRed:133.0/255.0 green:199.0/255.0 blue:195.0/255.0 alpha:1.0]];
        
        [lblName setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi"
                                         size:24]];
        [lblName2 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15]];

        
        lblName.frame=CGRectMake(20,20, immunisationDetailTable.frame.size.width-45, 30);
        lblName3.frame=CGRectMake(20,48,immunisationDetailTable.frame.size.width-45,20);
        
        [lblName setBackgroundColor:[UIColor clearColor]];
        [lblName3 setBackgroundColor:[UIColor clearColor]];
        
        [lblName2 setBackgroundColor:[UIColor clearColor]];
        
        [lblName3 setTextColor:[UIColor whiteColor]];
        
        [lblName3 setText:@"Prescription"];
        [lblName3 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:14]];
        
 
        
        
        [lblName2 setText:[d2 objectForKey:@"description"]];
        
        
      //  lblName2.frame=CGRectMake(10,40,immunisationDetailTable.frame.size.width-30,110);
         lblName2.frame=CGRectMake(20,75,immunisationDetailTable.frame.size.width-45,lblName2.text.length/40*35);
    }
    else if(indexPath.row==1)
    {
        [lblName setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi"
                                         size:14]];
        [lblName2 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:14]];
        

        
        [cell setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:223.0/255.0 alpha:1.0]];
        [lblName2 setTextColor:[UIColor grayColor]];
        [lblName setTextColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
        [lblName2 setText:[d2 objectForKey:@"info"]];
        
    }
    else if(indexPath.row==2)
    {
        [lblName setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi"
                                         size:14]];
        [lblName2 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:14]];
        

        [cell setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:242.0/255.0 alpha:1.0]];
        [lblName2 setTextColor:[UIColor grayColor]];
        [lblName setTextColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
        [lblName2 setText:[d2 objectForKey:@"otherinfo"]];
        
    }
    
    else
    {
        [lblName setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi"
                                         size:14]];
        [lblName2 setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:14]];
        

        [cell setBackgroundColor:[UIColor whiteColor]];
        [lblName2 setTextColor:[UIColor grayColor]];
        [lblName setTextColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
        [lblName2 setText:@""];
        
    }
    
    NSMutableAttributedString *attrString =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: lblName2.attributedText];
    
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:3];
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:style
                       range:NSMakeRange(0, lblName2.text.length)];
    lblName2.attributedText = attrString;
    
    
    
    
    [lblName setText:[arrayImmunisationType objectAtIndex:indexPath.row]];
    
    
    
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"didDeselectRowAtIndexPath");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayImmunisationType.count;
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

//
//  GrowthScreening.m
//  BabyApp
//
//  Created by Atul Awasthi on 08/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "GrowthScreening.h"
#import "ConnectionsManager.h"
#import "NSUserDefaults+Helpers.h"
#import "WSConstant.h"
#import "CustomIOS7AlertView.h"

@interface GrowthScreening ()<CustomIOS7AlertViewDelegate,ServerResponseDelegate>
{
    NSMutableArray *txtfieldAr2;

}
@end

@implementation GrowthScreening

@synthesize screeningGrowthTable;
NSArray *labelArrayGrowth;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    txtfieldAr2=[[NSMutableArray alloc] init];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(onClickSave:)];
    
    
    // Do any additional setup after loading the view.
    labelArrayGrowth=[NSArray arrayWithObjects:@"Weight*kg",@"Length*cm",@"Occipitofrontal Circumference*cm", nil];
    
    self.navigationItem.title = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedScreenLbl"] capitalizedString];
    
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 50)];
    [v setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:242.0/255.0 alpha:1.0]];
    [self.view addSubview:v];
    
    screeningGrowthTable=[[UITableView alloc] initWithFrame:CGRectMake(0, v.frame.origin.y+v.frame.size.height+10, self.view.frame.size.width, 180)];
    [self.view addSubview:screeningGrowthTable];
    screeningGrowthTable.dataSource=self;
    screeningGrowthTable.delegate=self;
    NSString *childStr = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if(childStr && childStr != nil)
    {
        [dict setObject:childStr forKey:@"child_id"];
    }
    else
    {
        [dict setObject:@"52" forKey:@"child_id"];
    }
    [[NSUserDefaults standardUserDefaults] objectForKey:@"child_id"];
    
    [dict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"screening_id"] forKey:@"screening_id"];
    
    NSLog(@"dict=%@",dict);
    [[ConnectionsManager sharedManager] readGrowth:dict withdelegate:self];
    
}

-(void)onClickSave:(id)sender
{
    
    
    NSString *childStr = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if(childStr && childStr != nil)
    {
        [dict setObject:childStr forKey:@"child_id"];
    }
    else
    {
        [dict setObject:@"52" forKey:@"child_id"];
    }
    [[NSUserDefaults standardUserDefaults] objectForKey:@"child_id"];
    
    [dict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"screening_id"] forKey:@"screening_id"];
    
 
    [dict setObject:[(UITextField*)[txtfieldAr2 objectAtIndex:0] text] forKey:@"weight"];
    [dict setObject:[(UITextField*)[txtfieldAr2 objectAtIndex:1] text] forKey:@"length"];
    [dict setObject:[(UITextField*)[txtfieldAr2 objectAtIndex:2] text] forKey:@"occitofrontal_circ"];

    NSLog(@"dict=%@",dict);
    
    [[ConnectionsManager sharedManager] updateGrowth:dict withdelegate:self];
    
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
        
        if ([[dict allKeys] containsObject:@"data"])
        {
            NSDictionary *dataList_ = [dict objectForKey:@"data"];
            NSLog(@"First api result with screenoing id list recived");
            
            
            /*
             "data": {
             "screening_id": "1",
             "child_id": "1",
             "weight": "4",
             "length": "1",
             "occitofrontal_circ": "3"
             }

             */
            [(UITextField*)[txtfieldAr2 objectAtIndex:0] setText:[dataList_ objectForKey:@"weight"]];
            [(UITextField*)[txtfieldAr2 objectAtIndex:1] setText:[dataList_ objectForKey:@"length"]];
            [(UITextField*)[txtfieldAr2 objectAtIndex:2] setText:[dataList_ objectForKey:@"occitofrontal_circ"]];
            
        }
        else
        {
            
            
            
            NSLog(@"Second api result with update recived");
        }
    }
    
}





-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Stores"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Stores"];
        
        
        UILabel *lblName=nil;
        
        lblName=[[UILabel alloc] initWithFrame:CGRectMake(20,10, 250, 30)];
        lblName.tag=10;
        [lblName setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]];
        [cell.contentView addSubview:lblName];
        
        UITextField *lblMesure=nil;
        lblMesure=[[UITextField alloc] initWithFrame:CGRectMake(250,10, screeningGrowthTable.frame.size.width-280, 30)];
        lblMesure.tag=20;
        [lblMesure setTextAlignment:NSTextAlignmentRight];
        [lblMesure setFont:[UIFont fontWithName:@"AvenirNextLTPro-Demi" size:16.0f]];
        [cell.contentView addSubview:lblMesure];
        [txtfieldAr2 addObject:lblMesure];

        
    }
    UILabel *lblName=[cell.contentView viewWithTag:10];
    UITextField *lblMesure=[cell.contentView viewWithTag:20];
    
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    [lblName setTextColor:[UIColor darkGrayColor]];
    
    [lblMesure setPlaceholder:[[[labelArrayGrowth objectAtIndex:indexPath.row] componentsSeparatedByString:@"*"] objectAtIndex:1]];
    [lblName setText:[[[labelArrayGrowth objectAtIndex:indexPath.row] componentsSeparatedByString:@"*"] objectAtIndex:0]];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:( NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setObject:[labelArrayGrowth objectAtIndex:indexPath.row] forKey:@"selectedScreenLbl"];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"didDeselectRowAtIndexPath");
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return labelArrayGrowth.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"accessoryButtonTappedForRowWithIndexPath at row=%ld",(long)indexPath.row);
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

//
//  ScreeningExamination.m
//  BabyApp
//
//  Created by Atul Awasthi on 09/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "ScreeningExamination.h"
#import "ConnectionsManager.h"
#import "NSUserDefaults+Helpers.h"
#import "WSConstant.h"
#import "CustomIOS7AlertView.h"
#import "Constants.h"



@interface ScreeningExamination ()<CustomIOS7AlertViewDelegate,ServerResponseDelegate>
{
    NSMutableArray *arrList;
    BOOL isDone;
}
@end

@implementation ScreeningExamination
@synthesize screeningExaminationTable;
//screeningexaminationsegue
NSArray *labelArrayExamination;
- (void)viewDidLoad {
    [super viewDidLoad];
    isDone  = NO;
    NSLog(@"View did load Screening Examination");
    // Do any additional setup after loading the view.
    labelArrayExamination=[NSArray arrayWithObjects:@"EYE EXAMINATION:",@"Fixation on moving object:",@"Right eye",@"Left eye",@"Cornea/Lens",@"Pupillary Light reflex",@"Red reflex",@"Nystagmus",@"Sqint",@"Roving eye movement",@" ",@"Fontanelies",@"Ears",@"Teeth",@" ",@"Hearth",@"Lungs",@"Abdomen",@" ",@"Femoral",@"Genitals",@"Hips",@" ",@"Posture",@"Muscle",@"Skin", nil];
    
    
    NSArray *kerArr=[NSArray arrayWithObjects:@"*",@"*",@"right_eye",@"left_eye",@"corenea_lence",@"pupillary_light",@"red_reflex",@"nystagmus",@"squint",@"roving_eye_moment",@"*",@"fontanelies",@"ears",@"teeth",@"*",@"heart",@"lungs",@"abdomen",@"*",@"femoral",@"genitals",@"hips",@"*",@"posture",@"muscle",@"skin", nil];
    
    arrList=[[NSMutableArray alloc] init];
    int i=0;
    for(NSString *s in labelArrayExamination)
    {
        int status;
        if(i==0||i==1||i==10||i==14||i==18||i==22)
        {
            status=-1;
        }
        else
        {
            status=0;
        }
        NSDictionary *dct=[[NSDictionary alloc] initWithObjectsAndKeys:s,@"label",[NSString stringWithFormat:@"%d",status],@"status",[kerArr objectAtIndex:i],@"key", nil];
        [arrList addObject:dct];
        i++;

    }
    
    self.navigationItem.title = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedScreenLbl"] capitalizedString];
    
    /*UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 50)];
     [v setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:240.0/255.0 alpha:1.0]];
     [self.view addSubview:v];
     
     
     UILabel *lblHeading=[[UILabel alloc] initWithFrame:CGRectMake(20,10, v.frame.size.width-60, 30)];
     [v addSubview:lblHeading];
     [lblHeading setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f]];
     
     [lblHeading setTextColor:[UIColor colorWithRed:87.0/255.0 green:87.0/255.0 blue:88.0/255.0 alpha:1.0]];
     [lblHeading setText:@"EYE EXAMINATION:"];
     
     */
    screeningExaminationTable=[[UITableView alloc] initWithFrame:CGRectMake(0,10, self.view.frame.size.width, self.view.frame.size.height-65)];
    [self.view addSubview:screeningExaminationTable];
    screeningExaminationTable.dataSource=self;
    screeningExaminationTable.delegate=self;
    [screeningExaminationTable setBounces:NO];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(onClickSave:)];
    
    
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
    [[ConnectionsManager sharedManager] readPhysicalExamination:dict withdelegate:self];
    
    
    
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
            NSLog(@"First api result with screenoing id list recived dataList_=%@",dataList_);
            
            if (isDone) {
                isDone = NO;
                
                 [Constants showOKAlertWithTitle:@"Success!" message:@"Data Saved Successfully" presentingVC:self];
            }
           
            
        }
        else
        {
            
            
            NSLog(@"Second api result with update recived");
        }
    }
    
}




-(void)onClickSave:(id)sender
{
    
    NSLog(@"onClickSave=%@",arrList);
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    for(NSDictionary *d in arrList)
    {
        if(![[d objectForKey:@"key"] isEqualToString:@"*"])
        {
            [dict setObject:[d objectForKey:@"status"] forKey:[d objectForKey:@"key"]];
        }
    }
    
    NSString *childStr = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    if(childStr && childStr != nil)
    {
        [dict setObject:childStr forKey:@"child_id"];
    }
    else
    {
        [dict setObject:@"52" forKey:@"child_id"];
    }
    
    [dict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"screening_id"] forKey:@"screening_id"];
    isDone = YES;
    NSLog(@"dict=%@",dict);
   [[ConnectionsManager sharedManager] updatePhysicalExamination:dict withdelegate:self];

    
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Stores"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Stores%d",indexPath.row]];
    
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Stores%d",indexPath.row]];
        
        
        UILabel *lblName=nil;
        
        lblName=[[UILabel alloc] initWithFrame:CGRectMake(20,15, screeningExaminationTable.frame.size.width-80, 30)];
        lblName.tag=10;
        [cell.contentView addSubview:lblName];
        
        
        
        
        
        
        
        
        if(indexPath.row!=1&&indexPath.row!=0&& indexPath.row!=10&&indexPath.row!=14&&indexPath.row!=18&&indexPath.row!=22)
        {
            
            if(indexPath.row==7||indexPath.row==8||indexPath.row==9)
            {
                UISegmentedControl *sgt=[self maheSegmentControl:YES];
                [cell.contentView addSubview:sgt];
                sgt.tag=30;
                [sgt setHidden:YES];
            }
            else
            {
                UIButton *btIcon=[[UIButton alloc] initWithFrame:CGRectMake(screeningExaminationTable.frame.size.width-40,10,25,25)];
                btIcon.tag=20;
                [cell.contentView addSubview:btIcon];
                [btIcon setContentMode:UIViewContentModeScaleAspectFill];
                [btIcon setClipsToBounds:YES];
                [btIcon setHidden:YES];
                [btIcon setUserInteractionEnabled:NO];
                
            }
        }
    }
    
    NSDictionary *dct=[arrList objectAtIndex:indexPath.row];
    
    if(indexPath.row!=1&&indexPath.row!=0&&indexPath.row!=10&&indexPath.row!=14&&indexPath.row!=18&&indexPath.row!=22)
    {
        NSLog(@"status for mark=%@ at index=%d",[dct objectForKey:@"status"],indexPath.row);
        
        if(indexPath.row==7||indexPath.row==8||indexPath.row==9)
        {
            UISegmentedControl *sgt=[cell.contentView viewWithTag:30];
            [sgt setHidden:NO];
            if([[dct objectForKey:@"status"] isEqualToString:@"0"])
                [sgt setSelectedSegmentIndex:1];
            else if([[dct objectForKey:@"status"] isEqualToString:@"1"])
                [sgt setSelectedSegmentIndex:0];
            
            
            [self onClickSegment:sgt];
            
        }
        else
        {
            UIButton *btIcon=[cell.contentView viewWithTag:20];
            [btIcon setHidden:NO];
            
            if([[dct objectForKey:@"status"] isEqualToString:@"0"])
                [btIcon setBackgroundImage:[UIImage imageNamed:@"unCheck"] forState:UIControlStateNormal];
            else if([[dct objectForKey:@"status"] isEqualToString:@"1"])
                [btIcon setBackgroundImage:[UIImage imageNamed:@"Screenings-checked_03.png"] forState:UIControlStateNormal];
            
            
        }
    }
    
    
    
    
    UITextField *lblName=[cell.contentView viewWithTag:10];
    
    
    
    
    if(indexPath.row==0)
    {
        [lblName setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0f]];
        [lblName setTextColor:[UIColor colorWithRed:87.0/255.0 green:87.0/255.0 blue:88.0/255.0 alpha:1.0]];
        
    }
    else
    {
        [lblName setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:17]];
        [lblName setTextColor:[UIColor grayColor]];
        
    }
    
    
    if(indexPath.row==2||indexPath.row==3)
    {
        lblName.frame=CGRectMake(40,15, screeningExaminationTable.frame.size.width-80, 30);
        NSLog(@"indexPath.row=%d text=%@",indexPath.row,[dct objectForKey:@"label"]);
    }
    
    if(indexPath.row==0||indexPath.row==10||indexPath.row==14||indexPath.row==18||indexPath.row==22)
        [cell setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:240.0/255.0 alpha:1.0]];
    else
    {
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    
    
    [lblName setText:[dct objectForKey:@"label"]];
    
    
    return cell;
    
}




-(UISegmentedControl*)maheSegmentControl:(BOOL)b
{
    UISegmentedControl *segment;
    NSArray *ar=@[@"YES",@"NO"];
    segment=[[UISegmentedControl alloc] initWithItems:ar];
    [segment setTintColor:[UIColor lightGrayColor]];
    segment.frame=CGRectMake(screeningExaminationTable.frame.size.width-90,15,80,30);
    [segment addTarget:self action:@selector(onClickSegment:) forControlEvents:UIControlEventValueChanged];
    return segment;
}

-(void)onClickSegment:(UISegmentedControl*)mySegmentedControl
{
    
    
    CGPoint buttonPosition = [mySegmentedControl convertPoint:CGPointZero toView:screeningExaminationTable];
    NSIndexPath *indexPath = [screeningExaminationTable indexPathForRowAtPoint:buttonPosition];
    
    NSLog(@"onClickSegment Row number=%d",indexPath.row);
    
    
    
    if(mySegmentedControl.selectedSegmentIndex == 0)
    {
        for (int i=0; i<[mySegmentedControl.subviews count]; i++)
        {
            if ([[mySegmentedControl.subviews objectAtIndex:i]isSelected] )
            {
                [[mySegmentedControl.subviews objectAtIndex:i] setTintColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
            }else{
                [[mySegmentedControl.subviews objectAtIndex:i] setTintColor:[UIColor lightGrayColor]];
            }
        }
    }
    else
    {
        for (int i=0; i<[mySegmentedControl.subviews count]; i++)
        {
            if ([[mySegmentedControl.subviews objectAtIndex:i]isSelected] )
            {
                [[mySegmentedControl.subviews objectAtIndex:i] setTintColor:[UIColor colorWithRed:187.0/255.0f green:33.0f/255.0f blue:41.0f/255.0f alpha:1]];
            }else{
                [[mySegmentedControl.subviews objectAtIndex:i] setTintColor:[UIColor lightGrayColor]];
            }
        }
    }
    
    if(indexPath.row!=0)
    {
        NSDictionary *dct=[arrList objectAtIndex:indexPath.row];
        NSDictionary *dct2;
        if(mySegmentedControl.selectedSegmentIndex == 0)
        {
            dct2=[[NSDictionary alloc] initWithObjectsAndKeys:[dct objectForKey:@"label"],@"label",@"1",@"status",[dct objectForKey:@"key"],@"key", nil];
            
        }
        else
        {
            dct2=[[NSDictionary alloc] initWithObjectsAndKeys:[dct objectForKey:@"label"],@"label",@"0",@"status",[dct objectForKey:@"key"],@"key", nil];
            
        }
        [arrList replaceObjectAtIndex:indexPath.row withObject:dct2];
        dct=nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  [[NSUserDefaults standardUserDefaults] setObject:[labelArrayExamination objectAtIndex:indexPath.row] forKey:@"selectedScreenLbl"];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"didDeselectRowAtIndexPath ");
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    
    if(indexPath.row!=1&&indexPath.row!=0&& indexPath.row!=10&&indexPath.row!=14&&indexPath.row!=18&&indexPath.row!=22)
    {
        
        
        if(indexPath.row<7||indexPath.row>9)
        {
            NSDictionary *dct=[arrList objectAtIndex:indexPath.row];
            NSDictionary *dct2;
            UIButton *btIcon=[cell.contentView viewWithTag:20];
            
            if([[btIcon backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"unCheck"]])
            {
                [btIcon setBackgroundImage:[UIImage imageNamed:@"Screenings-checked_03.png"] forState:UIControlStateNormal];
                dct2=[[NSDictionary alloc] initWithObjectsAndKeys:[dct objectForKey:@"label"],@"label",@"1",@"status",[dct objectForKey:@"key"],@"key", nil];
            }
            else
            {
                [btIcon setBackgroundImage:[UIImage imageNamed:@"unCheck"] forState:UIControlStateNormal];
                dct2=[[NSDictionary alloc] initWithObjectsAndKeys:[dct objectForKey:@"label"],@"label",@"0",@"status",[dct objectForKey:@"key"],@"key", nil];
            }
            [arrList replaceObjectAtIndex:indexPath.row withObject:dct2];
            dct=nil;
        }
    }
    
    
    
    /* UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
     UIButton *btIcon=[cell.contentView viewWithTag:20];
     
     if((indexPath.section==0&&(indexPath.row>=1&&indexPath.row<=5))||(indexPath.section==1&&indexPath.row==0))
     {
     if(![btIcon isHidden])
     {
     if([[btIcon backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"unCheck"]])
     {
     [btIcon setBackgroundImage:[UIImage imageNamed:@"Screenings-checked_03.png"] forState:UIControlStateNormal];
     }
     else
     {
     [btIcon setBackgroundImage:[UIImage imageNamed:@"unCheck"] forState:UIControlStateNormal];
     }
     }
     }
     
     */
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return labelArrayExamination.count;
    /* int n=1;
     if(section==0)
     n=9;
     else
     n=3;
     
     return n;
     if(section==1)
     return 1;
     else
     return labelArrayExamination.count-1;
     */
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
        return 50;
    else  if(indexPath.row==10||indexPath.row==14||indexPath.row==18||indexPath.row==22)
        return 40;
    else
        return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


/*-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
 {
 NSLog(@"accessoryButtonTappedForRowWithIndexPath at row=%ld",(long)indexPath.row);
 }*/



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

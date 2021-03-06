//
//  ScreeningOutcomeOptions.m
//  BabyApp
//
//  Created by Atul Awasthi on 09/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "ScreeningOutcomeOptions.h"
#import "CustomIOS7AlertView.h"
#import "DateTimeUtil.h"
#import "StoresTableViewCell.h"

#import "ConnectionsManager.h"
#import "NSUserDefaults+Helpers.h"
#import "WSConstant.h"



#define kOFFSET_FOR_KEYBOARD 100.0

@interface ScreeningOutcomeOptions () <UITextFieldDelegate, CustomIOS7AlertViewDelegate,ServerResponseDelegate>
{
    CustomIOS7AlertView *dateAlertView;
    UIDatePicker *datePicker;
    NSString *selectedDate;
    UIButton *lblName2;
    UIButton *lblName1;
    NSMutableArray *txtfieldAr;
    
    UITextField *selectedDateTxtFld;
}
@end

@implementation ScreeningOutcomeOptions
@synthesize screeningOutcomeOptionTable;
NSArray *labelArrayOutcomeOption;
UIButton *refBtn;
-(void)showPopView:(UIButton*)bt
{
    refBtn=bt;
    UIView *v=[[UIView alloc] initWithFrame:self.view.frame];
    [v setBackgroundColor:[UIColor clearColor]];
   // [v setAlpha:0.1];
    v.tag=300;
    UIView *v2=[[UIView alloc] initWithFrame:CGRectMake(bt.frame.origin.x, bt.superview.frame.origin.y, bt.frame.size.width,120)];
    [self.view addSubview:v];
    [self.view addSubview:v2];
    [v2 setBackgroundColor:[UIColor whiteColor]];
    
    NSArray *ar=@[@"Needs follow up",@"Normal",@"Needs further evaluation"];
    int k=0;
    for(NSString *s in ar)
    {
        UIButton *lblName=nil;
        lblName=[[UIButton alloc] initWithFrame:CGRectMake(10,k*40, v2.frame.size.width-10, 40)];
        [v2 addSubview:lblName];
        [lblName setTitle:s forState:UIControlStateNormal];
        [lblName setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [[lblName titleLabel] setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:18]];
        
        lblName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [lblName addTarget:self action:@selector(onPopViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        k++;
        lblName.tag=k;
        
    }
    
    
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
             "screening_id": "1",
             "child_id": "1",
             "outcome_type": "",
             "outcome_next_routine": "",
             "outcome_doctore": "",
             "outcome_idnumber": "",
             "outcome_clinic": "",
             "outcome_date": "0000-00-00"
             */
            
        [lblName1 setTitle:[dataList_ objectForKey:@"outcome_type"] forState:UIControlStateNormal];
            [lblName2 setTitle:[dataList_ objectForKey:@"outcome_next_routine"] forState:UIControlStateNormal];
            //text=;
        [(UITextField*)[txtfieldAr objectAtIndex:0] setText:[dataList_ objectForKey:@"outcome_doctore"]];
        [(UITextField*)[txtfieldAr objectAtIndex:1] setText:[dataList_ objectForKey:@"outcome_idnumber"]];
        [(UITextField*)[txtfieldAr objectAtIndex:2] setText:[dataList_ objectForKey:@"outcome_clinic"]];
        [(UITextField*)[txtfieldAr objectAtIndex:3] setText:[dataList_ objectForKey:@"outcome_date"]];
  
            
        }
        else
        {
            
            
            
            NSLog(@"Second api result with update recived");
        }
    }
    
}




-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


/*-(void)textFieldDidEndEditing:(UITextField *)sender
{
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    
    //move the main view, so that the keyboard does not hide it.
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    
    
}*/

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)openDate
{
    
    [self.view endEditing:YES];
    
    dateAlertView = [[CustomIOS7AlertView alloc] init];
    [dateAlertView setContainerView:[self createDateView]];
    [dateAlertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Close", @"Set", nil]];
    [dateAlertView setDelegate:self];
    [dateAlertView setUseMotionEffects:true];
    
    [dateAlertView show];
}

- (UIView *)createDateView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 216)];
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    datePicker.frame = CGRectMake(10, 10, 280, 216);
    datePicker.datePickerMode = UIDatePickerModeDate;
    [demoView addSubview:datePicker];
    return demoView;
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [dateAlertView close];
    NSString * dateFromData = [DateTimeUtil stringFromDateTime:datePicker.date withFormat:@"dd-MM-yyyy"];
    selectedDate = dateFromData;
    
    if(selectedDateTxtFld && selectedDateTxtFld != nil)
    {
        StoresTableViewCell *cell = (StoresTableViewCell *)[screeningOutcomeOptionTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        [cell.lblName setText:dateFromData];
    }
    else
    {
        [lblName2 setTitle:selectedDate forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    //[self setViewMovedUp:NO];
    
    return YES;
}
-(void)onPopViewClicked:(UIButton*)bt
{
    NSArray *ar=@[@"Needs follow up",@"Normal",@"Needs further evaluation"];
    
    //  UIButton *lblName1=(UIButton*)[[self.view viewWithTag:100] viewWithTag:120];
    //  [refBtn setBackgroundColor:[UIColor redColor]];
    [refBtn setTitle:[ar objectAtIndex:bt.tag-1] forState:UIControlStateNormal];
    [bt.superview removeFromSuperview];
    [[self.view viewWithTag:300] removeFromSuperview];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    txtfieldAr=[[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    labelArrayOutcomeOption=[NSArray arrayWithObjects:@"Docter/Nurse",@"ID number",@"Clinic",@"Date", nil];
    
    self.view.backgroundColor=[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    self.navigationItem.title = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedScreenLbl"] capitalizedString];
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 50)];
    [v setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:v];
    v.tag=100;
    
    
    UILabel *lblHeading1=nil;
    lblHeading1=[[UILabel alloc] initWithFrame:CGRectMake(20,10,90, 30)];
    lblHeading1.tag=10;
    [v addSubview:lblHeading1];
    
    UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(v.frame.size.width-30, 15, 15, 15)];
    iv.image=[UIImage imageNamed:@"right_arrow.png"];
    [v addSubview:iv];
    
    lblName1=nil;
    lblName1=[[UIButton alloc] initWithFrame:CGRectMake(120,10, v.frame.size.width-155, 30)];
    lblName1.tag=120;
    [v addSubview:lblName1];
    [lblName1.titleLabel setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:18]];
    [lblName1 setTitle:@"Needs follow up" forState:UIControlStateNormal];
    [lblName1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    lblName1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [lblName1 addTarget:self action:@selector(showPopView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *v2=[[UIView alloc] initWithFrame:CGRectMake(0, v.frame.origin.y+v.frame.size.height+25, self.view.frame.size.width, 50)];
    v.tag=200;
    
    [v2 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:v2];
    
    UILabel *lblHeading2=nil;
    lblHeading2=[[UILabel alloc] initWithFrame:CGRectMake(20,10,165, 30)];
    lblHeading2.tag=101;
    [v2 addSubview:lblHeading2];
    
   lblName2=nil;
    lblName2=[UIButton buttonWithType:UIButtonTypeCustom];
    [lblName2 setFrame:CGRectMake(190,10, v2.frame.size.width-195, 30)];
    [lblName2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [lblName2 addTarget:self action:@selector(onClickOpenMainDate:) forControlEvents:UIControlEventTouchUpInside];
    //alloc] initWithFrame:CGRectMake(190,10, v2.frame.size.width-195, 30)];
    lblName2.tag=201;
    [v2 addSubview:lblName2];
    
    [lblHeading1 setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15]];
    lblHeading1.text=@"Outcome";
    
    [lblHeading1 setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15]];
    lblHeading2.text=@"Next routine check at";
    
    [lblHeading1 setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15]];
    [lblName2 setTitle:@"Date" forState:UIControlStateNormal]; //.placeholder=@"Date";
    
    screeningOutcomeOptionTable=[[UITableView alloc] initWithFrame:CGRectMake(0, v2.frame.origin.y+v2.frame.size.height+25, self.view.frame.size.width, 240)];
    [self.view addSubview:screeningOutcomeOptionTable];
    screeningOutcomeOptionTable.dataSource=self;
    screeningOutcomeOptionTable.delegate=self;
    
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(onClickSave:)];
    
    
    NSString *childStr = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    
    NSString *screenID = [[NSUserDefaults standardUserDefaults] objectForKey:@"screening_id"];
    if(screenID && screenID != nil)
    {
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
        [[ConnectionsManager sharedManager] readOutCome:dict withdelegate:self];
    }
}

-(void)onClickSave:(id)sender
{
    
    NSString *screeid = [[NSUserDefaults standardUserDefaults] objectForKey:@"screening_id"];
    if(!screeid || screeid == nil)
    {
        return;
    }
    
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
    
    [dict setObject:screeid forKey:@"screening_id"];
    
    [dict setObject:[lblName1 titleForState:UIControlStateNormal] forKey:@"outcome_type"];
    [dict setObject:lblName2.titleLabel.text forKey:@"outcome_next_routine"];
    [dict setObject:[(UITextField*)[txtfieldAr objectAtIndex:0] text] forKey:@"outcome_doctore"];
    [dict setObject:[(UITextField*)[txtfieldAr objectAtIndex:1] text] forKey:@"outcome_idnumber"];
    [dict setObject:[(UITextField*)[txtfieldAr objectAtIndex:2] text] forKey:@"outcome_clinic"];
    [dict setObject:[(UITextField*)[txtfieldAr objectAtIndex:3] text] forKey:@"outcome_date"];
    
    NSLog(@"dict=%@",dict);
    
    [[ConnectionsManager sharedManager] updateOutcome:dict withdelegate:self];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoresTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Stores"];
    if(cell==nil)
    {
        cell=(StoresTableViewCell *)[[StoresTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Stores"];
        [cell.lblHeading setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15]];
        cell.lblHeading=[[UILabel alloc] initWithFrame:CGRectMake(20,15,110, 30)];
        cell.lblHeading.tag=10;
        
        [cell addSubview:cell.lblHeading];
        
        cell.lblName=[[UITextField alloc] initWithFrame:CGRectMake(140,15, tableView.frame.size.width-145, 30)];
        [cell.lblName setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15]];
        [cell.contentView addSubview:cell.lblName];
        [txtfieldAr addObject:cell.lblName];
        
       
        cell.btnDate=[UIButton buttonWithType:UIButtonTypeCustom];
        [cell.btnDate setFrame:CGRectMake(140,15, tableView.frame.size.width-145, 30)];
        [cell.btnDate addTarget:self action:@selector(onClickOpenDate:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnDate.titleLabel setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15]];
        [cell.contentView addSubview:cell.btnDate];
    }
    
    if(indexPath.row == 3)
    {
        [cell.lblName setEnabled:NO];
        [cell.btnDate setHidden:NO];
    }
    else
    {
        [cell.lblName setEnabled:YES];
        [cell.btnDate setHidden:YES];
    }
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    // [lblHeading setTextColor:[UIColor grayColor]];
    [cell.lblName setDelegate:self];
    [cell.lblName setTag:indexPath.row];
    
    [cell.lblHeading setText:[labelArrayOutcomeOption objectAtIndex:indexPath.row]];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setObject:[labelArrayOutcomeOption objectAtIndex:indexPath.row] forKey:@"selectedScreenLbl"];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"didDeselectRowAtIndexPath");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return labelArrayOutcomeOption.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"accessoryButtonTappedForRowWithIndexPath at row=%ld",(long)indexPath.row);
}

-(void)onClickOpenDate:(id)sender
{
    StoresTableViewCell *cell = (StoresTableViewCell *)[screeningOutcomeOptionTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    selectedDateTxtFld = cell.lblName;
    [self openDate];
}

//onClickOpenMainDate
-(void)onClickOpenMainDate:(id)sender
{
    selectedDateTxtFld = nil;
    [self openDate];
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

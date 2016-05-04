//
//  NewbornScreeningVC.m
//  BabyApp
//
//  Created by Vishal Kolhe on 01/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "NewbornScreeningVC.h"
#import "CommonSelectionListVC.h"
#import "CustomIOS7AlertView.h"
#import "DateTimeUtil.h"
#import "ConnectionsManager.h"
#import "NSString+CommonForApp.h"

#import "WSConstant.h"
#import "NSUserDefaults+Helpers.h"

@interface NewbornScreeningVC () <CommonSelectionListVCDelegate, CustomIOS7AlertViewDelegate, ServerResponseDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UITapGestureRecognizer *DeficiencyTapGesture, *dateTSHTapGesture, *IEMTapGesture, *DateIEMTapGesture, *OAETapGesture, *DateOAETapGesture, *LeftTapGesture, *RightTapGesture, *evaluationTapGesture;
    
    NSInteger selectedIndex;
    
    CustomIOS7AlertView *dateAlertView;
    UIDatePicker *datePicker;
    
    BOOL isUpdate;
    
    NSArray *genderList;
    UITableView *commonTblView;
    
    UITextField *currentTextField;
    
    
    BOOL isPoptoDischargeVC;
}
@end

@implementation NewbornScreeningVC
@synthesize delegate;


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.txtFldOAE setTextColor:[UIColor whiteColor]];
    
    [self addTapGestures];
    
    [self loadData];
    
    //UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onclickkeyboardhide:)];
    //[gesture setCancelsTouchesInView:YES];
    //[self.view addGestureRecognizer:gesture];
    
    
    
    commonTblView = [[UITableView alloc] init];
    [commonTblView setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    [commonTblView setDataSource:self];
    [commonTblView setDelegate:self];
    [commonTblView setHidden:YES];
    
    
    [self.scrollView addSubview:commonTblView];
}

-(void)onclickkeyboardhide:(UITapGestureRecognizer *)aGesture
{
    [self.view endEditing:YES];
    [commonTblView setHidden:YES];
}

-(void)addTapGestures
{
    DeficiencyTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBaseG6PDView:)];
    [self.baseG6pdView addGestureRecognizer:DeficiencyTapGesture];
    
    dateTSHTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickdateTSHView:)];
    [self.baseDateTF4View addGestureRecognizer:dateTSHTapGesture];
    
    IEMTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBaseIEMView:)];
    [self.baseIEMScreemingView addGestureRecognizer:IEMTapGesture];
    
    DateIEMTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBaseDateIEMView:)];
    [self.baseDateIEMScreemingView addGestureRecognizer:DateIEMTapGesture];
    
    OAETapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBaseOAEView:)];
    [self.baseOAEView addGestureRecognizer:OAETapGesture];
    
    DateOAETapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickdateOAEView:)];
    [self.baseDateOAEView addGestureRecognizer:DateOAETapGesture];
    
    LeftTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBaseLeftView:)];
    [self.baseLeftPassView addGestureRecognizer:LeftTapGesture];
    
    RightTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBaseRightView:)];
    [self.baseRightPassView addGestureRecognizer:RightTapGesture];
    
    evaluationTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBaseEvaluationView:)];
    [self.baseNeedsFurthurView addGestureRecognizer:evaluationTapGesture];
}

-(void)setFrameCommonTableView:(CGRect)frameView andTextFieldRect:(CGRect)frameTxtFld
{
    [commonTblView setFrame:CGRectMake(frameTxtFld.origin.x-20, frameView.origin.y+frameView.size.height, frameTxtFld.size.width+50, genderList.count*44)];
    [commonTblView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [commonTblView setBackgroundColor:[UIColor whiteColor]];
    
    [commonTblView setHidden:NO];
    [commonTblView reloadData];
}

-(void)onClickBaseG6PDView:(UITapGestureRecognizer *)aTapGesture
{
    //[self.view endEditing:YES];
    
    currentTextField = self.txtFldG6PD;
    [self loadGenderData];
    
    CGRect frameView = self.baseG6pdView.frame;
    CGRect frameTxtFld = self.txtFldG6PD.frame;
    [self setFrameCommonTableView:frameView andTextFieldRect:frameTxtFld];
}

-(void)onClickdateTSHView:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 2;
    [self openDate];
    //[self openCommonSelectionVC];
}

-(void)onClickBaseIEMView:(UITapGestureRecognizer *)aTapGesture
{
    
    //[self.view endEditing:YES];
    
    currentTextField = self.txtFldIEMScreeming;
    [self loadGenderData];
    
    CGRect frameView = self.baseIEMScreemingView.frame;
    CGRect frameTxtFld = self.txtFldIEMScreeming.frame;
    [self setFrameCommonTableView:frameView andTextFieldRect:frameTxtFld];
    
    
    //    selectedIndex = 3;
    //    [self openCommonSelectionVC];
}

-(void)onClickBaseDateIEMView:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 4;
    [self openDate];
    
    //[self openCommonSelectionVC];
}

-(void)onClickBaseOAEView:(UITapGestureRecognizer *)aTapGesture
{
    //    selectedIndex = 5;
    //    [self openCommonSelectionVC];
    
    //[self.view endEditing:YES];
    
    currentTextField = self.txtFldOAE;
    [self loadGenderData];
    
    CGRect frameView = self.baseOAEView.frame;
    CGRect frameTxtFld = self.txtFldOAE.frame;
    [self setFrameCommonTableView:frameView andTextFieldRect:frameTxtFld];
    
}

-(void)onClickdateOAEView:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 6;
    [self openDate];
}

-(void)onClickBaseLeftView:(UITapGestureRecognizer *)aTapGesture
{
    //    selectedIndex = 7;
    //    [self openCommonSelectionVC];
    
    //[self.view endEditing:YES];
    
    currentTextField = self.txtFldLeftPass;
    [self loadGenderData];
    
    CGRect frameView = self.baseLeftPassView.frame;
    CGRect frameTxtFld = self.txtFldLeftPass.frame;
    [self setFrameCommonTableView:frameView andTextFieldRect:frameTxtFld];
    
}

-(void)onClickBaseRightView:(UITapGestureRecognizer *)aTapGesture
{
    //    selectedIndex = 8;
    //    [self openCommonSelectionVC];
    
    //[self.view endEditing:YES];
    
    currentTextField = self.txtFldBaseRight;
    [self loadGenderData];
    
    CGRect frameView = self.baseRightPassView.frame;
    CGRect frameTxtFld = self.txtFldBaseRight.frame;
    [self setFrameCommonTableView:frameView andTextFieldRect:frameTxtFld];
    
}

-(void)onClickBaseEvaluationView:(UITapGestureRecognizer *)aTapGesture
{
    //    selectedIndex = 9;
    //    [self openCommonSelectionVC];
    
    //[self.view endEditing:YES];
    
    currentTextField = self.txtFldNeedFurthur;
    [self loadGenderData];
    
    CGRect frameView = self.baseNeedsFurthurView.frame;
    CGRect frameTxtFld = self.txtFldNeedFurthur.frame;
    [self setFrameCommonTableView:frameView andTextFieldRect:frameTxtFld];
    
}

-(void)selectedValue:(NSString *)aSelectedValue
{
    switch (selectedIndex) {
        case 1:
        {
            [self.txtFldG6PD setText:aSelectedValue];
        }
            break;
        case 2:
        {
            [self.txtFldTF4Date setText:aSelectedValue];
        }
            break;
        case 3:
        {
            [self.txtFldIEMScreeming setText:aSelectedValue];
        }
            break;
        case 4:
        {
            [self.txtFldDateIEMScreeming setText:aSelectedValue];
        }
            break;
        case 5:
        {
            [self.txtFldOAE setText:aSelectedValue];
        }
            break;
        case 6:
        {
            [self.txtFldDateOAE setText:aSelectedValue];
        }
            break;
        case 7:
        {
            [self.txtFldLeftPass setText:aSelectedValue];
        }
            break;
        case 8:
        {
            [self.txtFldBaseRight setText:aSelectedValue];
        }
            break;
        case 9:
        {
            [self.txtFldNeedFurthur setText:aSelectedValue];
        }
            break;
            
        default:
            break;
    }
}

-(void)openCommonSelectionVC
{
    CommonSelectionListVC *commonSelectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CommonSelectionListVC_SB_ID"];
    [commonSelectionVC setDelegate:self];
    [self.navigationController pushViewController:commonSelectionVC animated:YES];
}

-(void)openDate
{
    dateAlertView = [[CustomIOS7AlertView alloc] init];
    [dateAlertView setContainerView:[self createDateView]];
    [dateAlertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Close", @"Set", nil]];
    [dateAlertView setDelegate:self];
    [dateAlertView setUseMotionEffects:true];
    dateAlertView.tag = selectedIndex;
    
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
    
    switch (selectedIndex) {
        case 2:
        {
            [self.txtFldTF4Date setText:dateFromData];
        }
            break;
            
        case 4:
        {
            [self.txtFldDateIEMScreeming setText:dateFromData];
            break;
        }
        case 6:
        {
            [self.txtFldDateOAE setText:dateFromData];
            break;
        }
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)loadData
{
    NSNumber *childID = [self numfromString:[NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID]];
    if(childID && childID != nil)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:childID forKey:@"child_id"];
        
        [[ConnectionsManager sharedManager] readnewborn_screening:dict withdelegate:self];
    }
}

-(NSNumber *)numfromString:(NSString *)aStr
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:aStr];
    
    return myNumber;
    
}

- (void)viewDidLayoutSubviews
{
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1000)];
}
- (IBAction)onClickPreviousButton:(id)sender {
}

- (IBAction)onClickNextButton:(id)sender {
}

-(void)openDatePicker
{
    
}

- (IBAction)onClickDoneButton:(id)sender {
    
    if([self isValidData])
    {
        isPoptoDischargeVC = YES;
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.txtFldG6PD.text forKey:@"g6pd_deficiency"];
        [params setObject:self.txtFldTSH.text forKey:@"tsh"];
        [params setObject:self.txtFldTF4.text forKey:@"ft4"];
        [params setObject:self.txtFldIEMScreeming.text forKey:@"iem_screening_done"];
        [params setObject:self.txtFldDateIEMScreeming.text forKey:@"date_iem_screening"];
        [params setObject:self.txtFldOAE.text forKey:@"qae_abaer"];
        [params setObject:self.txtFldTF4Date.text forKey:@"date_tsh_ft4"];
        [params setObject:self.txtFldDateOAE.text forKey:@"date"];
        [params setObject:self.txtFldLeftPass.text forKey:@"left_pass"];
        [params setObject:self.txtFldBaseRight.text forKey:@"right_pass"];
        [params setObject:self.txtFldNeedFurthur.text forKey:@"needs_further_evaluation"];
        [params setObject:[self numfromString:[NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID]] forKey:@"child_id"];
        
        if(isUpdate)
        {
            [[ConnectionsManager sharedManager] updatenewborn_screening:params withdelegate:self];
        }
        else
        {
            [[ConnectionsManager sharedManager] addnewborn_screening:params withdelegate:self];
        }
    }
}

-(BOOL)isValidData
{
    if([self.txtFldG6PD.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid G6PD" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldTSH.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid TSH" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldTF4.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid TF4" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldTF4Date.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Date" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldIEMScreeming.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid IEM Screening" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldDateIEMScreeming.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Date IEM Screening" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldOAE.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid OAE" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldLeftPass.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Left pass" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldBaseRight.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Right pass" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldNeedFurthur.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Need furthur" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    return YES;
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
        NSDictionary *dataDict = [dict objectForKey:@"data"];
        /*
         "child_id" : 101
         "g6fd_deficiency" : ""
         "tsh" : ""
         "ft4" : ""
         "date_tsh_ft4" : ""
         "iem_screening_done" : ""
         "date_iem_screening" : ""
         "qae_abaer" : ""
         "date" : ""
         "left_pass" : ""
         "right_pass" : ""
         "needs_further_evaluation" : ""
         */
        
        isUpdate = YES;
        
        
        [self.txtFldG6PD setText:[dataDict objectForKey:@"g6pd_deficiency"]];
        [self.txtFldTSH setText:[dataDict objectForKey:@"tsh"]];
        [self.txtFldTF4 setText:[dataDict objectForKey:@"ft4"]];
        
        [self.txtFldTF4Date setText:[dataDict objectForKey:@"date_tsh_ft4"]];
        [self.txtFldIEMScreeming setText:[dataDict objectForKey:@"iem_screening_done"]];
        [self.txtFldDateIEMScreeming setText:[dataDict objectForKey:@"date_iem_screening"]];
        [self.txtFldOAE setText:[dataDict objectForKey:@"qae_abaer"]];
        
        [self.txtFldDateOAE setText:[dataDict objectForKey:@"date"]];
        [self.txtFldLeftPass setText:[dataDict objectForKey:@"left_pass"]];
        
        [self.txtFldBaseRight setText:[dataDict objectForKey:@"right_pass"]];
        [self.txtFldNeedFurthur setText:[dataDict objectForKey:@"needs_further_evaluation"]];
        
        if(isPoptoDischargeVC)
        {
            [self.delegate poptoDischargeScreen];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    else
    {
        //        NSString *messageStr = [dict objectForKey:@"message"];
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:messageStr delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //[alert show];
    }
}

-(void)failure:(id)response
{
    
}

-(void)loadGenderData
{
    NSMutableArray *tempData = [NSMutableArray array];
    [tempData addObject:@"Yes"];
    [tempData addObject:@"No"];
    
    genderList = tempData;
    
}

-(void)loadEthickData
{
    NSMutableArray *tempData = [NSMutableArray array];
    
    [tempData addObject:@"Hispanic or Latino"];
    [tempData addObject:@"American Indian or Alaska Native"];
    [tempData addObject:@"Asian"];
    [tempData addObject:@"Black or African American"];
    [tempData addObject:@"Native Hawaiian or Pacific Islander"];
    [tempData addObject:@"White"];
    
    genderList = tempData;
}

-(void)loadDeliveryData
{
    NSMutableArray *tempData = [NSMutableArray array];
    
    [tempData addObject:@"Normal delivery"];
    [tempData addObject:@"Cesarean delivery"];
    
    genderList = tempData;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return genderList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    [cell.textLabel setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
    [cell.textLabel setText:[genderList objectAtIndex:indexPath.row]];
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel sizeToFit];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [genderList objectAtIndex:indexPath.row];
    [commonTblView setHidden:YES];
    
    
    [currentTextField setText:str];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [commonTblView setHidden:YES];
    return YES;
}


@end

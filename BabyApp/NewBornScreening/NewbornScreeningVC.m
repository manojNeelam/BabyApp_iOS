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

@interface NewbornScreeningVC () <CommonSelectionListVCDelegate, CustomIOS7AlertViewDelegate, ServerResponseDelegate>
{
    UITapGestureRecognizer *DeficiencyTapGesture, *dateTSHTapGesture, *IEMTapGesture, *DateIEMTapGesture, *OAETapGesture, *DateOAETapGesture, *LeftTapGesture, *RightTapGesture, *evaluationTapGesture;
    
    NSInteger selectedIndex;
    
    CustomIOS7AlertView *dateAlertView;
    UIDatePicker *datePicker;
    
    BOOL isUpdate;
}
@end

@implementation NewbornScreeningVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addTapGestures];
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


-(void)onClickBaseG6PDView:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 1;
    [self openCommonSelectionVC];
}

-(void)onClickdateTSHView:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 2;
    [self openDate];
    //[self openCommonSelectionVC];
}

-(void)onClickBaseIEMView:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 3;
    [self openCommonSelectionVC];
}

-(void)onClickBaseDateIEMView:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 4;
    [self openDate];
    
    //[self openCommonSelectionVC];
}

-(void)onClickBaseOAEView:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 5;
    [self openCommonSelectionVC];
}

-(void)onClickdateOAEView:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 6;
    [self openDate];
}

-(void)onClickBaseLeftView:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 7;
    [self openCommonSelectionVC];
}

-(void)onClickBaseRightView:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 8;
    [self openCommonSelectionVC];
}

-(void)onClickBaseEvaluationView:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 9;
    [self openCommonSelectionVC];
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
    [dateAlertView setButtonTitles:[NSMutableArray arrayWithObjects:@"CLOSE", @"SET", nil]];
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
    [self loadData];
    
}

-(void)loadData
{
    NSNumber *childID = [[NSUserDefaults standardUserDefaults] objectForKey:@"child_id"];
    ///if(childID && childID != nil)
    // {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"10" forKey:@"child_id"];
    
    [[ConnectionsManager sharedManager] readnewborn_screening:dict withdelegate:self];
    //}
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
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.txtFldG6PD.text forKey:@"g6pd_deficiency"];
        [params setObject:self.txtFldTSH.text forKey:@"tsh"];
        [params setObject:self.txtFldTF4.text forKey:@"ft4"];
        [params setObject:self.txtFldIEMScreeming.text forKey:@"iem_screening_done"];
        [params setObject:self.txtFldDateIEMScreeming.text forKey:@"date_iem_screening"];
        [params setObject:self.txtFldOAE.text forKey:@"qae_abaer"];
        
        [params setObject:self.txtFldTF4Date.text forKey:@"date"];
        [params setObject:self.txtFldLeftPass.text forKey:@"left_pass"];
        [params setObject:self.txtFldBaseRight.text forKey:@"right_pass"];
        [params setObject:self.txtFldNeedFurthur.text forKey:@"needs_further_evaluation"];
        [params setObject:[NSNumber numberWithInt:10] forKey:@"child_id"];
        
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid C6PD" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
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
        
        
        [self.txtFldDateOAE setText:[dataDict objectForKey:@"g6fd_deficiency"]];
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
    }
    else
    {
        NSString *messageStr = [dict objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:messageStr delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)failure:(id)response
{
    
}
@end

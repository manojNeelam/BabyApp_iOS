//
//  DischargeInformationVC.m
//  BabyApp
//
//  Created by Vishal Kolhe on 02/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "DischargeInformationVC.h"
#import "CommonSelectionListVC.h"
#import "CustomIOS7AlertView.h"
#import "DateTimeUtil.h"
#import "ConnectionsManager.h"
#import "NSString+CommonForApp.h"

@interface DischargeInformationVC () <CustomIOS7AlertViewDelegate, CommonSelectionListVCDelegate, ServerResponseDelegate>
{
    CustomIOS7AlertView *dateAlertView;
    NSInteger selectedIndex;
    UIDatePicker *datePicker;
    
    UITapGestureRecognizer *dateTapGesture, *breastFeedTapGesture;
    
    BOOL isUpdate;
}
@end

@implementation DischargeInformationVC

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addTapGestures];
    [self loadData];
}

-(void)loadData
{
    NSNumber *childID = [[NSUserDefaults standardUserDefaults] objectForKey:@"child_id"];
    ///if(childID && childID != nil)
    // {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"10" forKey:@"child_id"];
    
    [[ConnectionsManager sharedManager] readdischarge_information:dict withdelegate:self];
    
    //readParticular:dict withdelegate:self];
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
        case 1:
        {
            [self.txtFldDate setText:dateFromData];
        }
            break;
            
        default:
            break;
    }
}

-(void)addTapGestures
{
    dateTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBaseDateView:)];
    [self.baseDateView addGestureRecognizer:dateTapGesture];
    
    breastFeedTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBreastView:)];
    [self.baseBreastFeed addGestureRecognizer:breastFeedTapGesture];
}

-(void)onClickBaseDateView:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 1;
    [self openDate];
    //[self openCommonSelectionVC];
}

-(void)onClickBreastView:(UITapGestureRecognizer *)aTapGesture
{
    selectedIndex = 2;
    [self openCommonSelectionVC];
}

-(void)selectedValue:(NSString *)aSelected
{
    if(selectedIndex == 2)
    {
        [self.txtFldBreastFeed setText:aSelected];
    }
}

- (IBAction)onClickDoneButton:(id)sender {
    
    if([self isValidData])
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.txtFldDate.text forKey:@"date"];
        [params setObject:self.txtFldWeight.text forKey:@"weight"];
        [params setObject:self.txtFldBreastFeed.text forKey:@"breast_feeding"];
        [params setObject:self.txtFldSerum.text forKey:@"serum_billirubin_before_discharge"];
        [params setObject:[NSNumber numberWithInt:10] forKey:@"child_id"];
        
        if(isUpdate)
        {
            [[ConnectionsManager sharedManager] updatedischarge_information:params withdelegate:self];
        }
        else
        {
            [[ConnectionsManager sharedManager] adddischarge_information:params withdelegate:self];
        }
    }
}

-(BOOL)isValidData
{
    if([self.txtFldDate.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Date" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldWeight.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Weight" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldBreastFeed.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid BreastFeed" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldSerum.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Serum" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
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
        
        [self.txtFldDate setText:[dataDict objectForKey:@"date"]];
        [self.txtFldSerum setText:[dataDict objectForKey:@"serum_billirubin_before_discharge"]];
        [self.txtFldWeight setText:[dataDict objectForKey:@"weight"]];
        [self.txtFldBreastFeed setText:[dataDict objectForKey:@"breast_feeding"]];
        
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

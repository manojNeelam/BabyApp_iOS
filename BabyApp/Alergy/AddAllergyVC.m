//
//  AddAllergyVC.m
//  BabyApp
//
//  Created by Vishal Kolhe on 05/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "AddAllergyVC.h"
#import "WSConstant.h"
#import "NSUserDefaults+Helpers.h"
#import "ConnectionsManager.h"
#import "DateTimeUtil.h"
#import "CustomIOS7AlertView.h"
#import "NSString+CommonForApp.h"

@interface AddAllergyVC () <ServerResponseDelegate, CustomIOS7AlertViewDelegate, UITextFieldDelegate>
{
    CustomIOS7AlertView *dateAlertView;
    UIDatePicker *datePicker;
}
@end

@implementation AddAllergyVC
@synthesize drugAlergyData;


- (IBAction)saveAction:(id)sender
{
    if([self isValidData])
    {
        NSString *childID = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
        if(childID && childID != nil)
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:childID forKey:@"child_id"];
            [dict setObject:self.txtFldDrugName.text forKey:@"drug_name"];
            [dict setObject:self.txtFldAllergyReaction.text forKey:@"allergic_reaction"];
            [dict setObject:self.btnDate.titleLabel.text forKey:@"date"];
            [dict setObject:@"1" forKey:@"status"];
            
            if(drugAlergyData && drugAlergyData != nil)
            {
                [dict setObject:drugAlergyData.drugID forKey:@"id"];
                [[ConnectionsManager sharedManager] updateAlergy:dict withdelegate:self];
            }
            else
            {
                [[ConnectionsManager sharedManager] addAlergy:dict withdelegate:self];
            }
        }
        else
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:@"52" forKey:@"child_id"];
            [dict setObject:self.txtFldDrugName.text forKey:@"drug_name"];
            [dict setObject:self.txtFldAllergyReaction.text forKey:@"allergic_reaction"];
            [dict setObject:self.btnDate.titleLabel.text forKey:@"date"];
            [dict setObject:@"1" forKey:@"status"];
            
            if(drugAlergyData && drugAlergyData != nil)
            {
                [dict setObject:drugAlergyData.drugID forKey:@"id"];
                [[ConnectionsManager sharedManager] updateAlergy:dict withdelegate:self];
            }
            else
            {
                [[ConnectionsManager sharedManager] addAlergy:dict withdelegate:self];
            }
        }
    }
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.txtFldAllergyReaction setDelegate:self];
    [self.txtFldDrugName setDelegate:self];
    
    if(drugAlergyData && drugAlergyData != nil)
    {
        [self.txtFldDrugName setText:drugAlergyData.drugTitle];
        [self.txtFldDate setText:drugAlergyData.date];
        [self.txtFldAllergyReaction setText:drugAlergyData.reaction];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(BOOL)isValidData
{
    if([self.txtFldDrugName.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Drugname" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldAllergyReaction.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Reaction" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        return NO;
    }
    if([self.btnDate.titleLabel.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Date" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
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
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)failure:(id)response
{
    
}
- (IBAction)onClickOpenDate:(id)sender {
    
    [self.view endEditing:YES];
    [self openDate];
}

-(void)openDate
{
    dateAlertView = [[CustomIOS7AlertView alloc] init];
    [dateAlertView setContainerView:[self createDateView]];
    [dateAlertView setButtonTitles:[NSMutableArray arrayWithObjects:@"CLOSE", @"SET", nil]];
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
    [self.btnDate setTitle:dateFromData forState:UIControlStateNormal];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end

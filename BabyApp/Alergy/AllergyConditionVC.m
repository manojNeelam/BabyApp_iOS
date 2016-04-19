//
//  AllergyConditionVC.m
//  BabyApp
//
//  Created by Vishal Kolhe on 05/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "AllergyConditionVC.h"
#import "ConnectionsManager.h"
#import "WSConstant.h"
#import "NSUserDefaults+Helpers.h"
#import "NSString+CommonForApp.h"

@interface AllergyConditionVC () <ServerResponseDelegate, UITextFieldDelegate>

@end

@implementation AllergyConditionVC
@synthesize coditionData;



- (IBAction)saveAction:(id)sender {
    
    NSString *childID = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    if(childID && childID != nil)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:childID forKey:@"child_id"];
        [dict setObject:self.txtFldCondition.text forKey:@"condition"];
        [dict setObject:self.txtViewDesc.text forKey:@"notes"];
        
        if(coditionData && coditionData != nil)
        {
            [dict setObject:coditionData.condID forKey:@"id"];
            [[ConnectionsManager sharedManager] updateMedical:dict withdelegate:self];
        }
        else
        {
            [[ConnectionsManager sharedManager] addMedical:dict withdelegate:self];
        }
    }
    else
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"52" forKey:@"child_id"];
        [dict setObject:self.txtFldCondition.text forKey:@"condition"];
        [dict setObject:self.txtViewDesc.text forKey:@"notes"];
        
        if(coditionData && coditionData != nil)
        {
            [dict setObject:coditionData.condID forKey:@"id"];
            [[ConnectionsManager sharedManager] updateMedical:dict withdelegate:self];
        }
        else
        {
            [[ConnectionsManager sharedManager] addMedical:dict withdelegate:self];
        }
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeKeyBoard:)];
    [self.view addGestureRecognizer:tapGesture];
    
    if(coditionData && coditionData != nil)
    {
        [self.txtFldCondition setText:coditionData.condition];
        [self.txtViewDesc setText:coditionData.desc];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)removeKeyBoard:(UIGestureRecognizer *)aGesture
{
    [self.view endEditing:YES];
}

-(BOOL)isValidData
{
    if([self.txtFldCondition.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Medical Codition" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        return NO;
    }
    if([self.txtViewDesc.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Notes" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end

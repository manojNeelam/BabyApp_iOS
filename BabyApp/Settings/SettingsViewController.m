//
//  SettingsViewController.m
//  BabyApp
//
//  Created by Syntel-Amargoal1 on 4/15/16.
//  Copyright (c) 2016 Infinity. All rights reserved.
//

#import "SettingsViewController.h"
#import "ConnectionsManager.h"
#import "NSUserDefaults+Helpers.h"
#import "WSConstant.h"
#import "Constants.h"
#import "NSString+CommonForApp.h"

@interface SettingsViewController ()<ServerResponseDelegate, UITextFieldDelegate>
{
    NSDictionary *userDataDict;
}
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(onClickSave:)];
    

    // Do any additional setup after loading the view.
    [self getUserData];
}

-(void)getUserData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *s=[[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    NSDictionary *params = @{@"user_id" : s};
    
    NSLog(@"calling of getSettingsData  user id=%@ s=%@",[params objectForKey:@"user_id"],s);
    
    [[ConnectionsManager sharedManager] getSettingsData:params  withdelegate:self];
    NSLog(@"dict=%@",dict);
    

}


/*
 -(void)getSettingsData:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate
 {
 [self getToURL:@"settings_read" withParameters:params delegate:delegate];
 }
 
 -(void)updateSettingsData:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate

 */

-(void)failure:(id)response
{
    
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
    {//dict
        
        if ([[dict allKeys] containsObject:@"data"])
        {
            NSDictionary *dataList_ = [dict objectForKey:@"data"];
            NSLog(@"dataList=%@",dataList_);
            userDataDict=dataList_;
            self.txtFldFullName.text=[dataList_ objectForKey:@"fullname"];
            self.txtFldEmail.text=[dataList_ objectForKey:@"email"];
            
            if([[dataList_ objectForKey:@"notification"] isEqualToString:@"0"])
                [self.notiSwitch setOn:NO];
              else
                  [self.notiSwitch setOn:YES];
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)isValidData
{
    if([self.txtFldFullName.text isEmpty])
    {
        [Constants showOKAlertWithTitle:@"Info" message:@"Please enter Name" presentingVC:self];
        
        return NO;
    }
   
    
    if([self.txtFldEmail.text isEmpty])
    {
        [Constants showOKAlertWithTitle:@"Info" message:@"Please enter e-mail" presentingVC:self];
        
        return NO;
    }

    
   
    
    return YES;
}



-(void)onClickSave:(id)sender
{
    
    NSString *s=[[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    
   
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    
    [dict setObject:s forKey:@"user_id"];
    [dict setObject:self.txtFldFullName.text forKey:@"fullname"];
    [dict setObject:self.txtFldEmail.text forKey:@"email"];
    
    if(self.notiSwitch.on)
        [dict setObject:@"1" forKey:@"notification"];
else
       [dict setObject:@"0" forKey:@"notification"];

    
    [[ConnectionsManager sharedManager] updateSettingsData:dict withdelegate:self];
    

    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField isEqual:self.txtFldFullName])
    {
        [self.txtFldEmail becomeFirstResponder];
    }
    else if([textField isEqual:self.txtFldEmail])
    {
        [textField resignFirstResponder];
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}


- (IBAction)onClickSwitch:(id)sender {
}
@end

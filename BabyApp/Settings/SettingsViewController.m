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

@interface SettingsViewController ()<ServerResponseDelegate>
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
    
    NSLog(@"calling of getAllChildrans at home page user id=%@ s=%@",[params objectForKey:@"user_id"],s);
    
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
            self.txtFldUserName.text=[dataList_ objectForKey:@"fullname"];
            self.txtFldEmail.text=[dataList_ objectForKey:@"email"];
            self.txtFldPassword.text=[dataList_ objectForKey:@"fullname"];
            
            if([[dataList_ objectForKey:@"notification"] isEqualToString:@"0"])
                [self.notiSwitch setOn:NO];
              else
                  [self.notiSwitch setOn:NO];

        }
    }
}

/*
 @property (weak, nonatomic) IBOutlet UITextField *txtFldFullName;
 @property (weak, nonatomic) IBOutlet UITextField *txtFldUserName;
 @property (weak, nonatomic) IBOutlet UITextField *txtFldEmail;
 @property (weak, nonatomic) IBOutlet UITextField *txtFldPassword;
 @property (weak, nonatomic) IBOutlet UISwitch *notiSwitch;
 */

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
    if([self.txtFldUserName.text isEmpty])
    {
        [Constants showOKAlertWithTitle:@"Info" message:@"Please enter User Name" presentingVC:self];
        
        return NO;
    }
    
    if([self.txtFldEmail.text isEmpty])
    {
        [Constants showOKAlertWithTitle:@"Info" message:@"Please enter e-mail" presentingVC:self];
        
        return NO;
    }

    if([self.txtFldPassword.text isEmpty])
    {
        [Constants showOKAlertWithTitle:@"Info" message:@"Please enter Password" presentingVC:self];
        
        return NO;
    }

    
   
    
    return YES;
}



-(void)onClickSave:(id)sender
{
    
    
   /* NSString *childStr = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
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
    isDone =YES;
    [[ConnectionsManager sharedManager] updateGrowth:dict withdelegate:self];
    */
    
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

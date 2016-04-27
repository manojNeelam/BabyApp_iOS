//
//  OtherScreeningPage.m
//  BabyApp
//
//  Created by Atul Awasthi on 08/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "OtherScreeningPage.h"
#import "ConnectionsManager.h"
#import "NSUserDefaults+Helpers.h"
#import "WSConstant.h"

@interface OtherScreeningPage ()<ServerResponseDelegate>
{
    UITextField *lblName;
}
@end

@implementation OtherScreeningPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedScreenLbl"] capitalizedString];
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 50)];
    [v setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:240.0/255.0 alpha:1.0]];
    [self.view addSubview:v];
    
    
    lblName=nil;
    
    lblName=[[UITextField alloc] initWithFrame:CGRectMake(20, v.frame.origin.y+v.frame.size.height+5, self.view.frame.size.width-40, 40)];
    lblName.tag=10;
    [self.view addSubview:lblName];
    [lblName setPlaceholder:@"Other Screening (e.g. Hearing Screening)"];
    
    
   // [lblName setFont:[UIFont fontWithName:@"AvenirNextLTPro-DemiCn" size:20]];

    
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
    [[ConnectionsManager sharedManager] readOtherScreening:dict withdelegate:self];
    

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
            NSLog(@"First api result with screenoing id list recived");
            [lblName setText:[dataList_ objectForKey:@"notes"]];
            
        }
            else
            {
            NSLog(@"Second api result with update recived");
            }
        }
        
    }





-(void)onClickSave:(id)sender
{
    
    if(lblName.text!=nil&&lblName.text.length>0)
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
    
    
      [dict setObject:lblName.text forKey:@"notes"];
    
    NSLog(@"dict=%@",dict);
    [[ConnectionsManager sharedManager] updateOtherScreening:dict withdelegate:self];
    
    }

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

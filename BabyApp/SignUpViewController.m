//
//  SignUpViewController.m
//  BabyApp
//
//  Created by Charan Giri on 21/02/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "SignUpViewController.h"
#import "ConnectionsManager.h"
#import "NSString+CommonForApp.h"
#import "AppDelegate.h"
#import "WSConstant.h"
#import "NSUserDefaults+Helpers.h"


#define kOFFSET_FOR_KEYBOARD 80.0


@interface SignUpViewController () <ServerResponseDelegate>
@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain, nonatomic) NSURLConnection *connection;
@end

@implementation SignUpViewController
UIActivityIndicatorView *act2;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    NSLog(@"SignUpViewController");
    // Do any additional setup after loading the view.
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


-(void)textFieldDidEndEditing:(UITextField *)sender
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
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
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

- (IBAction)createAccount:(id)sender {    //put code here for registration
    
    NSLog(@"createAccount");
    if([self isValidData])
    {
        act2=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [act2 setCenter:self.view.center];
        [self.view addSubview:act2];
        [act2 startAnimating];

        [self performSelector:@selector(toCallSignupApi) withObject:nil afterDelay:0.2];
  
     
    }
    
}

-(void)toCallSignupApi
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.userNameTF.text forKey:@"name"];   //
    [params setObject:self.email.text forKey:@"email"];
    [params setObject:self.passwordTF.text forKey:@"password"];
    [params setObject:@"ios" forKey:@"device"];
    [[ConnectionsManager sharedManager] registerUser:params withdelegate:self];
}
-(BOOL)isValidData
{
    if([self.userNameTF.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter  Your Name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }

    if(![self.email.text isValidEmail])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.passwordTF.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    
    return YES;
}

-(void)success:(id )response
{
    [act2 stopAnimating];
    [act2 removeFromSuperview];
    /*
     message = "User email already exists";
     status = 0;
     */
    NSDictionary *params;
    
    if([response isKindOfClass:[NSString class]])
    {
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        params = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }
    else if ([response isKindOfClass:[NSDictionary class]])
    {
        params = response;
    }
    
    id statusStr_ = [params objectForKey:@"status"];
    
    NSString *statusStr;
    
    statusStr = statusStr_;
    
    if([statusStr isEqualToString:@"1"])
    {
        NSString *userId = [[params objectForKey:@"data"] objectForKey:@"user_id"];
        
        [NSUserDefaults saveObject:userId forKey:USERID];
        
        [self openHomeVC];
        //[self performSegueWithIdentifier:@"HomeViewControllerSegue" sender:self];
    }
    else if([statusStr isEqualToString:@"0"])
    {
        NSString *messageStr = [params objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:[NSString stringWithFormat:@"%@", messageStr] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}


-(void)failure:(id)response
{
    [act2 stopAnimating];
    [act2 removeFromSuperview];
    //[self performSegueWithIdentifier:@"HomeViewControllerSegue" sender:self];
}

-(void)openHomeVC
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate checkValidUser];
}

@end

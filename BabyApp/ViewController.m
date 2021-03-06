//
//  ViewController.m
//  BabyApp
//
//  Created by Charan Giri on 19/02/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "ViewController.h"
#import "ConnectionsManager.h"
#import "NSString+CommonForApp.h"
#import "Constants/Constants.h"
#import "AppDelegate.h"
#import "NSUserDefaults+Helpers.h"
#import "WSConstant.h"
#import "ChildDetailsData.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#define kOFFSET_FOR_KEYBOARD 100.0
#define FB_ALERT    123

@interface ViewController ()<ServerResponseDelegate, UIAlertViewDelegate, FBSDKLoginButtonDelegate>
{
    NSMutableDictionary *userDict;
}
@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain, nonatomic) NSURLConnection *connection;
@end

@implementation ViewController
{
    BOOL isForgotPassword;
}
UIActivityIndicatorView *act1;



- (UIView *)roundCornersOnView:(UIView *)view onTopLeft:(BOOL)tl topRight:(BOOL)tr bottomLeft:(BOOL)bl bottomRight:(BOOL)br radius:(float)radius
{
    if (tl || tr || bl || br) {
        UIRectCorner corner = 0;
        if (tl) corner = corner | UIRectCornerTopLeft;
        if (tr) corner = corner | UIRectCornerTopRight;
        if (bl) corner = corner | UIRectCornerBottomLeft;
        if (br) corner = corner | UIRectCornerBottomRight;
        
        UIView *roundedView = view;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:roundedView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = roundedView.bounds;
        maskLayer.path = maskPath.CGPath;
        roundedView.layer.mask = maskLayer;
        return roundedView;
    }
    return view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    isForgotPassword = NO;
    self.navigationController.navigationBarHidden=YES;
    
    /*for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
    */
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear333");
    [super viewWillAppear:animated];
    [self getAllChildrans];
}

-(void)getAllChildrans
{
    NSLog(@"getAllChildrans333");

    NSString *s=[[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    if(s && s != nil)
    {
        NSDictionary *params = @{@"user_id" : s};
        
        NSLog(@"calling of getAllChildrans at home page user id=%@ s=%@",[params objectForKey:@"user_id"],s);
        
        [[ConnectionsManager sharedManager] childrenDetails:params  withdelegate:self];
    }
    else
    {
        [self.bgImg setHidden:YES];
    }
}

-(void)viewDidLayoutSubviews
{
    self.viewPassword = (UIView *)[self roundCornersOnView:self.viewPassword onTopLeft:NO topRight:NO bottomLeft:YES bottomRight:YES radius:5.0];
    self.viewEmail = (UIView *)[self roundCornersOnView:self.viewEmail onTopLeft:YES topRight:YES bottomLeft:NO bottomRight:NO radius:5.0];
}

//
//-(void)keyboardWillShow{
//    // Animate the current view out of the way
//    if (self.view.frame.origin.y >= 0)
//    {
//        [self setViewMovedUp:YES];
//    }
//    else if (self.view.frame.origin.y < 0)
//    {
//        [self setViewMovedUp:NO];
//    }
//}
//
//-(void)keyboardWillHide {
//    if (self.view.frame.origin.y >= 0)
//    {
//        [self setViewMovedUp:YES];
//    }
//    else if (self.view.frame.origin.y < 0)
//    {
//        [self setViewMovedUp:NO];
//    }
//}
//
//-(void)textFieldDidBeginEditing:(UITextField *)sender
//{
//
//        //move the main view, so that the keyboard does not hide it.
//        if  (self.view.frame.origin.y >= 0)
//        {
//            [self setViewMovedUp:YES];
//        }
//
//}
//
////method to move the view up/down whenever the keyboard is shown/dismissed
//-(void)setViewMovedUp:(BOOL)movedUp
//{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
//
//    CGRect rect = self.view.frame;
//    if (movedUp)
//    {
//        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
//        // 2. increase the size of the view so that the area behind the keyboard is covered up.
//        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
//        rect.size.height += kOFFSET_FOR_KEYBOARD;
//    }
//    else
//    {
//        // revert back to the normal state.
//        rect.origin.y += kOFFSET_FOR_KEYBOARD;
//        rect.size.height -= kOFFSET_FOR_KEYBOARD;
//    }
//    self.view.frame = rect;
//
//    [UIView commitAnimations];
//}
//
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    // register for keyboard notifications
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    // unregister for keyboard notifications while not visible.
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIKeyboardWillShowNotification
//                                                  object:nil];
//
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIKeyboardWillHideNotification
//                                                  object:nil];
//}



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
//    if  (self.view.frame.origin.y >= 0)
//    {
//        [self setViewMovedUp:NO];
//    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    //move the main view, so that the keyboard does not hide it.
//    if  (self.view.frame.origin.y >= 0)
//    {
//        [self setViewMovedUp:YES];
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
- (IBAction)signinAction:(id)sender {
    NSLog(@"signinAction");
    //     [self performSegueWithIdentifier:@"HomeViewControllerSegue" sender:self];
    if([self isValidData])
    {
        //    act1=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //        [act1 setCenter:self.view.center];
        //        [self.view addSubview:act1];
        //        [act1 startAnimating];
        [SVProgressHUD showWithStatus:@"Loading"];
        [self performSelector:@selector(requesttoserver) withObject:nil afterDelay:0.2];
        //[self requesttoserver];
    }
}

-(BOOL)isValidData
{
    if([self.usernameTextfield.text isEmpty])
    {
        //                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        //                   [alert show];
        [Constants showOKAlertWithTitle:@"Info" message:@"Please enter valid email address" presentingVC:self];
        
        return NO;
    }
    if([self.passwordTextfield.text isEmpty])
    {
        //                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        //                   [alert show];
        [Constants showOKAlertWithTitle:@"Info" message:@"Please enter valid password" presentingVC:self];
        
        return NO;
    }
    
    return YES;
}

-(void)requesttoserver
{
    
    //if there is a connection going on just cancel it.
    [self.connection cancel];
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.usernameTextfield.text forKey:@"email"];
    [params setObject:self.passwordTextfield.text forKey:@"password"];
    [params setObject:@"ios" forKey:@"device"];
    

    
    NSString *Post=[NSString stringWithFormat:@"email=%@&password=%@&@device=ios",self.usernameTextfield.text,self.passwordTextfield.text];
    NSLog(@"signinActionPost=%@",Post);

    NSData *PostData = [Post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    NSString *PostLengh=[NSString stringWithFormat:@"%d",[Post length]];
    NSURL *Url=[NSURL URLWithString: @"http://babyappdev.azurewebsites.net/apiv1/service/login/"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:Url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:PostLengh forHTTPHeaderField:@"Content-Lenght"];
    [request setHTTPBody:PostData];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    self.connection = connection;
    
    [connection start];
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.receivedData appendData:data];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error%@" , error);
    [act1 stopAnimating];
    [act1 removeFromSuperview];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
        
    });
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    // NSString *htmlSTR = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    
    [act1 stopAnimating];
    [act1 removeFromSuperview];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
        
    });
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:self.receivedData options:kNilOptions error:&error];
    NSLog(@"connectionDidFinishLoading =%@",json);
    if([[json objectForKey:@"status"] isEqualToString:@"1"])
    {
        // [[NSUserDefaults standardUserDefaults] setObject:json forKey:@"userData"];
        //[self performSegueWithIdentifier:@"HomeViewControllerSegue" sender:self];
        
        //        NSString *userId = [[json objectForKey:@"data"] objectForKey:@"user_id"];
        //
        //        [NSUserDefaults saveObject:userId forKey:USERID];
        //
        //        [self openHomeVC];
        
        
        
        NSString *userId = [[json objectForKey:@"data"] objectForKey:@"user_id"];
        NSString *userName = [[json objectForKey:@"data"] objectForKey:@"name"];
        
        [NSUserDefaults saveObject:userId forKey:USERID];
        [NSUserDefaults saveObject:userName forKey:USER_NAME];
        
        // NSArray *ar=[[json objectForKey:@"data"] objectForKey:@"children"];
        // NSLog(@"childeren data=%@ coun=%d",ar,ar.count);
        
        
        //
        
        //            children
        NSLog(@"connectionDidFinishLoading 333 userId=%@",userId);

        NSArray *childrenList = json[@"data"][@"children"];
        if(childrenList.count)
        {
            NSMutableArray *temp = [NSMutableArray array];
            
            for(NSDictionary *dict in childrenList)
            {
                ChildDetailsData *child = [[ChildDetailsData alloc] initwithDictionary:dict];
                [temp addObject:child];
            }
            
            NSArray *childHolder = temp;
            
            AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
            [appdelegate setListOfChildrens:childHolder];
            
            NSLog(@"childHolder=%@",childHolder);
            [NSUserDefaults saveBool:NO forKey:IS_CHILD_NOT_AVAILABLE];
            
            
            [self openHomeVC];
        }
        else
        {
            [NSUserDefaults saveBool:YES forKey:IS_FROM_SIGNUP];
            [NSUserDefaults saveBool:YES forKey:IS_CHILD_NOT_AVAILABLE];
            
            [self openHomeVC];
        }
        //
        //[self getAllChildrans];
        
    }
    else
    {
        NSString *messageStr = [json objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:messageStr delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)facebookSigninAction:(id)sender {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             [self saveFBAccessToken];
             
             [self getUserInfoFromFacebook];
             
             NSLog(@"Logged in");
         }
     }];
}

-(NSString *)getFBAccessToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:APP_FACEBOOK_USER_TOKEN];
    
    return token;
}

-(void)saveFBAccessToken
{
    NSString *fbToken = [FBSDKAccessToken currentAccessToken].tokenString;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:fbToken forKey:APP_FACEBOOK_USER_TOKEN];
    [defaults synchronize];
}



-(void)getUserInfoFromFacebook
{
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id,name,email"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 
                 userDict = [[NSMutableDictionary alloc] initWithDictionary:result];
                 NSDictionary *dict = result;
                 [self callFacebookLoginAPI:dict];
                 
             }
         }];
    }
}

-(void)callFacebookLoginAPI:(NSDictionary *)params
{
    
    NSString *emailStr = [params objectForKey:@"email"];
    if(!emailStr || emailStr == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"email address missing??" message:@"Please enter email address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = FB_ALERT;
        
        [alert show];
        return;
    }
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSString *Post=[NSString stringWithFormat:@"email=%@&username=%@&facebook_id=%@&@device=ios",params[@"email"],params[@"username"],params[@"facebook_id"]];
    
    NSData *PostData = [Post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    NSString *PostLengh=[NSString stringWithFormat:@"%lu",(unsigned long)[Post length]];
    NSURL *Url=[NSURL URLWithString: @"http://babyappdev.azurewebsites.net/apiv1/service/facebook_login/"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:Url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:PostLengh forHTTPHeaderField:@"Content-Lenght"];
    [request setHTTPBody:PostData];
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
        });
        if (!error) {
            
            
            NSError* errorJason;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"facebook_login response : %@",json);
            if (!errorJason) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if([[json objectForKey:@"status"] boolValue])
                    {
                        // [[NSUserDefaults standardUserDefaults] setObject:json forKey:@"userData"];
                        //[self performSegueWithIdentifier:@"HomeViewControllerSegue" sender:self];
                        
                        NSString *userId = [[json objectForKey:@"data"] objectForKey:@"user_id"];
                        NSString *userName = [[json objectForKey:@"data"] objectForKey:@"name"];
                        
                        [NSUserDefaults saveObject:userId forKey:USERID];
                        [NSUserDefaults saveObject:userName forKey:USER_NAME];
                        
                        [self openHomeVC];
                        
                    }
                });
            }else
            {
                NSLog(@"facebook_login error : %@",[errorJason localizedDescription]);
                [Constants showOKAlertWithTitle:@"Error" message:@"Unable to login, Please try again after some time." presentingVC:self];
                
            }
            
            
        }
        else{
            NSLog(@"facebook_login error : %@",[error localizedDescription]);
            [Constants showOKAlertWithTitle:@"Error" message:@"Unable to login, Please try again after some time." presentingVC:self];
        }
        
    }];
    
    [postDataTask resume];
    
}

- (IBAction)forgotPasswordAction:(id)sender {
    
    
    if ([UIAlertController class])
    {
        // use UIAlertController
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Forgot Password?"
                                   message:@"Enter your email address to reset your password."
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       //Do Some action here
                                                       UITextField *textField = alert.textFields[0];
                                                       act1=nil;
                                                       act1=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                                                       [act1 setCenter:self.view.center];
                                                       [self.view addSubview:act1];
                                                       [act1 startAnimating];
                                                       [self performSelector:@selector(getForgotPassword:) withObject:textField.text afterDelay:0.2];
                                                       
                                                       // [self getForgotPassword:textField.text];
                                                       
                                                       NSLog(@"text was %@", textField.text);
                                                       
                                                   }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           
                                                           NSLog(@"cancel btn");
                                                           
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                           
                                                       }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Email address";
            textField.keyboardType = UIKeyboardTypeDefault;
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else
    {
        // use UIAlertView
        UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"Enter Folder Name"
                                                         message:@"Keep it short and sweet"
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles:@"OK", nil];
        
        dialog.alertViewStyle = UIAlertViewStylePlainTextInput;
        dialog.tag = 400;
        [dialog show];
        
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == FB_ALERT)
    {
        NSString *name = [alertView textFieldAtIndex:0].text;
        if([name isValidEmail])
        {
            [userDict setObject:name forKey:@"email"];
            [self callFacebookLoginAPI:userDict];
        }
        else
        {
            
        }
    }
    else
    {
        NSString *name = [alertView textFieldAtIndex:0].text;
        [self getForgotPassword:name];
    }
}

-(void)getForgotPassword:(NSString *)emailAddress
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:emailAddress forKey:@"email"];
    isForgotPassword = YES;
    [[ConnectionsManager sharedManager] getForgotPassword:dictionary withdelegate:self];
}

- (IBAction)signupAction:(id)sender {
    
    NSLog(@"signupAction");
    
    [self performSegueWithIdentifier:@"signUpSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}

-(void)success:(id)response
{
    [act1 stopAnimating];
    [act1 removeFromSuperview];
    /*
     {
     message = "Your new password has been sent to you email";
     status = 1;
     }
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
    
    if([statusStr_ isKindOfClass:[NSNumber class]])
    {
        statusStr = [statusStr_ stringValue];
    }
    else
        statusStr = statusStr_;
    
    if (isForgotPassword) {
        
        NSString *messageStr = [params objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:[NSString stringWithFormat:@"%@", messageStr] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        isForgotPassword = NO;
        return;
    }
    if([statusStr isEqualToString:@"1"])
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary *responseDict = (NSDictionary *)response
            ;
            if ([responseDict[@"status"] boolValue]) {
                
                //            children
                NSArray *childrenList = responseDict[@"data"][@"children"];
                if(childrenList.count)
                {
                    NSMutableArray *temp = [NSMutableArray array];
                    
                    for(NSDictionary *dict in childrenList)
                    {
                        ChildDetailsData *child = [[ChildDetailsData alloc] initwithDictionary:dict];
                        [temp addObject:child];
                    }
                    
                    NSArray *childHolder = temp;
                    
                    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
                    [appdelegate setListOfChildrens:childHolder];
                    
                    [NSUserDefaults saveBool:NO forKey:IS_CHILD_NOT_AVAILABLE];
                    
                    
                    [self openHomeVC];
                }
                else
                {
                    [NSUserDefaults saveBool:YES forKey:IS_FROM_SIGNUP];
                    [NSUserDefaults saveBool:YES forKey:IS_CHILD_NOT_AVAILABLE];
                    [self openHomeVC];
                }
            }
            else{
                
                [self.bgImg setHidden:YES];
                
                [Constants showOKAlertWithTitle:@"Error" message:@"Unagle to load your childrans list, Please try again after some time" presentingVC:self];
            }
        });
        
        
        NSString *messageStr = [params objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:[NSString stringWithFormat:@"%@", messageStr] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
     //   [alert show];
        
    }
    else if([statusStr isEqualToString:@"0"])
    {
        [self.bgImg setHidden:YES];
        
        NSString *messageStr = [params objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:[NSString stringWithFormat:@"%@", messageStr] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        //[alert show];
        [self openHomeVC];

    }
}

-(void)failure:(id)response
{
    [self.bgImg setHidden:YES];
    
    [act1 stopAnimating];
    [act1 removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openHomeVC
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate checkValidUser];
}

@end

//
//  SupportViewController.m
//  BabyApp
//
//  Created by Sandeep Dave on 07/05/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "SupportViewController.h"
#import "ConnectionsManager.h"

@interface SupportViewController ()

@end

@implementation SupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"http://babyappdev.azurewebsites.net/content/support"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
  //  [self.webView setScalesPageToFit:YES];
    [self.webView loadRequest:request];
     self.webView.delegate = self;
    
    [SVProgressHUD show];
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
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

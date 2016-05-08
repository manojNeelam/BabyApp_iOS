//
//  VisualViewController.m
//  BabyApp
//
//  Created by Sandeep Dave on 08/05/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "VisualViewController.h"
#import "ConnectionsManager.h"

@interface VisualViewController ()

@end

@implementation VisualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url;
    
        url = [NSURL URLWithString:@"http://babyappdev.azurewebsites.net/graph/visual_acuity/1"];
   
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView setScalesPageToFit:YES];
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

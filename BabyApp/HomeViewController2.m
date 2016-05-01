//
//  HomeViewController2.m
//  BabyApp
//
//  Created by Atul Awasthi on 01/05/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "HomeViewController2.h"
#import "AppDelegate.h"
@interface HomeViewController2 ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIPageControl *pageHome;
    
}
@property (nonatomic)  UITableView *home2Table;
@property (nonatomic)  UIScrollView *home2Scorll;

@end

@implementation HomeViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _home2Scorll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height*30)/100)];
    
    [self.view addSubview:_home2Scorll];
    
    
    _home2Table=[[UITableView alloc] initWithFrame:CGRectMake(0, _home2Scorll.frame.size.height+_home2Scorll.frame.origin.y, self.view.frame.size.width, (self.view.frame.size.height*68)/100)];
    
    [self.view addSubview:_home2Table];
    
    
    [self drawViewInScrollForChildAt];
}



-(void)drawViewInScrollForChildAt
{
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    NSArray *list = [appdelegate listOfChildrens];
    int i=0;
    for( ;i<3;i++)
    {
        UIView *vv2=[[UIView alloc] initWithFrame:CGRectMake(i*self.view.frame.size.width, 0,self.view.frame.size.width, _home2Scorll.frame.size.height)];
        [vv2 setBackgroundColor:[UIColor colorWithRed:60.0/255.0 green:125.0/255.0 blue:116.0/255.0 alpha:1.0]];
        [_home2Scorll addSubview:vv2];
    }
    
    [_home2Scorll setContentSize:CGSizeMake(self.view.frame.size.width*i, _home2Scorll.frame.size.height)];
    [_home2Scorll setBounces:NO];
    [_home2Scorll setPagingEnabled:YES];
    
    
    pageHome=[[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-15, _home2Scorll.frame.size.height-20, 30, 20)];
    [pageHome setNumberOfPages:3];
    [pageHome setCurrentPage:0];
    
    [self.view addSubview:pageHome];
    [self.view bringSubviewToFront:pageHome];
    
    
    
}


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
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

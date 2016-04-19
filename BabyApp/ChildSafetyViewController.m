//
//  ChildSafetyViewController.m
//  BabyApp
//
//  Created by Charan Giri on 17/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "ChildSafetyViewController.h"
#import "ScreenSumaryDetailCell.h"

#import "ConnectionsManager.h"
#import "Constants.h"
#import "WSConstant.h"
#import "NSUserDefaults+Helpers.h"


#define lbl @"title"
#define DetailStatus @"status"

@interface ChildSafetyViewController ()<ServerResponseDelegate>
{
    NSArray *bottomLeftButtonTitleArray, *bottomRightButtonTitleArray;
    NSArray *allcheckListArray;
    //    NSArray *sortedArray;
}
@property (strong, nonatomic) NSArray *screeningSummaryDetailArray;
@property (weak, nonatomic) IBOutlet UIButton *bottomLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomRightButton;
- (IBAction)bottomLeftButtonAction:(id)sender;
- (IBAction)bottomRightButtonAction:(id)sender;

@end

@implementation ChildSafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"15-18 Months";
    
    //    self.screeningSummaryDetailArray = @[@{lbl     : @"I ensure that blosters,pillows,blankets and plastics bags are kept away from my baby to avoid unintentional suffocation.I always place my baby to sleep on his back.",
    //                                           DetailStatus  : @"YES"
    //                                           },
    //                                         @{lbl     : @"I do not use a sarong cradle for my child nor allow him/her  to the same bed as me to avoid rolling onto and suffocating him/her.My baby ",
    //                                           DetailStatus  : @"Next due: 15/02/2016"
    //                                           },
    //                                         @{lbl     : @"I ensure that blosters,pillows,blankets and plastics bags are kept away from my baby to avoid unintentional suffocation.I always place my baby to sleep on his back.",
    //                                           DetailStatus  : @"Set reminder"
    //                                           },
    //                                         @{lbl     : @"15-18 months",
    //                                           DetailStatus  : @"Set reminder"
    //                                           },
    //                                         @{lbl     : @"2-3 years",
    //                                           DetailStatus  : @"Set reminder"
    //                                           },
    //                                         ];
    
    
    [_bottomLeftButton setTitle:@"" forState:UIControlStateNormal];
    [_bottomRightButton setTitle:@"" forState:UIControlStateNormal];
    [self getSafetyCheckList];
    
}



#pragma mark - TableView Delegate and data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.screeningSummaryDetailArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScreenSumaryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreenSummaryDetails"];
    
    NSDictionary *info = [self.screeningSummaryDetailArray objectAtIndex:[indexPath row]];
    NSLog(@"info=%@",info);
    [cell.detailLabel setText:[info objectForKey:lbl]];
    [cell.statusBtn setBackgroundColor:[UIColor redColor]];
    
    if ([info[DetailStatus] boolValue]) {
        [cell.statusBtn setBackgroundColor:[UIColor blueColor]];
        //        cell.statusBtn.tag= indexPath.row+100;
    }
    
    [cell.statusBtn addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.contentView updateConstraintsIfNeeded];
    [cell layoutIfNeeded];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(IBAction)buttonclick:(UIButton *)sender
{
    
    NSLog(@"%d",(int)sender.tag-100);
    
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
 get_safety_checklist
 }
 */

- (IBAction)bottomLeftButtonAction:(id)sender {
    
    if (_bottomLeftButton.tag == bottomLeftButtonTitleArray.count-1) {
        _bottomLeftButton.tag = 0;
    }
    else
    {
        _bottomLeftButton.tag++;
        
    }
    
    [_bottomLeftButton setTitle:bottomLeftButtonTitleArray[_bottomLeftButton.tag] forState:UIControlStateNormal];
    
    [self sortArrayWithTitle:bottomLeftButtonTitleArray[_bottomLeftButton.tag]];
    
    
    
    
}

- (IBAction)bottomRightButtonAction:(id)sender {
    if (_bottomRightButton.tag == bottomRightButtonTitleArray.count-1) {
        _bottomRightButton.tag = 0;
    }
    else
    {
        _bottomRightButton.tag++;
        
    }
    
    [_bottomRightButton setTitle:bottomRightButtonTitleArray[_bottomRightButton.tag] forState:UIControlStateNormal];
    [self sortArrayWithTitle:bottomRightButtonTitleArray[_bottomRightButton.tag]];
    
}

-(void)sortArrayWithTitle:(NSString *)title
{
    _screeningSummaryDetailArray = [allcheckListArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(title == %@)", title]];
    self.navigationItem.title =title;
    
    [self.childSafetyTableView reloadData];
}


#pragma mark - get safety cheklist  API
-(void)getSafetyCheckList
{
    NSString *childId = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    childId = @"1";
    NSDictionary *params = @{@"child_id" : childId};
    [[ConnectionsManager sharedManager] getSafetyChecklist:params withdelegate:self];
    
    
}

-(void)success:(id)response
{
    NSLog(@"Response of get safetyList : %@", response);
    NSDictionary *responseDict = (NSDictionary *)response;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([responseDict[@"status"] boolValue]) {
            
            allcheckListArray = responseDict[@"data"][@"checklist"];
            if (allcheckListArray.count == 0) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Info" message:@"safety checklist is empty for your current child." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }];
                [alert addAction:okAction];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                return;
            }
            
            self.navigationItem.title = allcheckListArray[0][@"title"];
            
            NSArray *allTitles = [allcheckListArray valueForKey: @"title"];
            
            int leftcount = (int)allTitles.count/2;
            
            bottomLeftButtonTitleArray =  [allcheckListArray subarrayWithRange:NSMakeRange(0, leftcount)];
            bottomRightButtonTitleArray = [allcheckListArray subarrayWithRange:NSMakeRange(leftcount,allTitles.count-leftcount)];
            _bottomLeftButton.tag = 0;
            _bottomRightButton.tag = 0;
            
            [_bottomLeftButton setTitle:bottomLeftButtonTitleArray[_bottomLeftButton.tag] forState:UIControlStateNormal];
            [_bottomRightButton setTitle:bottomRightButtonTitleArray[_bottomRightButton.tag] forState:UIControlStateNormal];
            
            NSDictionary *fisrtDict = allcheckListArray[0];
            
            [self sortArrayWithTitle:fisrtDict[@"title"]];
            
            
            self.navigationItem.title =fisrtDict[@"title"];
            
            
            
            
        }
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Unalbe to load child safety checklist, please try again after some time." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }];
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:YES completion:nil];
            //            [Constants showOKAlertWithTitle:@"Error" message:@"Unalbe to load child safety checklist, please try again after some time" presentingVC:self];
        }
        
    });
    
    
}

-(void)failure:(id)response
{
    NSLog(@"Error of get safetyList : %@", response);
    
}
@end

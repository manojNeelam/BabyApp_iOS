//
//  BioDataTableViewController.m
//  BabyApp
//
//  Created by Charan Giri on 20/02/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "BioDataTableViewController.h"
#import "ProfilePicTableViewCell.h"
#import "BioDataTableViewCell.h"
#import "KeyConstants.h"
#import "BioDataObj.h"
#import "ConnectionsManager.h"
#import "BirthRecordTableViewController.h"
#import "JMImageCache.h"
#import "UIImageView+JMImageCache.h"
#import "DateTimeUtil.h"
#import "CustomIOS7AlertView.h"
#import "NSUserDefaults+Helpers.h"
#import "WSConstant.h"

@interface BioDataTableViewController () <ServerResponseDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CustomIOS7AlertViewDelegate, UITextFieldDelegate>
{
    NSArray *titleArray;
    
    BioDataObj *bioDataObj;
    
    CustomIOS7AlertView *dateAlertView;
    UIDatePicker *datePicker;
    
    UIImage *userProfilePic;
    
    UITapGestureRecognizer *profilePicGesture;
    
    NSString *userName, *dob;
    
}
@end

@implementation BioDataTableViewController


- (IBAction)onClickDoneButton:(id)sender {
    
    ProfilePicTableViewCell *cell = (ProfilePicTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    NSData *data;
    NSString *imgStr;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(userProfilePic)
    {
        data = UIImageJPEGRepresentation(userProfilePic, 0.2);
        imgStr = [data base64EncodedStringWithOptions:0];
        
    }
    //[self UIImageToByteArray:userProfilePic]
    //[params setObject:imgStr forKey:@"baby_image"];
    [params setObject:cell.btnDateOfBirth.titleLabel.text forKey:@"dob"];
    [params setObject:cell.txtFldName.text forKey:@"name"];
    [params setObject:[NSUserDefaults retrieveObjectForKey:USERID] forKey:@"user_id"];
    [params setObject:SAFE_DEF([NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID], @"") forKey:@"child_id"];
    
    NSString *childID = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    int status = 1;
    if(childID && childID != nil)
    {
        status = 2;
    }
    [params setObject:[NSNumber numberWithInt:status] forKey:@"action"];
    
    [[ConnectionsManager sharedManager] saveBioData:params andImage:cell.userProflePic withdelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    bioDataObj = [[BioDataObj alloc] init];
    
    [self loadBioData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self.navigationItem setTitle:@"Bio Data"];
    
    profilePicGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(onClickOpenImageVC:)];
    
    
    
    
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    titleArray=[NSArray arrayWithObjects:@"",@"BIRTH RECORD",@"PARTICULAR OF PARENTS",@"SIGNIFICANT EVENTS",@"NEWBORN SCREENING",@"INVESTIGATION(S) DONE (if any)",@"INFORMATION ON DISCHARGE", nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

-(void)onClickOpenImageVC:(UITapGestureRecognizer *)aGesture
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Profile pic" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take pic",@"Choose pic", nil];
    [actionSheet showInView:self.view];
}

-(void)loadBioData
{
    NSString *childID = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    if(childID && childID != nil)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:childID forKey:@"child_id"];
        
        [[ConnectionsManager sharedManager] getBioData:dict withdelegate:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row==0)
    {
        return 270;
    }
    else
    {
        return 50;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProfilePicTableViewCell *cell = nil;
    BioDataTableViewCell *cell1=nil;
    
    if (indexPath.row==0)
    {
        cell=(ProfilePicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfilePicCellIdentifier"];
        [cell.btnDateOfBirth addTarget:self action:@selector(onClickDateOfBirth:) forControlEvents:UIControlEventTouchUpInside];
        [cell.userProflePic setUserInteractionEnabled:YES];
        
        [cell.txtFldName setDelegate:self];
        
        [cell.txtFldName setText:userName];
        [cell.btnDateOfBirth setTitle:dob forState:UIControlStateNormal];
        
        [cell.userProflePic addGestureRecognizer:profilePicGesture];
        if(userProfilePic)
        {
            cell.userProflePic.image = userProfilePic;
        }
        else
        {
            [cell.userProflePic setImageWithURL:[NSURL URLWithString:bioDataObj.userProfile] placeholder:[UIImage imageNamed:@"pic.png"]];
        }
        return cell;
    }
    else
    {
        cell1 = (BioDataTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BioDataCellIdentifier"];
        cell1.titleLabel.text=titleArray[indexPath.row];
        
        //        cell1.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"blue_background_small.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
        //        cell1.selectedBackgroundView =  [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"blue_background_small.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
        
        return cell1;
        
    }
    
    
    
    //BioDataCellIdentifier  ProfilePicCellIdentifier
    
    // Configure the cell...
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==1)
        [self performSegueWithIdentifier:@"birthSegue" sender:self];
    else if(indexPath.row == 2)
    {
        [self performSegueWithIdentifier:Segue_ParticularsOfParentsVC sender:self];
    }
    else if (indexPath.row == 4)
    {
        //NewbornScreeningVC_Segue
        [self performSegueWithIdentifier:Segue_NewbornScreeningVC sender:self];
        
    }
    else if (indexPath.row == 5)
    {
        //NewbornScreeningVC_Segue
        [self performSegueWithIdentifier:Segue_investigationOptions sender:self];
        
    }
    else if (indexPath.row == 6)
    {
        //DischargeInformationSegue
        [self performSegueWithIdentifier:Segue_DischargeInformation sender:self];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"birthSegue"]) {
        BirthRecordTableViewController *controller = (BirthRecordTableViewController *)segue.destinationViewController;
        controller.selectedBioData = bioDataObj;
    }
    
}

-(void)onClickDateOfBirth:(id)sender
{
    [self.view endEditing:YES];
    
    [self openDate];
}

-(void)openDate
{
    dateAlertView = [[CustomIOS7AlertView alloc] init];
    [dateAlertView setContainerView:[self createDateView]];
    [dateAlertView setButtonTitles:[NSMutableArray arrayWithObjects:@"CLOSE", @"SET", nil]];
    [dateAlertView setDelegate:self];
    [dateAlertView setUseMotionEffects:true];
    
    [dateAlertView show];
}

- (UIView *)createDateView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 216)];
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    datePicker.frame = CGRectMake(10, 10, 280, 216);
    datePicker.datePickerMode = UIDatePickerModeDate;
    [demoView addSubview:datePicker];
    return demoView;
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [dateAlertView close];
    NSString * dateFromData = [DateTimeUtil stringFromDateTime:datePicker.date withFormat:@"dd-MM-yyyy"];
    
    ProfilePicTableViewCell *cell = (ProfilePicTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if(bioDataObj && bioDataObj != nil)
    {
        bioDataObj.dob = dateFromData;
    }
    
    dob = dateFromData;
    [cell.btnDateOfBirth.titleLabel setText:dateFromData];
    
    [self.tableView reloadData];
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
    if([statusStr isEqualToString:@"1"])
    {
        
        
        NSDictionary *datDict = [dict objectForKey:@"data"];
        userName = [datDict objectForKey:@"name"];
        dob = [datDict objectForKey:@"dob"];
        bioDataObj.userProfile = [datDict objectForKey:@"baby_image"];
        bioDataObj.name = userName;
        bioDataObj.dob = dob;
        
        
        NSString *childID = [datDict objectForKey:@"child_id"];
        [NSUserDefaults saveObject:childID forKey:CURRENT_CHILD_ID];
        userProfilePic = nil;
        
        [self.tableView reloadData];
    }
}

-(void)failure:(id)response
{
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self takePic];
    }
    else
    {
        [self openGallery];
    }
}

-(void)takePic
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
        pickerView.allowsEditing = YES;
        pickerView.delegate = self;
        pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickerView animated:YES completion:^{
            
        }];
    }
}

-(void)openGallery
{
    UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
    pickerView.allowsEditing = YES;
    pickerView.delegate = self;
    [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:pickerView animated:YES completion:^{
        
    }];
}


#pragma mark - PickerDelegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
    userProfilePic = img;
    [self.tableView reloadData];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(bioDataObj && bioDataObj != nil)
    {
        bioDataObj.name = textField.text;
    }
    
    userName = textField.text;
    
    [self.tableView reloadData];
}

@end

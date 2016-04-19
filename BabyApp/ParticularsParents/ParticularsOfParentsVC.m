//
//  ParticularsOfParentsVC.m
//  BabyApp
//
//  Created by Vishal Kolhe on 01/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "ParticularsOfParentsVC.h"
#import "ConnectionsManager.h"
#import "NSString+CommonForApp.h"

@interface ParticularsOfParentsVC () <ServerResponseDelegate>
{
    NSArray *identifierNames;
    
    BOOL isUpdate;
}
@end

@implementation ParticularsOfParentsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.txtFldFatherTelHp setText:@"165413"];
    [self.txtFldFatherTelOff setText:@"16556413"];
    [self.txtFldFatherTelRes setText:@"165453513"];
    [self.txtFldFatherOccupation setText:@"software de"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadBioData];
}


- (IBAction)onClickDoneButton:(id)sender {
    
    if([self isValidData])
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"10" forKey:@"child_id"];
        [params setObject:self.txtFldName.text forKey:@"mother_name"];
        [params setObject:self.txtFldPassportNo.text forKey:@"mother_passport_no"];
        [params setObject:self.txtFldOccupation.text forKey:@"mother_occupation"];
        [params setObject:self.txtFldTelRes.text forKey:@"mother_tel_res"];
        [params setObject:self.txtFldTlOFF.text forKey:@"mother_tel_off"];
        [params setObject:self.txtFldTelHP.text forKey:@"mother_tel_hp"];
        
        [params setObject:self.txtFldFatherName.text forKey:@"father_name"];
        [params setObject:self.txtFldFatherPassportNo.text forKey:@"father_passport_no"];
        [params setObject:self.txtFldFatherOccupation.text forKey:@"father_occupation"];
        [params setObject:self.txtFldFatherTelRes.text forKey:@"father_tel_res"];
        [params setObject:self.txtFldFatherTelOff.text forKey:@"father_tel_off"];
        [params setObject:self.txtFldFatherTelHp.text forKey:@"father_tel_hp"];
        
        if(isUpdate)
        {
            [[ConnectionsManager sharedManager] updateParticular:params withdelegate:self];
        }
        else
        {
            [[ConnectionsManager sharedManager] addParticular:params withdelegate:self];
        }
    }
}

-(void)loadBioData
{
    NSNumber *childID = [[NSUserDefaults standardUserDefaults] objectForKey:@"child_id"];
    ///if(childID && childID != nil)
    // {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"10" forKey:@"child_id"];
    
    [[ConnectionsManager sharedManager] readParticular:dict withdelegate:self];
    //}
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    CGRect frame = self.baseTelFatherHP.frame;
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, frame.origin.y + frame.size.height + 20)];
}

//scrollView

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row==7) {
        return 100;
    }
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return identifierNames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierNames[indexPath.row] forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



-(BOOL)isValidData
{
    if([self.txtFldName.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Mother Name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldOccupation.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Mother Occupation" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldPassportNo.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Passport No" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldTelHP.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Mother Tel Hp" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldTelRes.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Mother Tel Res" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldTlOFF.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Mother Tel Off" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldFatherName.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Father Name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldFatherOccupation.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Father Occupation" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldFatherPassportNo.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Father Passport No" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldFatherTelHp.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Father Tel Hp" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldFatherTelRes.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Father Tel Res" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldFatherTelOff.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter valid Father Tel Off" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    return YES;
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
    {
        NSDictionary *dataDict = [dict objectForKey:@"data"];
        /*
         "apgar_score1" = 3;
         "apgar_score2" = 3;
         "birth_certificate_no" = 1235;
         "child_id" = 10;
         dob = "01-07-2016";
         "duration_of_gestation" = "10-04-2016";
         "ethnic_group" = Asian;
         "head_circumference" = 0;
         "length_at_birth" = 522;
         "mode_of_delivery" = "Normal delivery";
         name = mukesh;
         "place_of_delivery" = vishrantiwadi;
         sex = Female;
         "weight_at_birth" = 522;
         */
        
        isUpdate = YES;
        
        
        [self.txtFldName setText:[dataDict objectForKey:@"mother_name"]];
        [self.txtFldOccupation setText:[dataDict objectForKey:@"mother_occupation"]];
        [self.txtFldPassportNo setText:[dataDict objectForKey:@"mother_passport_no"]];
        
        [self.txtFldTelHP setText:[dataDict objectForKey:@"mother_tel_hp"]];
        [self.txtFldTelRes setText:[dataDict objectForKey:@"mother_tel_res"]];
        [self.txtFldTlOFF setText:[dataDict objectForKey:@"mother_tel_off"]];
        [self.txtFldFatherName setText:[dataDict objectForKey:@"father_name"]];
        
        [self.txtFldFatherOccupation setText:[dataDict objectForKey:@"father_occupation"]];
        [self.txtFldFatherPassportNo setText:[dataDict objectForKey:@"father_passport_no"]];
        
        [self.txtFldFatherTelHp setText:[dataDict objectForKey:@"father_tel_hp"]];
        [self.txtFldFatherTelOff setText:[dataDict objectForKey:@"father_tel_off"]];
        [self.txtFldFatherTelRes setText:[dataDict objectForKey:@"father_tel_res"]];
    }
    else
    {
        NSString *messageStr = [dict objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:messageStr delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)failure:(id)response
{
    
}


- (IBAction)onClickPreviousButton:(id)sender {
}

- (IBAction)onClickNextButton:(id)sender {
}
@end

//
//  ScreeningOutcomeOptions.m
//  BabyApp
//
//  Created by Atul Awasthi on 09/03/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "ScreeningOutcomeOptions.h"
#define kOFFSET_FOR_KEYBOARD 100.0

@interface ScreeningOutcomeOptions ()

@end

@implementation ScreeningOutcomeOptions
//screeningoutcomeoptionsegu
@synthesize screeningOutcomeOptionTable;
NSArray *labelArrayOutcomeOption;
UIButton *refBtn;
-(void)showPopView:(UIButton*)bt
{
    refBtn=bt;
    UIView *v=[[UIView alloc] initWithFrame:self.view.frame];
    [v setBackgroundColor:[UIColor blackColor]];
    [v setAlpha:0.2];
    v.tag=300;
    UIView *v2=[[UIView alloc] initWithFrame:CGRectMake(bt.frame.origin.x, bt.superview.frame.origin.y, bt.frame.size.width,120)];
    [self.view addSubview:v];
    [self.view addSubview:v2];
    [v2 setBackgroundColor:[UIColor whiteColor]];
    
    NSArray *ar=@[@"Needs follow up",@"Normal",@"Needs further evaluation"];
    int k=0;
    for(NSString *s in ar)
    {
        UIButton *lblName1=nil;
        lblName1=[[UIButton alloc] initWithFrame:CGRectMake(10,k*40, v2.frame.size.width-10, 40)];
        [v2 addSubview:lblName1];
        [lblName1 setTitle:s forState:UIControlStateNormal];
        [lblName1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [[lblName1 titleLabel] setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:18]];
        
        lblName1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [lblName1 addTarget:self action:@selector(onPopViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        k++;
        lblName1.tag=k;
        
    }
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
    [self setViewMovedUp:NO];
    
    return YES;
}
-(void)onPopViewClicked:(UIButton*)bt
{
    NSArray *ar=@[@"Needs follow up",@"Normal",@"Needs further evaluation"];
    
    //  UIButton *lblName1=(UIButton*)[[self.view viewWithTag:100] viewWithTag:120];
    //  [refBtn setBackgroundColor:[UIColor redColor]];
    [refBtn setTitle:[ar objectAtIndex:bt.tag-1] forState:UIControlStateNormal];
    [bt.superview removeFromSuperview];
    [[self.view viewWithTag:300] removeFromSuperview];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    labelArrayOutcomeOption=[NSArray arrayWithObjects:@"Docter/Nurse",@"ID number",@"Clinic",@"Date", nil];
    
    self.view.backgroundColor=[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    self.navigationItem.title = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedScreenLbl"] capitalizedString];
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 50)];
    [v setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:v];
    v.tag=100;
    
    
    UILabel *lblHeading1=nil;
    lblHeading1=[[UILabel alloc] initWithFrame:CGRectMake(20,10,90, 30)];
    lblHeading1.tag=10;
    [v addSubview:lblHeading1];
    
    UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(v.frame.size.width-30, 15, 15, 15)];
    iv.image=[UIImage imageNamed:@"right_arrow.png"];
    [v addSubview:iv];
    
    UIButton *lblName1=nil;
    lblName1=[[UIButton alloc] initWithFrame:CGRectMake(120,10, v.frame.size.width-155, 30)];
    lblName1.tag=120;
    [v addSubview:lblName1];
    [lblName1.titleLabel setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:18]];
    [lblName1 setTitle:@"Needs follow up" forState:UIControlStateNormal];
    [lblName1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    lblName1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [lblName1 addTarget:self action:@selector(showPopView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *v2=[[UIView alloc] initWithFrame:CGRectMake(0, v.frame.origin.y+v.frame.size.height+25, self.view.frame.size.width, 50)];
    v.tag=200;
    
    [v2 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:v2];
    
    UILabel *lblHeading2=nil;
    lblHeading2=[[UILabel alloc] initWithFrame:CGRectMake(20,10,165, 30)];
    lblHeading2.tag=101;
    [v2 addSubview:lblHeading2];
    
    UITextField *lblName2=nil;
    lblName2=[[UITextField alloc] initWithFrame:CGRectMake(190,10, v2.frame.size.width-195, 30)];
    lblName2.tag=201;
    [v2 addSubview:lblName2];
    
    [lblHeading1 setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15]];
    lblHeading1.text=@"Outcome";
    
    [lblHeading1 setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15]];
    lblHeading2.text=@"Next routine check at";
    
    [lblHeading1 setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15]];
    lblName2.placeholder=@"Date";
    
    screeningOutcomeOptionTable=[[UITableView alloc] initWithFrame:CGRectMake(0, v2.frame.origin.y+v2.frame.size.height+25, self.view.frame.size.width, 240)];
    [self.view addSubview:screeningOutcomeOptionTable];
    screeningOutcomeOptionTable.dataSource=self;
    screeningOutcomeOptionTable.delegate=self;
    
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(onClickSave:)];
}

-(void)onClickSave:(id)sender
{
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Stores"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Stores"];
        
        UILabel *lblHeading=nil;
        [lblHeading setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15]];
        lblHeading=[[UILabel alloc] initWithFrame:CGRectMake(20,15,110, 30)];
        lblHeading.tag=10;
        
        [cell.contentView addSubview:lblHeading];
        
        UITextField *lblName=nil;
        lblName=[[UITextField alloc] initWithFrame:CGRectMake(140,15, screeningOutcomeOptionTable.frame.size.width-145, 30)];
        lblName.tag=20;
        [lblName setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15]];
        [cell.contentView addSubview:lblName];
        
        lblName.delegate=self;
        
        
    }
    // UITextField *lblName=[cell.contentView viewWithTag:20];
    UILabel *lblHeading=[cell.contentView viewWithTag:10];
    
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    // [lblHeading setTextColor:[UIColor grayColor]];
    
    [lblHeading setText:[labelArrayOutcomeOption objectAtIndex:indexPath.row]];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setObject:[labelArrayOutcomeOption objectAtIndex:indexPath.row] forKey:@"selectedScreenLbl"];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"didDeselectRowAtIndexPath");
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return labelArrayOutcomeOption.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"accessoryButtonTappedForRowWithIndexPath at row=%ld",(long)indexPath.row);
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

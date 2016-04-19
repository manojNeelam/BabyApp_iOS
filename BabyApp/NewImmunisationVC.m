//
//  NewImmunisationVC.m
//  BabyApp
//
//  Created by Vishal Kolhe on 07/04/16.
//  Copyright © 2016 Infinity. All rights reserved.
//

#import "NewImmunisationVC.h"
#import "ConnectionsManager.h"
#import "XDPopupListView.h"
#import "Constants.h"
#import "DateTimeUtil.h"
#import "CustomIOS7AlertView.h"
#import "NSUserDefaults+Helpers.h"
#import "WSConstant.h"
#define kTabBarHeight 0


@interface NewImmunisationVC()<ServerResponseDelegate,UITextFieldDelegate, XDPopupListViewDataSource, XDPopupListViewDelegate,CustomIOS7AlertViewDelegate>
{
    XDPopupListView *mTextDropDownListView;
    NSArray *vaccineTypeArray;
    NSDictionary *selectedVacineType;
    UIButton *mDropDownBtn;
    UITextField *currentTextField;
    NSDate *selectedDate;
    BOOL keyboardIsShown;
    
    CustomIOS7AlertView *dateAlertView;
    UIDatePicker *datePicker;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UITextField *vaccineTextField;
@property (strong, nonatomic) IBOutlet UITextField *sequenceTextField;
@property (strong, nonatomic) IBOutlet UITextField *siteOfvaccinationTextField;
@property (strong, nonatomic) IBOutlet UITextField *dateGiveTextField;
@property (strong, nonatomic) IBOutlet UITextField *batchNoTextField;
@property (strong, nonatomic) IBOutlet UITextField *brandOfVaccineTextField;
@property (strong, nonatomic) IBOutlet UITextField *doctorTextField;
@property (strong, nonatomic) IBOutlet UITextField *clinicTextField;
@property (strong, nonatomic) IBOutlet UITextField *contraindicationsTextField;

@end

@implementation NewImmunisationVC
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title =@"New Immunisation";
    self.navigationItem.rightBarButtonItem = [self addRightButton];
    mTextDropDownListView = [[XDPopupListView alloc] initWithBoundView:_vaccineTextField dataSource:self delegate:self popupType:XDPopupListViewDropDown];
    mDropDownBtn = [[UIButton alloc]initWithFrame:_vaccineTextField.bounds];
    
    _vaccineTextField.tintColor = [UIColor clearColor];
    
    _dateGiveTextField.tintColor = [UIColor clearColor];
//    [_vaccineTextField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingDidBegin];
    [self getVaccineType];
//    [self configureDatePicker];
    
    // register for keyboard notifications
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(keyboardWillShow:)
    //                                                 name:UIKeyboardWillShowNotification
    //                                               object:self.view.window];
    //    // register for keyboard notifications
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(keyboardWillHide:)
    //                                                 name:UIKeyboardWillHideNotification
    //                                               object:self.view.window];
    keyboardIsShown = NO;
    //make contentSize bigger than your scrollSize (you will need to figure out for your own use case)
    //    CGSize scrollContentSize = CGSizeMake(320, 345);
    //    self.scrollView.contentSize = scrollContentSize;
    
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [self.view layoutIfNeeded];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:self.view.window];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
}
#pragma mark - addding left bar bu

-(UIBarButtonItem *)addRightButton
{
    //    UIImage *buttonImage = [UIImage imageNamed:@"teeth.png"];
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setTitle:@"SAVE" forState:UIControlStateNormal];
    
    //    [aButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    aButton.frame = CGRectMake(0.0, 0.0, 80,40);
    
    UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    
    [aButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    return aBarButtonItem;
}

#pragma mark - save action
-(void)saveAction
{
    
    NSString *vaccine = _vaccineTextField.text.length > 0 ? _vaccineTextField.text :@"";
    
    NSString *sequence = _sequenceTextField.text.length > 0 ? _sequenceTextField.text :@"";
    NSString *siteOfvaccination = _siteOfvaccinationTextField.text.length> 0 ? _siteOfvaccinationTextField.text : @"";
    
    NSString *dateGive = _dateGiveTextField.text.length> 0 ? _dateGiveTextField.text : @"";
    NSString *batchNo = _batchNoTextField.text.length> 0 ? _batchNoTextField.text : @"";
    
    NSString *brandOfVaccine = _brandOfVaccineTextField.text.length> 0 ? _brandOfVaccineTextField.text : @"";
    
    NSString *doctor = _doctorTextField.text.length> 0 ? _doctorTextField.text : @"";
    NSString *clinic = _clinicTextField.text.length> 0 ? _clinicTextField.text :
    @"";
    
    NSString *contraindications =  _contraindicationsTextField.text.length> 0 ? _clinicTextField.text :
    @"";
    
    NSArray *allfields = @[vaccine,sequence,siteOfvaccination,dateGive,batchNo,doctor,clinic,contraindications];
    for (NSString *field in allfields) {
        if (field.length == 0) {
            
            [Constants showOKAlertWithTitle:@"Info" message:@"Please enter all fields" presentingVC:self];
            return;
            
        }
    }
    NSString *childID = [NSUserDefaults retrieveObjectForKey:CURRENT_CHILD_ID];
    NSString *userID = [NSUserDefaults retrieveObjectForKey:USERID];

    NSDictionary *params = @{
                             @"user_id":userID,
                             @"child_id":childID,
                             @"vaccine_type":[NSNumber numberWithInt:[selectedVacineType[@"id"] intValue]],
                             @"sequence":sequence,
                             @"site_of_vaccination":siteOfvaccination,
                             @"date_given":dateGive,
                             @"batch_no":batchNo,
                             @"brand_of_vaccine":brandOfVaccine,
                             @"doctor":doctor,
                             @"clinic":clinic,
                             @"contraindications":contraindications
                             };
    
    [self callAddImmunisationWebservice:params];
    
    
}

#pragma mark - calling the add immunisataion webservice
-(void)callAddImmunisationWebservice:(NSDictionary *)paramaterDict
{
    [[ConnectionsManager sharedManager] addImmunisation:paramaterDict withdelegate:self];
    
}
#pragma mark - ServerResponseDelegate
-(void)success:(id)response
{
    
    NSLog(@"Success Response of the add immunisation : %@ ",response);
    NSDictionary* json = (NSDictionary *)response;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if([[json objectForKey:@"status"] boolValue])
        {
            
            //for feature use if any want to popup or cloe the this screen once done add immunisation
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New Immunisation" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:okAction];
            
            //                [self presentViewController:alert animated:YES completion:nil];
            [Constants showOKAlertWithTitle:@"New Immunisation" message:@"Immunisation created successfully." presentingVC:self];
        }
        else
        {
            
            [Constants showOKAlertWithTitle:@"Error" message:@"Unable to create immunisation, Please try again after some time." presentingVC:self];
            
        }
    });
    
}
-(void)failure:(id)response
{
    NSLog(@"Failure Response of the add immunisation : %@ ",response);
    [Constants showOKAlertWithTitle:@"Error" message:@"Unable to create immunisation, Please try again after some time." presentingVC:self];
    
}

-(void)getVaccineType
{
    //
    //    {
    //        code = BCG;
    //        id = 3;
    //        title = "BCG(TUBERCULOSIS)";
    //    },
    
    //    NSError *error;
    [SVProgressHUD showWithStatus:@"Loading"];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSDictionary *params = @{ @"user_id":@64,
                              @"child_id":@10};
    NSString *Post=[NSString stringWithFormat:@"user_id=%@&child_id=%@",params[@"user_id"],params[@"child_id"]];
    
    NSData *PostData = [Post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    NSString *PostLengh=[NSString stringWithFormat:@"%d",(int)[Post length]];
    NSURL *Url=[NSURL URLWithString: @"http://babyappdev.azurewebsites.net/apiv1/service/get_vaccine_type/"];
    
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
            NSLog(@"get_vaccine_type response : %@",json);
            if (!errorJason) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if([[json objectForKey:@"status"] boolValue])
                    {
                        vaccineTypeArray = json[@"data"];
                    }
                });
            }else
            {
                NSLog(@"get_vaccine_type error : %@",[errorJason localizedDescription]);
                [Constants showOKAlertWithTitle:@"Error" message:@"Unable get vaccine types , Please try again after some time." presentingVC:self];
                
            }
            
            
        }
        else{
            NSLog(@"get_vaccine_type error : %@",[error localizedDescription]);
            [Constants showOKAlertWithTitle:@"Error" message:@"Unable get vaccine types , Please try again after some time." presentingVC:self];
        }
        
    }];
    
    [postDataTask resume];
    
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textDidChanged:(id)sender
{
    
    UITextField *textField = (UITextField *)sender;
    if (textField == _vaccineTextField) {
        
        //        [self createLisDatatByStr:textField.text];
        
        [mTextDropDownListView show];
        [mTextDropDownListView reloadListData];
    }
    
}
-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    
}

#pragma mark - done clicked on number pad

-(void)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _sequenceTextField || textField == _batchNoTextField) {
        UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
        [keyboardDoneButtonView sizeToFit];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
        [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
        keyboardDoneButtonView.translucent = YES;
        keyboardDoneButtonView.barTintColor = [UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1.0];
        [doneButton setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
        textField.inputAccessoryView = keyboardDoneButtonView;
    }
    if (textField == _vaccineTextField) {
        [currentTextField resignFirstResponder];
        [self textDidChanged:textField];
        return NO;
    }
    else if(textField == _dateGiveTextField)
    {
        [currentTextField resignFirstResponder];

        [self openDate];
        return NO;
    }
    currentTextField = textField;
    return YES;
}

#pragma mark - XDPopupListViewDataSource & XDPopupListViewDelegate


- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return vaccineTypeArray.count;
}
- (CGFloat)itemCellHeight:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (void)clickedListViewAtIndexPath:(NSIndexPath *)indexPath
{
    selectedVacineType =vaccineTypeArray[indexPath.row];
    
    NSLog(@"%d: %@", (int)indexPath.row, selectedVacineType);
    _vaccineTextField.text = selectedVacineType[@"code"];
    
}
- (UITableViewCell *)itemCell:(NSIndexPath *)indexPath
{
    if (vaccineTypeArray.count == 0) {
        return nil;
    }
    static NSString *identifier = @"viccineTypeCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    NSDictionary *vaccineDict =vaccineTypeArray[indexPath.row];
    cell.textLabel.text = vaccineDict[@"code"];
    return cell;
}
#pragma mark - Picker Setup

- (void)configureDatePicker {
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker setDate:[NSDate date]];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    //    datePicker.maximumDate = [NSDate date];
    [datePicker addTarget:self action:@selector(udpdateDateField:) forControlEvents:UIControlEventValueChanged];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
    toolBar.translucent = YES;
    toolBar.barTintColor = [UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1.0];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWriting:)];
    [doneButton setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonClick:)];
    [cancelButton setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:@[cancelButton,flexible, doneButton]];
    
    [_dateGiveTextField setInputView:datePicker];
    _dateGiveTextField.inputAccessoryView = toolBar;
    _dateGiveTextField.inputView.backgroundColor = [UIColor whiteColor];
}
-(void)cancelButtonClick:(id)sender
{
    [_dateGiveTextField resignFirstResponder];
}
- (void)doneWriting:(id)sender {
    if (!selectedDate) {
        
        selectedDate = [NSDate date];
    }
    NSDateFormatter *dateFormater = [NSDateFormatter new];
    [dateFormater setDateFormat:@"MM-dd-yyyy"];
    NSString *dobDatestr = [dateFormater stringFromDate:selectedDate];
    NSLog(@"selected Date is %@",dobDatestr);
    _dateGiveTextField.text= dobDatestr;
    
    [_dateGiveTextField resignFirstResponder];
    
}

- (void)udpdateDateField:(UIDatePicker *)sender {
    NSLog(@"Date : %@",sender.date);
    selectedDate = sender.date;
    //NSLog(@"Selected Date: %@",)
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height - kTabBarHeight);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height - kTabBarHeight);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}

-(void)openDate
{
    dateAlertView = [[CustomIOS7AlertView alloc] init];
    [dateAlertView setContainerView:[self createDateView]];
    [dateAlertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"Done", nil]];
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
    _dateGiveTextField.text = dateFromData;
}



@end

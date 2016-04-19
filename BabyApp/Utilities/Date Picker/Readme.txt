how to create

 CustomIOS7AlertView *dateAlertView = [[CustomIOS7AlertView alloc] init];
    [dateAlertView setContainerView:[self createDateView]];
    [dateAlertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Close",@"Set", nil]];
    [dateAlertView setDelegate:self];
    [dateAlertView setUseMotionEffects:true];




-function to create date picker view

- (UIView *)createDateView
{
	
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 216)];
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
	datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	datePicker.frame = CGRectMake(10, 10, 280, 216);
    datePicker.maximumDate = [NSDate dateBeforeYears:18];
	datePicker.datePickerMode = UIDatePickerModeDate;
    if (self.dateBirth) {
        datePicker.date = self.dateBirth;
    }
    [demoView addSubview:datePicker];
    return demoView;
}


Deletgate

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [alertView close];
    if (buttonIndex == 1) {
        NSString * dateFromData = [DateTimeUtil stringFromDateTime:datePicker.date withFormat:DATE_FMT_DD_MM_YYYY];
        [self.fieldBirthDate setText:dateFromData];
    }
    
}
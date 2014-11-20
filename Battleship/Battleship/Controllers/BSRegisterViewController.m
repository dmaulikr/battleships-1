//
//  BSRegisterViewController.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-13.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "BSRegisterViewController.h"
#import "BPForm.h"
#import "BPFormFloatInputTextFieldCell.h"
#import "BPFormFloatInputTextViewCell.h"

@implementation BSRegisterViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	BOOL isIOS7orLater = ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0);
	
	Class inputTextFieldClass = isIOS7orLater ? [BPFormFloatInputTextFieldCell class] : [BPFormInputTextFieldCell class];
	Class inputTextViewClass = isIOS7orLater ? [BPFormFloatInputTextViewCell class] : [BPFormInputTextViewCell class];
	
	self.title = @"Sign Up";
	
	BPFormInputTextFieldCell *emailCell = [[inputTextFieldClass alloc] init];
	emailCell.textField.placeholder = @"Email";
	emailCell.textField.delegate = self;
	emailCell.customCellHeight = 40.0f;
	emailCell.mandatory = YES;
	emailCell.shouldChangeTextBlock = BPValidateBlockWithPatternAndMessage(@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}", @"The email should look like name@provider.domain");
	
	BPFormInputTextFieldCell *passwordCell = [[inputTextFieldClass alloc] init];
	passwordCell.textField.placeholder = @"Password";
	passwordCell.textField.delegate = self;
	passwordCell.textField.secureTextEntry = YES;
	passwordCell.spaceToNextCell = 2.0f;
	passwordCell.customCellHeight = 40.0f;
	passwordCell.mandatory = YES;
	passwordCell.shouldChangeTextBlock = ^BOOL(BPFormInputCell *inCell, NSString *inText) {
		if (inText.length >= 6) {
			inCell.validationState = BPFormValidationStateValid;
			inCell.shouldShowInfoCell = NO;
		} else {
			inCell.validationState = BPFormValidationStateInvalid;
			inCell.infoCell.label.text = @"Password must be at least 6 characters";
			inCell.shouldShowInfoCell = YES;
		}
		return YES;
	};
	
	BPFormInputTextFieldCell *password2Cell = [[inputTextFieldClass alloc] init];
	password2Cell.textField.placeholder = @"Verify Password";
	password2Cell.textField.delegate = self;
	password2Cell.textField.secureTextEntry = YES;
	password2Cell.customCellHeight = 40.0f;
	password2Cell.mandatory = YES;
	password2Cell.shouldChangeTextBlock = ^BOOL(BPFormInputCell *inCell, NSString *inText) {
		if (inText.length && [inText isEqualToString:passwordCell.textField.text]) {
			inCell.validationState = BPFormValidationStateValid;
			inCell.shouldShowInfoCell = NO;
		} else {
			inCell.validationState = BPFormValidationStateInvalid;
			inCell.infoCell.label.text = @"The passwords must match";
			inCell.shouldShowInfoCell = YES;
		}
		return YES;
	};
	
	BPFormInputTextFieldCell *nameCell = [[inputTextFieldClass alloc] init];
	nameCell.textField.placeholder = @"Name";
	nameCell.textField.delegate = self;
	nameCell.customCellHeight = 40.0f;
	
	BPFormInputTextFieldCell *phoneCell = [[inputTextFieldClass alloc] init];
	phoneCell.textField.placeholder = @"Phone";
	phoneCell.textField.delegate = self;
	phoneCell.textField.keyboardType = UIKeyboardTypePhonePad;
	phoneCell.customCellHeight = 40.0f;
	
	BPFormInputTextViewCell *descriptionCell = [[inputTextViewClass alloc]  init];
	descriptionCell.textView.delegate = self;
	descriptionCell.customCellHeight = 90.0f;
	descriptionCell.customContentWidth = 310.0f;
	//    descriptionCell.customContentHeight = 60.0f;
	descriptionCell.mandatory = NO;
	if (isIOS7orLater) {
		[(BPFormFloatInputTextViewCell *)descriptionCell setPlaceholder:@"Description"];
	}
	descriptionCell.shouldChangeTextBlock = ^BOOL(BPFormInputCell *inCell, NSString *inText) {
		if (inText.length) {
			inCell.validationState = BPFormValidationStateValid;
			inCell.shouldShowInfoCell = NO;
		} else {
			inCell.validationState = BPFormValidationStateInvalid;
			inCell.infoCell.label.text = @"No description";
			inCell.shouldShowInfoCell = YES;
		}
		return YES;
	};
	
	BPFormButtonCell *signUpCell = [[BPFormButtonCell alloc] init];
	signUpCell.button.backgroundColor = [UIColor blueColor];
	[signUpCell.button setTitle:@"Sign Up" forState:UIControlStateNormal];
	signUpCell.button.layer.cornerRadius = 4.0;
	signUpCell.button.layer.masksToBounds = YES;
	signUpCell.customContentWidth = 220;
	signUpCell.buttonActionBlock = ^(void){
		NSLog(@"Button pressed");
		
		[emailCell.textField resignFirstResponder];
		[passwordCell.textField resignFirstResponder];
		[password2Cell.textField resignFirstResponder];
		[nameCell.textField resignFirstResponder];
		[phoneCell.textField resignFirstResponder];
		[descriptionCell.textView resignFirstResponder];
	};
	
	self.formCells = @[@[emailCell, passwordCell, password2Cell, nameCell, phoneCell, descriptionCell], @[signUpCell]];
	
	[self setHeaderTitle:@"Please enter your credentials" forSection:0];
	[self setFooterTitle:@"When you're done, press <<Sign Up>>" forSection:0];
	
	self.customSectionHeaderHeight = 30;
}

@end

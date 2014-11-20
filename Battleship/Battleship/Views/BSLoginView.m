//
//  LoginView.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-13.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "BSLoginView.h"
#import "BSLoginFieldView.h"

@interface BSLoginView() <UITextFieldDelegate>

@property (nonatomic, readwrite) IBOutlet BSLoginFieldView *usernameField;
@property (nonatomic, readwrite) IBOutlet BSLoginFieldView *passwordField;

@end

@implementation BSLoginView

- (void)awakeFromNib
{
	[super awakeFromNib];
	[_usernameField.textField setDelegate:self];
	[_passwordField.textField setDelegate:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
	if (textField == _passwordField.textField) {
		[_passwordField setPlaceHolderHidden:newString.length > 0];
	} else if (textField == _usernameField.textField) {
		[_usernameField setPlaceHolderHidden:newString.length > 0];
	}
	return YES;
}

@end

//
//  LoginFieldView.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-13.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "BSLoginFieldView.h"

@interface BSLoginFieldView()
@property (nonatomic, readwrite) IBOutlet UITextField *textField;
@property (nonatomic, readwrite) IBOutlet UILabel *placeholderLabel;
@end


@implementation BSLoginFieldView

- (void)awakeFromNib
{
	[super awakeFromNib];
	_placeholderLabel.text = _textField.placeholder;
	_textField.placeholder = @"";
}

- (void)drawRect:(CGRect)rect
{
	self.layer.borderColor = [UIColor whiteColor].CGColor;
	self.layer.borderWidth = 1.5f;
}

- (void)setPlaceHolderHidden:(BOOL)hidden
{
	[_placeholderLabel setHidden:hidden];
}

- (void)setPlaceHolderText:(NSString *)placholder
{
	[_placeholderLabel setText:placholder];
}

@end

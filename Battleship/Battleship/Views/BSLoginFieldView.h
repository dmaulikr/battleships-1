//
//  LoginFieldView.h
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-13.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface BSLoginFieldView : UIView

@property (nonatomic, readonly) UITextField *textField;
@property (nonatomic, readonly) IBOutlet UILabel *placeholderLabel;

- (void)setPlaceHolderHidden:(BOOL)hidden;
- (void)setPlaceHolderText:(NSString*)placholder;

@end

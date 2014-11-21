//
//  LoginView.h
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-13.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSLoginFieldView.h"

@interface BSLoginView : UIView

@property (nonatomic, readonly) BSLoginFieldView *usernameField;
@property (nonatomic, readonly) BSLoginFieldView *passwordField;

@end

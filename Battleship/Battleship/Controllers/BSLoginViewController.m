//
//  BSLoginViewController.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-13.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "BSLoginViewController.h"
#import "BSLoginView.h"
#import "CBZSplashView.h"
#import "ShimmeringButton.h"
#import "SIAlertView.h"
#import "SVProgressHUD.h"

#import "BSNavigationManager.h"

#import "UIColor+HexString.h"
#import "UIBezierPath+Shapes.h"

@interface BSLoginViewController()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet BSLoginView *loginView;
@property (weak, nonatomic) IBOutlet ShimmeringButton *loginButton;
@end

@implementation BSLoginViewController {
	CBZSplashView *_splashView;
	CGFloat _topConstant;
	CGFloat _bottomConstant;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.topConstraint.constant = -[[UIScreen mainScreen] bounds].size.height;
	self.bottomConstraint.constant = -[[UIScreen mainScreen] bounds].size.height;
	[self.view layoutIfNeeded];
	
	_splashView = [CBZSplashView splashViewWithIcon:[UIImage imageNamed:@"ship"]
									backgroundColor:[UIColor colorWithHexString:@"961FFF"]];
	_splashView.animationDuration = 1.4;

	[self.view addSubview:_splashView];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.view bringSubviewToFront:_splashView];
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[_splashView startAnimationWithCompletionHandler:^{
			PFUser *user = [PFUser currentUser];
			if (user) {
				[user fetchInBackgroundWithBlock:^(PFObject *object, NSError *error) {
					
				}];
				[[BSNavigationManager sharedInstance] navigateToMainViewController];
			} else {
				self.topConstraint.constant = 0.f;
				self.bottomConstraint.constant = 10.f;
				[UIView animateWithDuration:0.27 animations:^{
					[self.view layoutIfNeeded];
				}];
			}
			
		}];
		[[UIApplication sharedApplication] setStatusBarHidden:NO];
	});
}

- (IBAction)didTapLogin:(id)sender
{
	NSString *username = self.loginView.usernameField.textField.text;
	NSString *password = self.loginView.passwordField.textField.text;
	
	if ([username length] < 4 || [password length] < 4) {
		SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Invalid Entry"
														 andMessage:@"Username and Password must both be at least 4 characters long."];
		[alertView addButtonWithTitle:@"Okay"
								 type:SIAlertViewButtonTypeDefault
							  handler:^(SIAlertView *alert) {
								  [alert dismissAnimated:YES];
							  }];
		[alertView show];
	} else {
		[self loginWithUsername:username password:password];
	}
}

- (void)loginWithUsername:(NSString*)username password:(NSString*)password
{
	
		[SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
		[PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
			[SVProgressHUD dismiss];
			if (user) {
				[[BSNavigationManager sharedInstance] navigateToMainViewController];
			} else {
				SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Login Failed."
																 andMessage:[NSString stringWithFormat:@"Invalid Username and/or Password. Would you like to SignUp as %@", username]];
				
				[alertView addButtonWithTitle:@"Cancel"
										 type:SIAlertViewButtonTypeDefault
									  handler:^(SIAlertView *alert) {
										  NSLog(@"Button1 Clicked");
									  }];
				[alertView addButtonWithTitle:@"Sign Up"
										 type:SIAlertViewButtonTypeDefault
									  handler:^(SIAlertView *alert) {
										  [self signUpWithUsername:username password:password];
									  }];
				
				alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
				
				[alertView show];
			}
		}];
}

- (void)signUpWithUsername:(NSString*)username password:(NSString*)password
{
	PFUser *newUser = [PFUser user];
	newUser.username = username;
	newUser.password = password;
	[SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
	[newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
		[SVProgressHUD dismiss];
		if (error) {
			NSString *errorString = [[error userInfo] objectForKey:@"error"];
			SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Error"
															 andMessage:errorString];
			[alertView addButtonWithTitle:@"Okay"
									 type:SIAlertViewButtonTypeDefault
								  handler:^(SIAlertView *alert) {
									  [alert dismissAnimated:YES];
								  }];
			[alertView show];
		} else {
			[self loginWithUsername:username password:password];
		}
	}];
}

@end

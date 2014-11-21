//
//  BSSplashViewController.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-19.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "BSSettingsTableViewController.h"

@implementation BSSettingsTableViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController.navigationBar setHidden:NO];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self.navigationController.navigationBar setHidden:YES];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

@end

//
//  BSAddPlayerViewController.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-13.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "BSAddPlayerViewController.h"

@implementation BSAddPlayerViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (IBAction)back:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end

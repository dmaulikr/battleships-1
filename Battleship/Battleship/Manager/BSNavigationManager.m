//
//  BSNavigationManager.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-19.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "BSNavigationManager.h"
#import "BSAppDelegate.h"

#import "UIStoryboard+Convenience.h"

@interface BSNavigationManager()
@end

@implementation BSNavigationManager

+ (id)sharedInstance
{
	static BSNavigationManager *manager;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		manager = [BSNavigationManager new];
	});
	return manager;
}

- (void)navigateToMainViewController
{
	UIViewController *vC = [UIStoryboard initialViewControllerForStoryboardNamed:@"Main"];
	[[[BSAppDelegate sharedInstance] window] setRootViewController:vC];
}

- (void)navigateToAuthenTicationViewController
{
	UIViewController *vC = [UIStoryboard initialViewControllerForStoryboardNamed:@"Authentication"];
	[[[BSAppDelegate sharedInstance] window] setRootViewController:vC];
}

@end

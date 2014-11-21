//
//  AppDelegate.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-10-31.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "BSAppDelegate.h"
#import "BSNavigationManager.h"

@interface BSAppDelegate ()

@end

@implementation BSAppDelegate


+ (BSAppDelegate*)sharedInstance
{
	return (BSAppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
	
	[Parse setApplicationId:@"wy9SRgOBUxPQ728bj6wQVmcL11YfRA6b8Q9J6TxB"
				  clientKey:@"HKRQvgOBB7Rcn4AgZGBxJf25KFZ2dAW9LstjCu6Y"];

	
	return YES;
}


@end

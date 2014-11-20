//
//  UIStoryboard+Convenience.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-19.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "UIStoryboard+Convenience.h"

@implementation UIStoryboard (Convenience)

+ (id)initialViewControllerForStoryboardNamed:(NSString*)storyboardName
{
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
	return [storyboard instantiateInitialViewController];
}

+ (id)viewControllerWithIdentifier:(NSString*)identifier storyboardNamed:(NSString*)storyboardName
{
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
	return [storyboard instantiateViewControllerWithIdentifier:storyboardName];
}

@end

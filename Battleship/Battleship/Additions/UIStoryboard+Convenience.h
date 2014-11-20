//
//  UIStoryboard+Convenience.h
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-19.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (Convenience)

+ (id)initialViewControllerForStoryboardNamed:(NSString*)storyboardName;
+ (id)viewControllerWithIdentifier:(NSString*)identifier storyboardNamed:(NSString*)storyboardName;

@end

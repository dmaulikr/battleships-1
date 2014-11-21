//
//  AppDelegate.h
//  Battleship
//
//  Created by Karim Kawambwa on 2014-10-31.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface BSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (BSAppDelegate*)sharedInstance;


@end


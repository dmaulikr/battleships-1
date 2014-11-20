//
//  BSNavigationManager.h
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-19.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BSNavigationManager : NSObject

+ (id)sharedInstance;

- (void)navigateToMainViewController;
- (void)navigateToAuthenTicationViewController;

@end

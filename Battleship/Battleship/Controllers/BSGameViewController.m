//
//  GameViewController.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-10-31.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "BSGameViewController.h"

@interface BSGameViewController()

@end

@implementation BSGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end

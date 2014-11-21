//
//  ShimmeringButton.h
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-13.
//  Copyright (c) 2014 Martijn. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FBShimmeringView.h"

IB_DESIGNABLE

@interface ShimmeringButton : FBShimmeringView
@property (nonatomic, readonly) UILabel *titleLabel;

@end

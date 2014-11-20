//
//  BSCircularImageView.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-19.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "BSCircularImageView.h"

@implementation BSCircularImageView

- (void)layoutSubviews
{
	[super layoutSubviews];
	self.layer.cornerRadius = self.frame.size.height/2.f;
}

@end

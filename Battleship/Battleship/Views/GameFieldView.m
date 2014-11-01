//
//  GameFieldView.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-01.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "GameFieldView.h"

const NSInteger columnCount = 6;
const NSInteger rowCount = 4;

@interface GameFieldView()
@property (nonatomic) CGFloat height;
@end

@implementation GameFieldView

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		
	}
	return self;
}


- (void)calculateGrid
{
	CGFloat diameter = self.frame.size.width/columnCount;
	self.height = diameter * rowCount;
}

- (void)resetField
{
	
}

@end

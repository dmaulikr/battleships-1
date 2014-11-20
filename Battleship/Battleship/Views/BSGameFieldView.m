//
//  GameFieldView.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-01.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "BSGameFieldView.h"

const NSInteger columnCount = 6;
const NSInteger rowCount = 4;

@interface BSGameFieldView()
@property (nonatomic) CGFloat height;
@end

@implementation BSGameFieldView

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

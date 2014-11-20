//
//  ShimmeringButton.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-13.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "ShimmeringButton.h"

@interface ShimmeringButton()
@property (nonatomic, readwrite) IBOutlet UILabel *titleLabel;
@end

@implementation ShimmeringButton

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.contentView = _titleLabel;
	self.shimmering = YES;
}

- (void)drawRect:(CGRect)rect
{
	self.layer.cornerRadius = self.frame.size.height/2.f;
}

@end

//
//  UnitView.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-01.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "UnitView.h"

@implementation UnitView

+ (UnitView *)viewWithFrame:(CGRect)frame delegate:(id<UnitViewDelegate>)delegate
{
	UnitView *unit = [[UnitView alloc] initWithFrame:frame];
	unit.delegate = delegate;
	return unit;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.titleLabel.text = @"";
		self.layer.borderWidth = 1.f;
		self.backgroundColor = [UIColor clearColor];
		self.layer.borderColor = [[UIColor whiteColor] CGColor];
		[self setupGesturerecognizers];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	self.layer.cornerRadius = self.frame.size.width/2.f;
}

- (void)setupGesturerecognizers
{
	UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureRecognizer:)];
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureRecognizer:)];
	[self addGestureRecognizer:longPressRecognizer];
	[self addGestureRecognizer:tapGestureRecognizer];
}

- (void)handleGestureRecognizer:(UIGestureRecognizer*)recognizer
{
	if ([recognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
		[self handleLongPressGestureRecognizer:(UILongPressGestureRecognizer*)recognizer];
	} else if ([recognizer isKindOfClass:[UITapGestureRecognizer class]]) {
		[self handleTapGestureRecognizer:(UITapGestureRecognizer*)recognizer];
	} else {
		
	}
}

- (void)handleLongPressGestureRecognizer:(UILongPressGestureRecognizer*)recognizer
{
	if ([self.delegate respondsToSelector:@selector(longPressedUnitView:)]) {
		[self.delegate longPressedUnitView:self];
	}
}

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer*)recognizer
{
	if ([self.delegate respondsToSelector:@selector(tappedUnitView:)]) {
		[self.delegate tappedUnitView:self];
	}
}

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
	[UIView animateWithDuration:0.27 animations:^{
		if (highlighted) {
			[self setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.75]];
		} else {
			[self setBackgroundColor:[UIColor clearColor]];
		}
	}];
}

@end

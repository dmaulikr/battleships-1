//
//  GameFieldView.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-01.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "BSFieldView.h"
#import "BSUnitView.h"

const NSInteger columnCount = 6;
const NSInteger rowCount = 4;
const CGFloat spacing = 10.f;

@interface BSFieldView()
@property (nonatomic) NSMutableDictionary *unitsDictionary;
@end

@implementation BSFieldView

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self setBackgroundColor:[UIColor clearColor]];
	[self setupUnits];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	[self layoutUnits];
}

- (CGSize)fieldSize
{
	CGFloat width = self.frame.size.width;
	CGFloat diameter = width/columnCount;
	return CGSizeMake(diameter*rowCount, diameter*columnCount);
}

- (CGSize)unitSize
{
	CGFloat width = self.frame.size.width;
	CGFloat diameter = width/columnCount;
	diameter -= spacing;
	return CGSizeMake(diameter, diameter);
}

- (void)resetField
{
	[_units makeObjectsPerformSelector:@selector(removeFromSuperview)];
	_units = @[];
	[self setupUnits];
}

- (void)setupUnits
{
	[_units makeObjectsPerformSelector:@selector(removeFromSuperview)];
	_units = @[];
	
	for (int i = 0; i < rowCount; i++) {
		NSMutableArray *unitsArray = [NSMutableArray array];
		[self.unitsDictionary setObject:unitsArray forKey:@(i)];
		for (int i = 0; i < columnCount; i++) {
			UnitView *unitView = [UnitView viewWithFrame:CGRectZero delegate:self];
			[unitsArray addObject:unitView];
			[self addSubview:unitView];
		}
	}
}

- (void)layoutUnits
{
	__block CGFloat width = self.frame.size.width;
	__block CGFloat height = self.frame.size.height;
	[self.unitsDictionary enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSMutableArray *unitsArray, BOOL *stop) {
		__block NSInteger yIndex = [key integerValue];
		__block NSInteger xIndex = 0;
		[unitsArray enumerateObjectsUsingBlock:^(UnitView *unitView, NSUInteger idx, BOOL *stop) {
			CGFloat ySpacing = yIndex*((height/rowCount) - self.unitSize.height);
			CGFloat xSpacing = xIndex*((width/columnCount) - self.unitSize.width);
			CGFloat xPosition = xIndex*self.unitSize.width;
			CGFloat yPosition = yIndex*self.unitSize.height;
			CGRect frame = CGRectMake(xPosition + xSpacing, yPosition + ySpacing,
									  self.unitSize.width, self.unitSize.height);
			
			[unitView setFrame:frame];
			xIndex++;
		}];
		yIndex++;
	}];
}

#pragma mark - UnitViewDelegate

- (void)longPressedUnitView:(UnitView *)unitView
{
	
}

- (void)tappedUnitView:(UnitView *)unitView
{
	
}

@end

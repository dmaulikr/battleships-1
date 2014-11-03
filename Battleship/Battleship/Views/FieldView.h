//
//  GameFieldView.h
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-01.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FieldView;
@class UnitView;

@protocol FieldViewDelegate <NSObject>

- (void)fieldView:(FieldView*)fieldView didSelectUnitView:(UnitView*)unitView;

@end

@interface FieldView : UIView

@property (nonatomic, readonly) CGSize fieldSize;
@property (nonatomic, readonly) CGSize unitSize;
@property (nonatomic, readonly) NSArray *units;

- (void)resetField;

@end

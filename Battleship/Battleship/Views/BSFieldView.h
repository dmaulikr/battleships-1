//
//  GameFieldView.h
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-01.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSFieldView;
@class BSUnitView;

@protocol FieldViewDelegate <NSObject>

- (void)fieldView:(BSFieldView*)fieldView didSelectUnitView:(BSUnitView*)unitView;

@end

@interface BSFieldView : UIView

@property (nonatomic, readonly) CGSize fieldSize;
@property (nonatomic, readonly) CGSize unitSize;
@property (nonatomic, readonly) NSArray *units;

- (void)resetField;

@end

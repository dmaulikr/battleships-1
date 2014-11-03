//
//  UnitView.h
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-01.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UnitView;

@protocol UnitViewDelegate <NSObject>

- (void)longPressedUnitView:(UnitView*)unitView;
- (void)tappedUnitView:(UnitView*)unitView;

@end

@interface UnitView : UIButton

@property (nonatomic) id <UnitViewDelegate> delegate;

+ (UnitView*)viewWithFrame:(CGRect)frame delegate:(id<UnitViewDelegate>)delegate;

@end

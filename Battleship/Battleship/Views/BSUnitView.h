//
//  UnitView.h
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-01.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSUnitView;

@protocol UnitViewDelegate <NSObject>

- (void)longPressedUnitView:(BSUnitView*)unitView;
- (void)tappedUnitView:(BSUnitView*)unitView;

@end

@interface BSUnitView : UIView

@property (nonatomic) id <UnitViewDelegate> delegate;

+ (BSUnitView*)viewWithFrame:(CGRect)frame delegate:(id<UnitViewDelegate>)delegate;

@end

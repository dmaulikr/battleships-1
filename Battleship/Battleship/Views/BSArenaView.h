//
//  BSArenaView.h
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-20.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSArenaView;
@class BSFieldView;
@class BSUnitView;

@protocol BSAreneViewDelegate <NSObject>

- (BOOL)arenaView:(BSArenaView*)arenaView shouldPresentShotConfirmationForFieldView:(BSFieldView*)fieldView;
- (void)arenaView:(BSArenaView*)arenaView didShootFieldView:(BSFieldView*)fieldView unitView:(BSUnitView*)unitView hit:(BOOL)hit;
- (void)arenaView:(BSArenaView*)arenaView didSinkShipInFieldView:(BSFieldView*)fieldView;

@end

@interface BSArenaView : UIView

@property (nonatomic, weak) IBOutlet BSFieldView *topFieldView;
@property (nonatomic, weak) IBOutlet BSFieldView *bottomFieldView;

@end

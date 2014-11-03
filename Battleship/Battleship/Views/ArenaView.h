//
//  ArenaView.h
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-02.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FieldView.h"

@class ArenaView;
@class FieldView;
@class UnitView;

@protocol AreneViewDelegate <NSObject>

- (BOOL)arenaView:(ArenaView*)arenaView shouldPresentShotConfirmationForFieldView:(FieldView*)fieldView;
- (void)arenaView:(ArenaView*)arenaView didShootFieldView:(FieldView*)fieldView unitView:(UnitView*)unitView hit:(BOOL)hit;
- (void)arenaView:(ArenaView*)arenaView didSinkShipInFieldView:(FieldView*)fieldView;

@end


@interface ArenaView : UIView

@property (nonatomic, weak) IBOutlet FieldView *topFieldView;
@property (nonatomic, weak) IBOutlet FieldView *bottomFieldView;

@end

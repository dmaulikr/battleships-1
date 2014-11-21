//
//  GameViewController.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-10-31.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "BSGameViewController.h"
#import "ArenaView.h"

@interface BSGameViewController()
@property (weak, nonatomic) IBOutlet ArenaView *arenaView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *chancesLabel;
@property (nonatomic) NSInteger chances;

@end

@implementation BSGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.chances = 24;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)setChances:(NSInteger)chances
{
	_chances = chances;
	[self updateChances];
}

- (void)updateChances
{
	NSMutableDictionary *attribs = [self attributesForLabel:self.chancesLabel];
	NSString *text = [NSString stringWithFormat:@"%i / %i", self.chances];
	NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:attribs];
	
	// Red text attributes
	UIColor *redColor = [UIColor redColor];
	NSRange whiteText = [text rangeOfString:redText];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
	[attributedText setAttributes:@{NSForegroundColorAttributeName:redColor}
							range:redTextRange];
	
	// Green text attributes
	UIColor *greenColor = [UIColor greenColor];
	NSRange greenTextRange = [text rangeOfString:greenText];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
	[attributedText setAttributes:@{NSForegroundColorAttributeName:greenColor}
							range:greenTextRange];
	
}

- (void)updateScore
{
	
}

- (NSMutableDictionary*)attributesForLabel:(UILabel*)label
{
	NSDictionary *attribs = @{NSForegroundColorAttributeName: label.textColor,NSFontAttributeName: label.font, NSFontAttributeName:label.font };
	return [attribs mutableCopy];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (BOOL)shouldAutorotate
{
	return NO;
}

@end

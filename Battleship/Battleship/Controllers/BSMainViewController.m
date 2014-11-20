//
//  BSMainViewController.m
//  Battleship
//
//  Created by Karim Kawambwa on 2014-11-19.
//  Copyright (c) 2014 Martijn. All rights reserved.
//

#import "BSMainViewController.h"
#import "BSPlayerCell.h"

@interface BSMainViewController() <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (nonatomic) UIView *overlay;
@property (nonatomic, readonly) BOOL menuVisible;
@end

@implementation BSMainViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.menuViewHeightConstraint.constant = 0;
	[self.view layoutIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController.navigationBar setHidden:YES];
}

- (IBAction)menuButtonTapped:(UIButton *)sender
{
	[self toggleMenuWithCompletion:nil];
}

- (void)toggleMenuWithCompletion:(void (^)())completion
{
	[self.view layoutIfNeeded];
	[self.overlay setAlpha: self.menuVisible ? 1 : 0];
	self.menuViewHeightConstraint.constant = self.menuVisible ? 0 :  200.f;
	[_overlay setHidden:NO];
	[UIView animateWithDuration:0.27 animations:^{
		[self.overlay setAlpha: self.menuVisible ? 1 : 0];
		[self.view layoutIfNeeded];
	} completion:^(BOOL finished) {
		if (completion){
			completion();
		}
		[self.overlay setHidden: self.menuVisible ? NO : YES];
	}];
}

- (UIView *)overlay
{
	if (!_overlay) {
		_overlay = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		[_overlay setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
		[_overlay setHidden:YES];
		[self.view insertSubview:_overlay belowSubview:self.menuView];
	}
	return _overlay;
}

- (IBAction)menuTappedButton:(UIButton *)sender
{
	NSString *segueIdentifier;
	switch (sender.tag) {
		case 0:
			break;
		case 1:
			break;
		case 2:
			break;
		case 3:
			segueIdentifier = @"BSSettingsTableViewControllerSegue";
			break;
		default:
			break;
	}
	[self toggleMenuWithCompletion:^{
		if (segueIdentifier) {
			[self performSegueWithIdentifier:segueIdentifier sender:self];
		}
	}];
}

- (BOOL)menuVisible
{
	return self.menuViewHeightConstraint.constant > 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	switch (section) {
		case 0:
			return 5;
		case 1:
			return 10;
		default:
			return 0;
	}
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	BSPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BSPlayerCell class])];
	return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	switch (section) {
		case 0:
			return @"RECENT GAMES";
		case 1:
			return @"FINISHED GAMES";
		default:
			return nil;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 80.f;
}

@end

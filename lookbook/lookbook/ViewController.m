//
//  ViewController.m
//  lookbook
//
//  Created by Karim Kawambwa on 2014-11-05.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
	CGFloat _constant;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_constant = self.constraint.constant;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
- (IBAction)tappedButton:(UIButton*)sender {
	
	self.constraint.constant = !sender.selected ? 0 : _constant;
	[UIView animateWithDuration:0.5 animations:^{
		[self.view layoutIfNeeded];
	}];
	
	[sender setSelected:!sender.selected];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.images.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
	[(UIImageView*)[cell viewWithTag:100] setImage:self.images[indexPath.row]];
	
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[self.delegate didTapImageAtIndex:indexPath.row];
	[collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return collectionView.frame.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(0, 2, 0, 2);
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self updateBackgroundImageWithScrollview:scrollView];
	_currentIndex = scrollView.contentSize.width / scrollView.contentOffset.x;
	_currentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
	//[self.backgroundView animateFade];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}

@end

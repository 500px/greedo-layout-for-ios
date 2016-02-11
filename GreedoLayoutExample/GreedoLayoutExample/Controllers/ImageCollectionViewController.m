//
//  ImageCollectionViewController.m
//  GreedoLayoutExample
//
//  Created by Denny Hoang on 2016-02-10.
//  Copyright © 2016 500px. All rights reserved.
//

#import "ImageCollectionViewController.h"
#import "ImageCollectionViewCell.h"
#import "GreedoCollectionViewLayout.h"
#import "UIImage+Random.h"

@interface ImageCollectionViewController () <GreedoCollectionViewLayoutDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) GreedoCollectionViewLayout *collectionViewSizeCalculator;
@property (strong, nonatomic) NSMutableArray *imageDataSource;

@end

@implementation ImageCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.collectionViewSizeCalculator.rowMaximumHeight = CGRectGetHeight(self.collectionView.bounds) / 3;

    self.automaticallyAdjustsScrollViewInsets = NO;

    self.collectionView.backgroundColor = [UIColor whiteColor];

    // Configure spacing between cells
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 5.0f;
    layout.minimumLineSpacing = 5.0f;
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 5.0f, 5.0f, 5.0f);

    self.collectionView.collectionViewLayout = layout;

    // Setup image data source
    [self generateImages];
}

- (void)generateImages
{
    for (NSInteger x = 0; x < 50; x++) {
        [self.imageDataSource addObject:[UIImage randomImage]];
    }
}

#pragma mark - <UICollectionViewDataSource>

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ImageCollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [self.imageDataSource objectAtIndex:indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageDataSource.count;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.collectionViewSizeCalculator sizeForPhotoAtIndexPath:indexPath];
}

#pragma mark - <GreedoCollectionViewLayoutDataSource>

- (CGSize)greedoCollectionViewLayout:(GreedoCollectionViewLayout *)layout originalImageSizeAtIndexPath:(NSIndexPath *)indexPath
{
    // Return the image size to GreedoCollectionViewLayout
    if (indexPath.item < self.imageDataSource.count) {
        UIImage *image = [self.imageDataSource objectAtIndex:indexPath.item];
        if (image.size.width > 0 && image.size.height > 0) {
            return image.size;
        }
    }

    return CGSizeMake(0.1, 0.1);
}

#pragma mark - Lazy Loading

- (NSMutableArray *)imageDataSource
{
    if (!_imageDataSource) {
        _imageDataSource = [NSMutableArray array];
    }

    return _imageDataSource;
}

- (GreedoCollectionViewLayout *)collectionViewSizeCalculator
{
    if (!_collectionViewSizeCalculator) {
        _collectionViewSizeCalculator = [[GreedoCollectionViewLayout alloc] initWithCollectionView:self.collectionView];
        _collectionViewSizeCalculator.dataSource = self;
    }

    return _collectionViewSizeCalculator;
}

@end

//
//  GreedoCollectionViewLayout.h
//  500px
//  Copyright (c) 2015 500px. All rights reserved.
//

#import "GreedoCollectionViewLayout.h"
#import "GreedoSizeCalculator.h"

@interface GreedoCollectionViewLayout () <GreedoSizeCalculatorDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) GreedoSizeCalculator *greedo;

@end

@implementation GreedoCollectionViewLayout

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (self) {
        _collectionView = collectionView;
    }
    return self;
}

- (CGSize)sizeForPhotoAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat contentWidth  = self.collectionView.bounds.size.width;
    CGFloat interitemSpacing = 0.0;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    if (layout) {
        contentWidth -= (layout.sectionInset.left + layout.sectionInset.right);
        interitemSpacing = layout.minimumInteritemSpacing;
    }

    self.greedo.contentWidth = contentWidth;
    self.greedo.interItemSpacing = interitemSpacing;
    
    return [self.greedo sizeForPhotoAtIndexPath:indexPath];
}

- (void)clearCache
{
    [self.greedo clearCache];
}

- (void)clearCacheAfterIndexPath:(NSIndexPath *)indexPath
{
    [self.greedo clearCacheAfterIndexPath:indexPath];
}

- (CGFloat)rowMaximumHeight
{
    return self.greedo.rowMaximumHeight;
}

- (void)setRowMaximumHeight:(CGFloat)rowMaximumHeight
{
    self.greedo.rowMaximumHeight = rowMaximumHeight;
}

- (BOOL)fixedHeight
{
    return self.greedo.fixedHeight;
}

- (void)setFixedHeight:(BOOL)fixedHeight
{
    self.greedo.fixedHeight = fixedHeight;
}

- (CGSize)greedoSizeCalculator:(GreedoSizeCalculator *)layout originalImageSizeAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource greedoCollectionViewLayout:self originalImageSizeAtIndexPath:indexPath];
}

#pragma mark - Lazy Loading

- (GreedoSizeCalculator *)greedo
{
    if (!_greedo) {
        _greedo = [[GreedoSizeCalculator alloc] init];
        _greedo.rowMaximumHeight = 100;
        _greedo.fixedHeight = NO;
        _greedo.dataSource = self;
    }
    return _greedo;
}

@end
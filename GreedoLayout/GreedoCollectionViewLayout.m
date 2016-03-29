//
//  GreedoCollectionViewLayout.h
//  500px
//  Copyright (c) 2015 500px. All rights reserved.
//

#import "GreedoCollectionViewLayout.h"

@interface GreedoCollectionViewLayout ()

@property (nonatomic, strong) NSMutableDictionary *sizeCache;
@property (nonatomic, strong) NSMutableArray *leftOvers;
@property (nonatomic, strong) NSIndexPath *lastIndexPathAdded;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GreedoCollectionViewLayout

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (self) {
        _collectionView = collectionView;
        _rowMaximumHeight = 100;
        _fixedHeight = YES;
    }
    return self;
}

- (CGSize)sizeForPhotoAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.sizeCache[indexPath]) {
        self.lastIndexPathAdded = indexPath;
        [self computeSizesAtIndexPath:indexPath];
    }
    CGSize size = [[self.sizeCache objectForKey:indexPath] CGSizeValue];
    if (size.width < 0.0 || size.height < 0.0) {
        size = CGSizeZero;
    }
    return size;
}

- (void)clearCache
{
    [self.sizeCache removeAllObjects];
}

- (void)clearCacheAfterIndexPath:(NSIndexPath *)indexPath
{
    // Remove the indexPath
    [self.sizeCache removeObjectForKey:indexPath];
    
    // Remove the indexPath for anything after
    for (NSIndexPath *existingIndexPath in [self.sizeCache allKeys]) {
        if ([indexPath compare:existingIndexPath] == NSOrderedDescending) {
            [self.sizeCache removeObjectForKey:existingIndexPath];
        }
    }
}

#pragma mark - Private methods

- (void)computeSizesAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat contentWidth  = self.collectionView.bounds.size.width;
    CGFloat interitemSpacing = 0.0;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    if (layout) {
        contentWidth -= (layout.sectionInset.left + layout.sectionInset.right);
        interitemSpacing = layout.minimumInteritemSpacing;
    }

    CGSize  photoSize     = [self.dataSource greedoCollectionViewLayout:self originalImageSizeAtIndexPath:indexPath];
    
    [self.leftOvers addObject:[NSValue valueWithCGSize:photoSize]];
    
    if (photoSize.width < 1 || photoSize.height < 1) {
        // Photo with no height or width
        photoSize.width  = self.rowMaximumHeight;
        photoSize.height = self.rowMaximumHeight;
    }
    
    BOOL enoughContentForTheRow = NO;
    CGFloat rowHeight = self.rowMaximumHeight;
    
    CGFloat totalAspectRatio = 0.0;
    
    for (NSValue *leftOver in self.leftOvers) {
        CGSize leftOverSize = [leftOver CGSizeValue];
        totalAspectRatio += (leftOverSize.width / leftOverSize.height);
    }
    
    contentWidth -= (self.leftOvers.count - 1) * self.cellPadding;

    rowHeight = contentWidth / totalAspectRatio;
    enoughContentForTheRow = rowHeight < self.rowMaximumHeight;
    
    if (enoughContentForTheRow) {
        // The line is full!
        CGFloat availableSpace = contentWidth;
        
        for (NSValue *leftOver in self.leftOvers) {
        
            CGSize leftOverSize = [leftOver CGSizeValue];

            CGFloat newWidth = ceil((rowHeight * leftOverSize.width) / leftOverSize.height);
            newWidth = MIN(availableSpace, newWidth);
            
            // Add the size in the cache
            [self.sizeCache setObject:[NSValue valueWithCGSize:CGSizeMake(newWidth, rowHeight)] forKey:self.lastIndexPathAdded];
            
            availableSpace = availableSpace - newWidth - interitemSpacing;
            
            // We need to keep track of the last index path added
            self.lastIndexPathAdded = [NSIndexPath indexPathForItem:(self.lastIndexPathAdded.item + 1) inSection:self.lastIndexPathAdded.section];
        }
        
        [self.leftOvers removeAllObjects];
    } else {
        // The line is not full, let's ask the next photo and try to fill up the line
        [self computeSizesAtIndexPath:[NSIndexPath indexPathForItem:(indexPath.item + 1) inSection:indexPath.section]];
    }
}

#pragma mark - Custom accessors

- (NSMutableArray *)leftOvers
{
    if (!_leftOvers) {
        _leftOvers = [NSMutableArray array];
    }
    
    return _leftOvers;
}

- (NSMutableDictionary *)sizeCache
{
    if (!_sizeCache) {
        _sizeCache = [NSMutableDictionary dictionary];
    }
    return _sizeCache;
}

@end
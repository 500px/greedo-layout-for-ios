//
//  GreedoSizeCalculator.h
//  Pods
//
//  Created by David Charlec on 2016-04-21.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol GreedoSizeCalculatorDataSource;

@interface GreedoSizeCalculator : NSObject

@property (nonatomic, weak) id <GreedoSizeCalculatorDataSource> dataSource;
@property CGFloat rowMaximumHeight;
@property BOOL fixedHeight;
@property CGFloat contentWidth;
@property CGFloat interItemSpacing;

- (CGSize)sizeForPhotoAtIndexPath:(NSIndexPath *)indexPath;
- (void)clearCache;
- (void)clearCacheAfterIndexPath:(NSIndexPath *)indexPath;

@end

@protocol GreedoSizeCalculatorDataSource <NSObject>
- (CGSize)greedoSizeCalculator:(GreedoSizeCalculator *)layout originalImageSizeAtIndexPath:(NSIndexPath *)indexPath;
@end
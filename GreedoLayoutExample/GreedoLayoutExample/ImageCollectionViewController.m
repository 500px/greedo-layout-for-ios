//
//  PhotoCollectionViewController.m
//  GreedoLayoutExample
//
//  Created by Denny Hoang on 2016-02-10.
//  Copyright © 2016 500px. All rights reserved.
//

#import "ImageCollectionViewController.h"
#import "GreedoCollectionViewLayout.h"

static NSString * const kImageCollectionViewCellIdentifier = @"ImageCell"

@interface ImageCollectionViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) GreedoCollectionViewLayout *collectionViewSizeCalculator;

@end

@implementation ImageCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (GreedoCollectionViewLayout *)collectionViewSizeCalculator {
    if (!_collectionViewSizeCalculator) {
        _collectionViewSizeCalculator = [[GreedoCollectionViewLayout alloc] initWithCollectionView:self.collectionView];
        _collectionViewSizeCalculator.dataSource = self;
    }

    return _collectionViewSizeCalculator;
}

@end

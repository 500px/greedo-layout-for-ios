//
//  ImageConstantHeightCollectionViewController.m
//  GreedoLayoutExample
//
//  Created by Denny Hoang on 2016-04-07.
//  Copyright © 2016 500px. All rights reserved.
//

#import "ImageConstantHeightCollectionViewController.h"

@interface ImageConstantHeightCollectionViewController ()

@end

@implementation ImageConstantHeightCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    /* The fixed height implementation is the same as the variable height version
     The only change required is that the fixedHeight boolean be set to true (YES)
     An optional parameter would be setting the rowMaximumHeight to a desired height
    */
    
    self.collectionViewSizeCalculator.fixedHeight = YES;
}

@end

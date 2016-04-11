//
//  HomeTableViewController.m
//  GreedoLayoutExample
//
//  Created by Denny Hoang on 2016-04-11.
//  Copyright © 2016 500px. All rights reserved.
//

#import "HomeTableViewController.h"
#import "ImageCollectionViewController.h"

@implementation HomeTableViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"fixedHeight"]) {
        ((ImageCollectionViewController *)segue.destinationViewController).hasFixedHeight = YES;
    }
}

@end

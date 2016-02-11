//
//  UIColor+Random.m
//  GreedoLayoutExample
//
//  Created by Denny Hoang on 2016-02-11.
//  Copyright © 2016 500px. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)

+ (UIColor *)randomColor
{
    int randomNum = rand() % 4;

    if (randomNum == 0) {
        return [UIColor colorWithRed:170.0/255.0 green:57.0/255.0 blue:57.0/255.0 alpha:1.0];
    } else if (randomNum == 1) {
        return [UIColor colorWithRed:170/255.0 green:108.0/255.0 blue:57.0/255.0 alpha:1.0];
    } else if (randomNum == 2) {
        return [UIColor colorWithRed:34.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
    }

    return [UIColor colorWithRed:45.0/255.0 green:136.0/255.0 blue:45.0/255.0 alpha:1.0];
}

@end

//
//  UIImage+Random.m
//  GreedoLayoutExample
//
//  Created by Denny Hoang on 2016-02-11.
//  Copyright © 2016 500px. All rights reserved.
//

#import "UIImage+Random.h"
#import "UIColor+Random.h"

@implementation UIImage (Random)

+ (UIImage *)randomImage
{
    int randHeight = rand() % 200 + 50;
    int randWidth = rand() % 200 + 50;
    CGRect randomRect = CGRectMake(0, 0, randWidth, randHeight);

    UIGraphicsBeginImageContext(randomRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor randomColor] CGColor]);
    CGContextFillRect(context, randomRect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

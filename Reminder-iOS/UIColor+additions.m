//
//  UIColor+additions.m
//  RAMCollectionViewFlemishBondLayoutDemo
//
//  Created by Rafael Aguilar Martín on 20/10/13.
//  Copyright (c) 2013 Rafael Aguilar Martín. All rights reserved.
//

#import "UIColor+additions.h"

@implementation UIColor (additions)

+ (UIColor *)randomColor
{
    NSMutableArray* colorsArray = [[NSMutableArray alloc] init];
    UIColor *color = [UIColor colorWithRed:(74/255.0) green:(80/255.0) blue:(96/255.0) alpha:1.0];
    [colorsArray addObject:color];
    
    color = [UIColor colorWithRed:(74/255.0) green:(80/255.0) blue:(96/255.0) alpha:1.0];
    [colorsArray addObject:color];
    color = [UIColor colorWithRed:(70/255.0) green:(182/255.0) blue:(201/255.0) alpha:1.0];
    [colorsArray addObject:color];
    color = [UIColor colorWithRed:(178/255.0) green:(210/255.0) blue:(30/255.0) alpha:1.0];
    [colorsArray addObject:color];
    color = [UIColor colorWithRed:(100/255.0) green:(98/255.0) blue:(99/255.0) alpha:1.0];
    [colorsArray addObject:color];
    color = [UIColor colorWithRed:(246/255.0) green:(91/255.0) blue:(76/255.0) alpha:1.0];
    [colorsArray addObject:color];
    color = [UIColor colorWithRed:(234/255.0) green:(181/255.0) blue:(38/255.0) alpha:1.0];
    [colorsArray addObject:color];
    color = [UIColor colorWithRed:(153/255.0) green:(96/255.0) blue:(234/255.0) alpha:1.0];
    [colorsArray addObject:color];
    color = [UIColor colorWithRed:(30/255.0) green:(120/255.0) blue:(177/255.0) alpha:1.0];
    [colorsArray addObject:color];

    color = [UIColor colorWithRed:(160/255.0) green:(190/255.0) blue:(144/255.0) alpha:1.0];
    [colorsArray addObject:color];
    
    color = [UIColor colorWithRed:(200/255.0) green:(88/255.0) blue:(85/255.0) alpha:1.0];
    [colorsArray addObject:color];
    color = [UIColor colorWithRed:(212/255.0) green:(186/255.0) blue:(156/255.0) alpha:1.0];
    [colorsArray addObject:color];
    
    
    
    
    return [colorsArray objectAtIndex:arc4random()%[colorsArray count]];
}

@end

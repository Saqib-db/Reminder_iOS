//
//  RAMCollectionViewCell.m
//  RAMCollectionViewFlemishBondLayoutDemo
//
//  Created by Rafael Aguilar Martín on 20/10/13.
//  Copyright (c) 2013 Rafael Aguilar Martín. All rights reserved.
//

#import "RAMCollectionViewCell.h"
#import "UIColor+additions.h"

@interface RAMCollectionViewCell ()
    

@end

@implementation RAMCollectionViewCell




- (id)initWithFrame:(CGRect)frame
{    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Setup
- (void)setup
{
    [self setupView];
    [self setupLabel];
}

- (void)setupView
{
    self.backgroundColor = [UIColor randomColor];
}

- (void)setupLabel
{
    
    
    float cellSize = self.frame.size.height/2;
    
    NSLog(@"Size for the image = %f * %f",cellSize , cellSize);
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-(cellSize+7))/2, (self.frame.size.height-(cellSize+7+25))/2, cellSize, cellSize)];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.imageView.center.x-(self.frame.size.width/2), self.imageView.frame.origin.y+cellSize, self.frame.size.width, 30)];
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:15];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.label.textAlignment = NSTextAlignmentCenter;

    self.imageView.image = [UIImage imageNamed:@"post_type_bubble_twitter"];
    
        
    //self.imageView.center = self.center;

    [self addSubview:self.label];
    [self addSubview:self.imageView];
    
    
    
   
    
    /*[self addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.imageView
                              attribute:NSLayoutAttributeCenterY
                              relatedBy:NSLayoutRelationEqual
                              toItem:self
                              attribute:NSLayoutAttributeCenterY
                              multiplier:1.0
                              constant:0.0]];*/
    

}

#pragma mark - Configure
- (void)configureCellWithIndexPath:(NSIndexPath *)indexPath
{
    self.label.text = [NSString stringWithFormat:@"Event %ld", (long)(indexPath.row + 1)];
}

@end

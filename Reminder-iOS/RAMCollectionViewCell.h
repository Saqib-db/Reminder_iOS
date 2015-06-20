//
//  RAMCollectionViewCell.h
//  RAMCollectionViewFlemishBondLayoutDemo
//
//  Created by Rafael Aguilar Martín on 20/10/13.
//  Copyright (c) 2013 Rafael Aguilar Martín. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RAMCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;




- (void)configureCellWithIndexPath:(NSIndexPath *)indexPath;

@end

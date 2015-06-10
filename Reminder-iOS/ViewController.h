//
//  ViewController.h
//  Reminder-iOS
//
//  Created by Arkhitech on 09/06/2015.
//  Copyright (c) 2015 saqib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAMCollectionViewFlemishBondLayout.h"


@interface ViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, RAMCollectionViewFlemishBondLayoutDelegate>
@property (nonatomic, strong) RAMCollectionViewFlemishBondLayout *collectionViewLayout;
@property (nonatomic, readonly) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *btn;

- (IBAction)btnAction:(id)sender;

@end


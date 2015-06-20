//
//  ViewController.h
//  Reminder-iOS
//
//  Created by Arkhitech on 09/06/2015.
//  Copyright (c) 2015 saqib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAMCollectionViewFlemishBondLayout.h"

#import "PopMenu.h"
#import "SKSplashView.h"

@interface ViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, RAMCollectionViewFlemishBondLayoutDelegate,SKSplashDelegate,UITabBarDelegate>
@property (nonatomic, strong) RAMCollectionViewFlemishBondLayout *collectionViewLayout;
@property (nonatomic, readonly) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, strong) PopMenu *popMenu;
@property (weak, nonatomic) IBOutlet UIButton *menuBtnBottom;
@property (strong, nonatomic) SKSplashView *splashView;
@property (strong, nonatomic) UIView *flashView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;



@property (strong,nonatomic) NSArray *events;


- (IBAction)btnAction:(id)sender;

@end


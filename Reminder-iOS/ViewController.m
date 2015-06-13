//
//  ViewController.m
//  Reminder-iOS
//
//  Created by Arkhitech on 09/06/2015.
//  Copyright (c) 2015 saqib. All rights reserved.
//

#import "ViewController.h"
#import "MenuButton.h"
#import "PopMenu.h"
#import "MenuItem.h"
#import "RAMCollectionViewFlemishBondLayoutAttributes.h"
#import "RAMCollectionViewFlemishBondLayout.h"
#import "RAMCollectionViewCell.h"
#import "RAMCollectionAuxView.h"
static NSString *const CellIdentifier = @"MyCell";
static NSString * const HeaderIdentifier = @"HeaderIdentifier";
static NSString * const FooterIdentifier = @"FooterIdentifier";


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - Setup
- (void)setup
{
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    //self.navigationController.navigationBar.translucent = NO;
    
    self.collectionViewLayout = [[RAMCollectionViewFlemishBondLayout alloc] init];
    self.collectionViewLayout.delegate = self;
    self.collectionViewLayout.numberOfElements = 3;
    self.collectionViewLayout.highlightedCellHeight = 150.f;
    self.collectionViewLayout.highlightedCellWidth = 200.f;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor blackColor];
    [collectionView registerClass:[RAMCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    [collectionView registerClass:[RAMCollectionAuxView class] forSupplementaryViewOfKind:RAMCollectionViewFlemishBondHeaderKind withReuseIdentifier:HeaderIdentifier];
    [collectionView registerClass:[RAMCollectionAuxView class] forSupplementaryViewOfKind:RAMCollectionViewFlemishBondFooterKind withReuseIdentifier:FooterIdentifier];
    
    self.view = collectionView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showMenu {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    
    MenuItem *menuItem = [MenuItem itemWithTitle:@"New Event" iconName:@"post_type_bubble_flickr"];
    menuItem.index = 0;
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Time Manager" iconName:@"post_type_bubble_googleplus" glowColor:[UIColor colorWithRed:0.840 green:0.264 blue:0.208 alpha:0.800]];
    menuItem.index = 1;
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Stop Watch" iconName:@"post_type_bubble_instagram" glowColor:[UIColor colorWithRed:0.232 green:0.442 blue:0.687 alpha:0.800]];
    menuItem.index = 2;
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Contacts" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.000 green:0.509 blue:0.687 alpha:0.800]];
    menuItem.index = 3;
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Calendar" iconName:@"post_type_bubble_youtube" glowColor:[UIColor colorWithRed:0.687 green:0.164 blue:0.246 alpha:0.800]];
    menuItem.index = 4;
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Important Evetns" iconName:@"post_type_bubble_facebook" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.800]];
    menuItem.index = 5;
    [items addObject:menuItem];
    
    if (!_popMenu) {
        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
        _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
    }
    if (_popMenu.isShowed) {
        [_popMenu dismissMenu];
        return;
    }
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        NSLog(@"%li",(long)selectedItem.index);
        if (selectedItem.index == 4) {
            [self performSegueWithIdentifier:@"HomeToCalendar" sender:self];
        }
    };
    
    [_popMenu showMenuAtView:self.view];
    
    //    [_popMenu showMenuAtView:self.view startPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds)) endPoint:CGPointMake(60, CGRectGetHeight(self.view.bounds))];
}


- (IBAction)btnAction:(id)sender {
    [self showMenu];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self btnAction:self];
}
- (void)gotoCalendar:(id)sender {
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RAMCollectionViewCell *cell;
    if(cell == nil){
        cell = (RAMCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        CGRect frameRect = cell.frame;
        frameRect.size.width -= 7;
        frameRect.size.height -= 7;
        cell.frame = frameRect;
    }
    
    
    
    [cell configureCellWithIndexPath:indexPath];
    
    
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionReusableView *titleView;
    
    if (kind == RAMCollectionViewFlemishBondHeaderKind) {
        titleView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeaderIdentifier forIndexPath:indexPath];
        ((RAMCollectionAuxView *)titleView).label.text = @"Header";
    } else if (kind == RAMCollectionViewFlemishBondFooterKind) {
        titleView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FooterIdentifier forIndexPath:indexPath];
        ((RAMCollectionAuxView *)titleView).label.text = @"Footer";
    }
    
    return titleView;
}

#pragma mark - RAMCollectionViewVunityLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(RAMCollectionViewFlemishBondLayout *)collectionViewLayout estimatedSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(RAMCollectionViewFlemishBondLayout *)collectionViewLayout estimatedSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), 0);
}

- (RAMCollectionViewFlemishBondLayoutGroupDirection)collectionView:(UICollectionView *)collectionView layout:(RAMCollectionViewFlemishBondLayout *)collectionViewLayout highlightedCellDirectionForGroup:(NSInteger)group atIndexPath:(NSIndexPath *)indexPath
{
    RAMCollectionViewFlemishBondLayoutGroupDirection direction;
    
    if (indexPath.row % 2) {
        direction = RAMCollectionViewFlemishBondLayoutGroupDirectionRight;
    } else {
        direction = RAMCollectionViewFlemishBondLayoutGroupDirectionLeft;
    }
    
    return direction;
}
@end

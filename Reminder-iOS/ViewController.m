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

- (IBAction)btnAction:(id)sender {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    
    MenuItem *menuItem = [[MenuItem alloc] initWithTitle:@"New Task" iconName:@"post_type_bubble_flickr" glowColor:[UIColor grayColor] index:0];
    
    [items addObject:menuItem];
    
    
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Time Manager" iconName:@"post_type_bubble_googleplus" glowColor:[UIColor colorWithRed:0.000 green:0.840 blue:0.000 alpha:1.000] index:0];
    
    [items addObject:menuItem];
    
    
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Stop Watch" iconName:@"post_type_bubble_instagram" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    
    [items addObject:menuItem];
    
    
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Twitter" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    
    [items addObject:menuItem];
    
    
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Youtube" iconName:@"post_type_bubble_youtube" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    
    [items addObject:menuItem];
    
    
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Facebook" iconName:@"post_type_bubble_facebook" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    
    [items addObject:menuItem];
    
    
    
    PopMenu *popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
    
    [popMenu showMenuAtView:self.view];
    
    
    if (!popMenu) {
        popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
        popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
    }
    if (popMenu.isShowed) {
        return;
    }
    popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        NSLog(@" selected index is:%d",(int)selectedItem.index);
    };
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self btnAction:self];
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

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
#import "SKSplashIcon.h"
#import "Event.h"
#import "DetailViewController.h"
#import "ASFSharedViewTransition.h"


static NSString *const CellIdentifier = @"MyCell";
static NSString * const HeaderIdentifier = @"HeaderIdentifier";
static NSString * const FooterIdentifier = @"FooterIdentifier";


@interface ViewController (){
    int count;
    UICollectionView *collectionView;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"start_from_scratch"] != nil){
        [self setup];
    }
    else {
        [defaults setObject:@"ON" forKey:@"start_from_scratch"];
        [self twitterSplash];
    }
    [defaults synchronize];
    /*for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }*/
    //[self setup];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    self.events = [Event getAll];
}
#pragma mark - Setup
- (void)setup
{
    self.navigationController.navigationBarHidden = YES;

    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    //self.navigationController.navigationBar.translucent = NO;
    
    self.collectionViewLayout = [[RAMCollectionViewFlemishBondLayout alloc] init];
    self.collectionViewLayout.delegate = self;
    self.collectionViewLayout.numberOfElements = 3;
    self.collectionViewLayout.highlightedCellHeight = (self.view.frame.size.width-(self.view.frame.size.width/2));//200.f;
    self.collectionViewLayout.highlightedCellWidth = (self.view.frame.size.width-(self.view.frame.size.width/2.7));//   200.f;
    
     collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
    
    //self.mainCollectionView.collectionViewLayout = self.collectionViewLayout;
    
    //UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 400, 400) collectionViewLayout:self.collectionViewLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor blackColor];
    [collectionView registerClass:[RAMCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    [collectionView registerClass:[RAMCollectionAuxView class] forSupplementaryViewOfKind:RAMCollectionViewFlemishBondHeaderKind withReuseIdentifier:HeaderIdentifier];
    [collectionView registerClass:[RAMCollectionAuxView class] forSupplementaryViewOfKind:RAMCollectionViewFlemishBondFooterKind withReuseIdentifier:FooterIdentifier];
    
    
    //[collectionView addSubview:self.bottomView];
    

    collectionView.backgroundColor = [UIColor blackColor];
    self.view = collectionView;

    [self.view bringSubviewToFront:self.bottomView];
    
    self.tabBarController.delegate = self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showMenu {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    
    MenuItem *menuItem = [MenuItem itemWithTitle:@"New Event" iconName:@"menu_icon-new-event"];
    menuItem.index = 0;
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Time Manager" iconName:@"menu_icon-time-manager" glowColor:[UIColor colorWithRed:0.840 green:0.264 blue:0.208 alpha:0.800]];
    menuItem.index = 1;
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Stop Watch" iconName:@"menu_icon-stop-watch" glowColor:[UIColor colorWithRed:0.232 green:0.442 blue:0.687 alpha:0.800]];
    menuItem.index = 2;
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Contacts" iconName:@"menu_icon-contacts" glowColor:[UIColor colorWithRed:0.000 green:0.509 blue:0.687 alpha:0.800]];
    menuItem.index = 3;
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Calendar" iconName:@"menu_icon-calendar" glowColor:[UIColor colorWithRed:0.687 green:0.164 blue:0.246 alpha:0.800]];
    menuItem.index = 4;
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Important Evetns" iconName:@"menu_icon-important-event" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.800]];
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
        else if (selectedItem.index == 0){
            [self performSegueWithIdentifier:@"HomeToNew" sender:self];
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
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.events.count;
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
    Event *event = self.events[indexPath.row];
    cell.label.text = event.title;
    
    
    
    //[cell configureCellWithIndexPath:indexPath];
    
    /*if (indexPath.row == 0 && count != 1) {
        [self blinkTime:cell];
        cell.backgroundColor = [UIColor orangeColor];
    }
    else{
        NSLog(@"row is : %i",(int)indexPath.row);
    }*/
    
    
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"View Clicked = %i",(int)indexPath.row);
    [self performSegueWithIdentifier:@"HomeToDetailsEvents" sender:self];

    
}

- (void) twitterSplash
{
    //Setting the background
    /*UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [UIImage imageNamed:@"twitter background.png"];
    [self.view addSubview:imageView];*/
    //Twitter style splash
    self.navigationController.navigationBarHidden = YES;
    SKSplashIcon *twitterSplashIcon = [[SKSplashIcon alloc] initWithImage:[UIImage imageNamed:@"twitter_icon.png"] animationType:SKIconAnimationTypeBounce];
    UIColor *twitterColor = [UIColor colorWithRed:0.25098 green:0.6 blue:1.0 alpha:1.0];
    _splashView = [[SKSplashView alloc] initWithSplashIcon:twitterSplashIcon backgroundColor:twitterColor animationType:SKSplashAnimationTypeNone];
    _splashView.delegate = self; //Optional -> if you want to receive updates on animation beginning/end
    _splashView.animationDuration = 1; //Optional -> set animation duration. Default: 1s
    [self.view addSubview:_splashView];
    [_splashView startAnimation];
}
#pragma mark - Delegate methods

- (void) splashView:(SKSplashView *)splashView didBeginAnimatingWithDuration:(float)duration
{
    NSLog(@"Started animating from delegate");
    //To start activity animation when splash animation starts
    //[_indicatorView startAnimating];
}

- (void) splashViewDidEndAnimating:(SKSplashView *)splashView
{
    NSLog(@"Stopped animating from delegate");
    //To stop activity animation when splash animation ends
    //[_indicatorView stopAnimating];
    [self setup];
}
-(void)flashView:(UIView *)view {
    NSLog(@"called");
    count = 1;
    self.flashView = [[UIView alloc] initWithFrame:view.frame];
    self.flashView.backgroundColor = [UIColor whiteColor];
    [view addSubview:self.flashView];
    [self.flashView setAlpha:0];
    
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.flashView setAlpha:0.7];
                     }
                     completion:^(BOOL finished){
                         [self.flashView setAlpha:0];
                         [UIView animateWithDuration:0.3
                                               delay:0.2
                                             options: UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              [self.flashView setAlpha:0.7];
                                          }
                                          completion:^(BOOL finished){
                                              [self.flashView setAlpha:0];
                                          }];
                     }];
}
-(void)blinkTime:(UIView *)view{
    if (count != 1) {
        [self performSelector:@selector(flashView:) withObject:view afterDelay:5.0f];
    }
}
- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController
{
    [self showMenu];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
        // Get the selected item index path
        NSIndexPath *selectedIndexPath = [[collectionView indexPathsForSelectedItems] firstObject];
        
        // Set the thing on the view controller we're about to show
        if (selectedIndexPath != nil) {
            DetailViewController *detailVC = segue.destinationViewController;
            //detailVC.image = self.arrImages[selectedIndexPath.row];
        }
    }
}
#pragma mark - ASFSharedViewTransitionDataSource

- (UIView *)sharedView
{
    return [collectionView cellForItemAtIndexPath:[[collectionView indexPathsForSelectedItems] firstObject]];
}

@end

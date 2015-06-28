//
//  DetailViewController.m
//  Reminder-iOS
//
//  Created by saqib on 6/21/15.
//  Copyright (c) 2015 saqib. All rights reserved.
//

#import "DetailViewController.h"
#import "ASFSharedViewTransition.h"



@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.imageView.image = [UIImage imageNamed:self.event.icon];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.eventBGview.backgroundColor = self.color;
    self.navigationController.navigationBar.barTintColor = self.color;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.eventTitleText.text = self.event.title;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    

     
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - ASFSharedViewTransitionDataSource

- (UIView *)sharedView
{
    return _imageView;
}
- (IBAction)editBtnAction:(id)sender {
    [self showUnderDevelopement];
}

- (IBAction)deleteBtnAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete"
                                                    message:@"Do You Want to Delete the Selected Event?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 1) {
        self.event.destroy;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void)showUnderDevelopement{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Under Developement"
                                                    message:@"The page or service is still under developement."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil,nil];
    [alert show];
}
@end

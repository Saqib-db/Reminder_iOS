//
//  DetailViewController.h
//  Reminder-iOS
//
//  Created by saqib on 6/21/15.
//  Copyright (c) 2015 saqib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASFSharedViewTransition.h"
#import "Event.h"

@interface DetailViewController : UIViewController <ASFSharedViewTransitionDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) UIImage *image;
@property (strong,nonatomic) Event *event;
@property (strong,nonatomic) UIColor *color;
@property (weak, nonatomic) IBOutlet UIView *eventBGview;



@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UILabel *eventTitleText;




- (IBAction)editBtnAction:(id)sender;

- (IBAction)deleteBtnAction:(id)sender;

@end

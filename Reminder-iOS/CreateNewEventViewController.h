//
//  CreateNewEventViewController.h
//  Reminder-iOS
//
//  Created by saqib on 6/21/15.
//  Copyright (c) 2015 saqib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateNewEventViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *homeBtn;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *subTitleText;
@property (weak, nonatomic) IBOutlet UITextField *descriptionText;
@property (weak, nonatomic) IBOutlet UITextField *timeText;
@property (weak, nonatomic) IBOutlet UITextField *dateText;
@property (weak, nonatomic) IBOutlet UITextField *iconImage;
@property (weak, nonatomic) IBOutlet UITextField *eventImage;
@property (weak, nonatomic) IBOutlet UIButton *createBtn;

- (IBAction)homeBtnAction:(id)sender;
- (IBAction)createBtnAction:(id)sender;
@end

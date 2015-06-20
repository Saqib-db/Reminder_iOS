//
//  CreateNewEventViewController.m
//  Reminder-iOS
//
//  Created by saqib on 6/21/15.
//  Copyright (c) 2015 saqib. All rights reserved.
//

#import "CreateNewEventViewController.h"
#import "Event.h"

@interface CreateNewEventViewController ()

@end

@implementation CreateNewEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)homeBtnAction:(id)sender {
    [self performSegueWithIdentifier:@"CreateNewToHome" sender:self];

}

- (IBAction)createBtnAction:(id)sender {
    if (self.titleText.text != nil && ![self.titleText.text isEqualToString:@""]) {
        Event *event = [[Event alloc] init];
        event.title = self.titleText.text;
        event.subTitle = self.subTitleText.text;
        event.descriptionText = self.descriptionText.text;
        event.time = self.timeText.text;
        event.date = self.dateText.text;
        event.icon = self.iconImage.text;
        event.image = self.eventImage.text;
        if ([event saveToDb]) {
            [self performSegueWithIdentifier:@"CreateNewToHome" sender:self];
        }
        
    }
    else{
        NSLog(@"Empty insertion not allowed");
    }
    
    
}
@end

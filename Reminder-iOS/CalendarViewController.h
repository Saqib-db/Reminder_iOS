//
//  CalendarViewController.h
//  Reminder-iOS
//
//  Created by saqib on 6/12/15.
//  Copyright (c) 2015 saqib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar.h>

@interface CalendarViewController : UIViewController<JTCalendarDataSource>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTCalendarContentView *calendarContentView;

@property (strong, nonatomic) JTCalendar *calendar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;


- (IBAction)backAction:(id)sender;
- (IBAction)didGoTodayTouch;

- (IBAction)didChangeModeTouch;
@end

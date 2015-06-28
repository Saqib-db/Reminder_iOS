//
//  TimeManagerViewController.h
//  Reminder-iOS
//
//  Created by saqib on 6/28/15.
//  Copyright (c) 2015 saqib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Example2PieView.h"
#import <JTCalendar.h>

@interface TimeManagerViewController : UIViewController<JTCalendarDataSource>
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTCalendarContentView *calendarContentView;
@property (strong, nonatomic) JTCalendar *calendar;


@property (nonatomic, weak) IBOutlet Example2PieView* pieView;

@property (nonatomic, weak) IBOutlet Example2PieView* pieView2;

@end

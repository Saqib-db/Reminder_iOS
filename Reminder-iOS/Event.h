//
//  Event.h
//  Reminder-iOS
//
//  Created by saqib on 6/20/15.
//  Copyright (c) 2015 saqib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReminderDatabase.h"


@interface Event : ReminderDatabase


@property int eventId;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *subTitle;
@property (strong,nonatomic) NSString *descriptionText;
@property (strong,nonatomic) NSString *time;
@property (strong,nonatomic) NSString *date;
@property (strong,nonatomic) NSString *icon;
@property (strong,nonatomic) NSString *image;


-(id) initWithId:(int)_eventId andTitle:(NSString*)_title andSubTitle:(NSString*)_subTitle andDescriptionText:(NSString*)_descriptionText andTime:(NSString*)_time andDate:(NSString*)_date andIcon:(NSString*)_icon andImage:(NSString*)_image;
+(NSArray*) getAll;
-(BOOL) saveToDb ;
+(Event*) findByeventId:(int) eventId;

@end

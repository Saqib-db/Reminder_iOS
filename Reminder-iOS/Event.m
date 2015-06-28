//
//  Event.m
//  Reminder-iOS
//
//  Created by saqib on 6/20/15.
//  Copyright (c) 2015 saqib. All rights reserved.
//

#import "Event.h"

@implementation Event
@synthesize eventId, title, subTitle, descriptionText, time, date, icon, image;


-(id) initWithId:(int)_eventId andTitle:(NSString*)_title andSubTitle:(NSString*)_subTitle andDescriptionText:(NSString*)_descriptionText andTime:(NSString*)_time andDate:(NSString*)_date andIcon:(NSString*)_icon andImage:(NSString*)_image{
    if ((self = [super init])) {
        self.eventId = _eventId;
        self.title = _title;
        self.subTitle = _subTitle;
        self.descriptionText = _descriptionText;
        self.time = _time;
        self.date = _date;
        self.icon = _icon;
        self.image = _image;
        }
    return self;
}


+(Event*) eventFromStatement:(sqlite3_stmt*) statement {
    int eventtId = sqlite3_column_int(statement, 0);
    NSString* title= [NSString stringWithUTF8String:(char*) sqlite3_column_text(statement, 1)];
    NSString* subTitle= [NSString stringWithUTF8String:(char*) sqlite3_column_text(statement, 2)];
    NSString* description= [NSString stringWithUTF8String:(char*) sqlite3_column_text(statement, 3)];
    NSString* time= [NSString stringWithUTF8String:(char*) sqlite3_column_text(statement, 4)];
    NSString* date= [NSString stringWithUTF8String:(char*) sqlite3_column_text(statement, 5)];
    NSString* icon= [NSString stringWithUTF8String:(char*) sqlite3_column_text(statement, 6)];
    NSString* image= [NSString stringWithUTF8String:(char*) sqlite3_column_text(statement, 7)];
    Event *event = [[Event alloc] initWithId:eventtId andTitle:title andSubTitle:subTitle andDescriptionText:description andTime:time andDate:date andIcon:icon andImage:image];
    
    return event;
}

+(NSArray*) getAll{
    __block NSMutableArray *events = [[NSMutableArray alloc] init];
    NSString *query = [NSString stringWithFormat:@"SELECT Event_Id, Title, SubTitle, Description, Time, Date, Icon, Image FROM Events"];
    [self selectDataForQuery:query withResultBlock:^int(sqlite3_stmt *statement) {
        Event *event;
        while (sqlite3_step(statement) == SQLITE_ROW) {
            event = [Event eventFromStatement:statement];
            
            [events addObject:event];
            
            
        }
        return SQLITE_OK;
    }];
    return events;
}

-(BOOL) saveToDb {
    if(self.eventId > 0) {
        Event* event = [Event findByeventId:self.eventId];
        
        if(event == nil) {
            NSString* query = [NSString stringWithFormat:@"INSERT INTO Events (Event_Id, Title, SubTitle, Description, Time, Date, Icon, Image) VALUES ('%lu','%@','%@','%@','%@','%@','%@','%@')", (unsigned long)self.eventId, self.title, self.subTitle, self.descriptionText, self.time, self.date, self.icon, self.image];
            return [Event insertDataForQuery:query] == SQLITE_DONE;
        } else {
            NSString* query = [NSString stringWithFormat:@"UPDATE Events SET Title = '%@', SubTitle = '%@', Description = '%@', Time = '%@', Date = '%@', Icon = '%@',Image = '%@' WHERE Event_Id = '%i'",  self.title, self.subTitle, self.descriptionText, self.time, self.date, self.icon, self.image, self.eventId];
            return [Event updateDataForQuery:query] == SQLITE_DONE;
        }
    } else {
        NSString* query = [NSString stringWithFormat:@"INSERT INTO Events (Title, SubTitle, Description, Time, Date, Icon, Image) VALUES ('%@','%@','%@','%@','%@','%@','%@')",self.title, self.subTitle, self.descriptionText, self.time, self.date, self.icon, self.image];
        int rc = [Event insertDataForQuery:query withBlock:^(NSInteger rowid) {
            self.eventId = (int)rowid;
        }];
        
        return rc == SQLITE_DONE;
    }
}

+(Event*) findByeventId:(int) eventId{
    __block Event* event;
    NSString* query = [NSString stringWithFormat:@"SELECT Event_Id, Title, SubTitle, Description, Time, Date, Icon, Image FROM Events WHERE Event_Id = %i", eventId];
    [self selectDataForQuery:query withResultBlock:^int(sqlite3_stmt *statement) {
        int rc;
        if((rc=sqlite3_step(statement)) == SQLITE_ROW){
            event = [Event eventFromStatement:statement];
        }
        return rc;
    }];
    return event;
}

-(BOOL) destroy{
    return [Event updateDataForQuery:[NSString stringWithFormat: @"DELETE FROM Events WHERE Event_Id = %i", self.eventId]];
}

@end

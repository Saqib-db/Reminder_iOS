
#import <Foundation/Foundation.h>
#import <sqlite3.h>
//#import <CocoaLumberjack/CocoaLumberjack.h>

#import <UIKit/UIProgressView.h>
#import <UIKit/UILabel.h>

typedef int(^SelectDataCallbackBlock)(sqlite3_stmt *statement);
typedef void(^InsertDataCallbackBlock)(NSInteger rowid);

@interface ReminderDatabase : NSObject

+(sqlite3*) connection;
+(void) checkAndCreateDatabase;
+(int) selectDataForQuery: (NSString*) query withResultBlock:(SelectDataCallbackBlock)block;
//should return ID of inserted data
+(int) insertDataForQuery: (NSString*) query;
+(int) insertDataForQuery: (NSString*) query withBlock:(InsertDataCallbackBlock)block;

+(int) updateDataForQuery: (NSString*) query;
+(void) close;
-(NSString*) escapeString:(NSString*) str;
+(void) incrementProgress:(UIProgressView*) progressView by:(float) inc progressLabel:(UILabel*) percentageLabel;

@end



#import "ReminderDatabase.h"
@implementation ReminderDatabase

static sqlite3* _connection;


- (id)init {
    if ((self = [super init])) {
        //do some initialization here if required
    }
    return self;
}

+(NSString *) getDocumentDirectory{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

+(void) checkAndCreateDatabase{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *databasePath = [[self getDocumentDirectory] stringByAppendingPathComponent:@"bossched.sqlite"];
    success = [fileManager fileExistsAtPath:databasePath];
    if(success) {
        NSLog(@"database exists: %@", databasePath);
        return;}
    else{
        NSLog(@"database doesn't exist, copying: %@", databasePath);
        NSError* error;
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"bossched.sqlite"];
        [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:&error];
        if(error != nil) {
            NSLog(@"Got an error: %@", error);
        }
    }
}

+(sqlite3*) connection {
    if(_connection == nil) {
        NSString *sqLiteDb = [[self getDocumentDirectory] stringByAppendingPathComponent:@"bossched.sqlite"];
        
        int rc;
        if ((rc=sqlite3_open([sqLiteDb UTF8String], &_connection)) != SQLITE_OK) {
            //try creating the database
            NSLog(@"Failed to open database!");
        }
    }
    return _connection;
}

+(int) selectDataForQuery: (NSString*) query withResultBlock:(SelectDataCallbackBlock)block {
    sqlite3_stmt *statement;
    __block int rc;
    NSLog(@"Executing query: %@", query);
    if ((rc = sqlite3_prepare_v2(self.connection, [query UTF8String], -1, &statement, nil))
        == SQLITE_OK) {
        rc = block(statement);
    }
    sqlite3_finalize(statement);
    [self close];
    return rc;
}

+(int) updateDataForQuery: (NSString*) query {
    sqlite3_stmt *statement;
    const char *update_stmt = [query UTF8String];
    sqlite3_prepare_v2(self.connection, update_stmt,
                       -1, &statement, NULL);
    int rc;
    if ((rc=sqlite3_step(statement)) == SQLITE_DONE) {
        NSLog(@"Updated Query: %@", query);
    } else {
        NSLog(@"FAILED to UPDATE: %d Query: %@", rc, query);
    }
    sqlite3_finalize(statement);
    [self close];
    return rc;
}

+(int) insertDataForQuery: (NSString*) query withBlock:(InsertDataCallbackBlock)block {
    sqlite3_stmt *statement;
    const char *insert_stmt = [query UTF8String];
    sqlite3_prepare_v2(self.connection, insert_stmt,
                       -1, &statement, NULL);
    int rc;
    if ((rc = sqlite3_step(statement)) == SQLITE_DONE) {
        NSLog(@"Inserted Query: %@", query);
        
    } else {
        NSLog(@"FAILED to INSERT Query: %@", query);
        
    }
    sqlite3_finalize(statement);
    
    if(rc == SQLITE_DONE){
        block(sqlite3_last_insert_rowid([self connection]));
    }
    [self close];
    return rc;
    
}

+(int) insertDataForQuery: (NSString*) query {
    sqlite3_stmt *statement;
    const char *insert_stmt = [query UTF8String];
    sqlite3_prepare_v2(self.connection, insert_stmt,
                       -1, &statement, NULL);
    int rc;
    if ((rc = sqlite3_step(statement)) == SQLITE_DONE) {
        NSLog(@"Inserted Query: %@", query);
        
    } else {
        NSLog(@"FAILED to INSERT Query: %@", query);
        
    }
    sqlite3_finalize(statement);
    [self close];
    return rc;
}

+(void) close {
    if (_connection != nil) {
        sqlite3_close(_connection);
        _connection = nil;
    }
}

- (void)dealloc {
    //sqlite3_close(_connection);
    //[super dealloc];
}

-(NSString*) escapeString:(NSString*) str {
    return [str stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}

+(void) incrementProgress:(UIProgressView*) progressView by:(float) inc progressLabel:(UILabel*) percentageLabel {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        float currentProgress = progressView.progress + inc;
        if(currentProgress >= 0.98){
            percentageLabel.text = @"98%";
            [progressView setProgress:0.98];
        }else{
            percentageLabel.text = [NSString stringWithFormat:@"%.0f%%",currentProgress*100];
            [progressView setProgress:currentProgress];
        }
        NSLog(@"%f",currentProgress);
       // [progressView setProgress:currentProgress];
    }];
}

@end

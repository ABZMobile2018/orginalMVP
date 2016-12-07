//
//  DataMigrator.m
//  Airbrowz

#import "DataMigrator.h"
#import "AirbrowzCommons.h"

@implementation DataMigrator

static const int systemDataVersion = 2; // Current data version

+ (void) migrateDataIfNecessary {
    int currentDataVersion;
    
    // If version wasn't stored, it's probably their first time installation or in system where dataVersion wasn't available
    if (! [[NSUserDefaults standardUserDefaults] objectForKey: USER_DEFAULT_DATA_VERSION]) {
        currentDataVersion = 1;
    }
    else {
        currentDataVersion = [[[NSUserDefaults standardUserDefaults] objectForKey: USER_DEFAULT_DATA_VERSION] intValue];
    }
    
    
    NSLog(@"Data Migrator: Current Data Version: %d", currentDataVersion);
    
    // Note: Don't use break in this switch so that it updates incrementally
    switch (currentDataVersion) {
        case 1:
            [DataMigrator migrateVersion1To2];
    }
    
}

/*
 * New Features:
 *      - New Categories
 *      - Stores Proximity Settings 
 *      - Data versioning system
 */
+(void) migrateVersion1To2 {
    NSLog(@"Data Migrator: Migrating Data: 1->2");
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    // Store Categories Selection
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    for (int i = 0 ; i <= Misc ; i++) { // Misc is the last item
        [categories addObject: @YES];
    }
    [standardDefaults setObject:categories forKey:USER_DEFAULT_CATEGORY_KEY];
    
    // Store Proximity Selection
    [standardDefaults setObject: @5000.0f forKey:USER_DEFAULT_PROXIMITY_KEY];
    
    // Store New Version#
    [standardDefaults setObject:@2 forKey:USER_DEFAULT_DATA_VERSION];
    
    [standardDefaults synchronize];
    
    
    
}
@end

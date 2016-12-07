//
//  DataMigrator.h
//  Airbrowz

#import <Foundation/Foundation.h>

@interface DataMigrator : NSObject

+ (void) migrateDataIfNecessary;
@end

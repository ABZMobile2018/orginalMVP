//
//  DataMigrator.h
//  Airbrowz
//
//  Created by Denny on 2015-11-03.
//  Copyright © 2015 Kiwi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataMigrator : NSObject

+ (void) migrateDataIfNecessary;
@end

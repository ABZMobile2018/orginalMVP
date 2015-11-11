//
//  AirbrowzCommons.m
//  Airbrowz
//
//  Created by Denny on 2015-10-27.
//  Copyright © 2015 Kiwi. All rights reserved.
//

#import "AirbrowzCommons.h"

@implementation AirbrowzCommons

+ (NSString *) stringForHoursFormat: (NSString *) hours {
    
    if ([@"00:00" isEqualToString:hours]) {
        return @"Midnight";
    }
    
    NSMutableString *result = [[NSMutableString alloc] init];
    
    NSArray *splitted = [hours componentsSeparatedByString:@":"];
    
    int hr = [[splitted objectAtIndex:0] intValue];
    if (hr < 12) {
        [result appendString:[NSString stringWithFormat:@"%d:%@ AM", hr, [splitted objectAtIndex:1]]];
    }
    
    else {
        [result appendString:[NSString stringWithFormat:@"%d:%@ PM", hr, [splitted objectAtIndex:1]]];
    }
    
    
    return result;
}

+ (NSString *) stringForExpirayLabel : (NSDate *) expiry{
    NSDate *currentDate = [[NSDate alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get conversion to months, days, hours, minutes
    NSCalendarUnit unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *breakdownInfo = [calendar components:unitFlags fromDate:currentDate toDate:expiry  options:0];
    
    if ([breakdownInfo year] > 0) {
        return [NSString stringWithFormat:@"Expires in %ld years", (long)[breakdownInfo year]];
    }
    else if ([breakdownInfo month] > 0) {
        return [NSString stringWithFormat:@"Expires in %ld months", (long)[breakdownInfo month]];
    }
    else if ([breakdownInfo day] > 0) {
        return [NSString stringWithFormat:@"Expires in %ld days", (long)[breakdownInfo day]];
    }
    else if ([breakdownInfo hour] > 0) {
        return [NSString stringWithFormat:@"Expires in %ld hours", (long) [breakdownInfo hour]];
    }
    else if ([breakdownInfo minute] > 0) {
        return [NSString stringWithFormat:@"Expires in %ld minutes", (long) [breakdownInfo minute]];
    }
    else {
        return @"Expires in 1 minute";
    }

}
@end

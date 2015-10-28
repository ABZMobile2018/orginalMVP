//
//  AirbrowzCommons.h
//  Airbrowz
//
//  Created by Denny on 2015-10-27.
//  Copyright © 2015 Kiwi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirbrowzCommons : NSObject

#define USER_DEFAULT_CATEGORY_KEY @"categoriesFilter"
/*
 0=Fashion , 1=Food, 2=Electronics, 3=Entertainment, 4=Health/Fitness, 5=Service, 6=Lifestyle. 7=Furniture, 8=Misc
 */
typedef enum {
    FASHION,
    FOOD,
    ELECTRONICS,
    ENTERTAINMENT,
    HEALTH_FITNESS,
    SERVICE,
    LIFESTYLE,
    FURNITURE,
    MISC
} DealCategory;


@end

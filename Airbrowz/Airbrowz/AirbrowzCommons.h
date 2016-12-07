//
//  AirbrowzCommons.h
//  Airbrowz

#import <Foundation/Foundation.h>

@interface AirbrowzCommons : NSObject

#define USER_DEFAULT_CATEGORY_KEY @"categoriesFilter"
#define USER_DEFAULT_PROXIMITY_KEY @"proximitySettings"
#define USER_DEFAULT_DATA_VERSION @"dataVersion"
/*
 0=Fashion , 1=Food, 2=Electronics, 3=Entertainment, 4=Health/Fitness, 5=Service, 6=Lifestyle. 7=Furniture, 8=Misc
 */
typedef enum {
    MaternityAndChildrensWear,
    MensFashion,
    WomensFashion,
    BooksMusicGamesGifts,
    ComputersTabletsMobiles,
    HandbagsFootwear,
    HealthBeauty,
    FitnessWellBeing,
    FoodDrink,
    ElectronicsEntertainment,
    Automotive,
    HomeGarden,
    Services,
    SportsOutdoorTravel,
    Events,
    Grocery,
    Misc
} DealCategory;

+ (NSString *) stringForExpirayLabel : (NSDate *) expiry;
+ (NSString *) stringForHoursFormat: (NSString *) hours;
@end

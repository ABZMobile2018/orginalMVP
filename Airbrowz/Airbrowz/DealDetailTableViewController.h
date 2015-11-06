//
//  DealDetailTableViewController.h
//  Airbrowz
//
//  Created by Denny on 2015-11-01.
//  Copyright © 2015 Kiwi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface DealDetailTableViewController : UITableViewController

- (IBAction)onGoogleMapsButtonClick:(id)sender;

typedef enum {
    Cell_CompanyDetails,
    Cell_MainDealImage,
    Cell_GoogleMaps,
    Cell_YoutubeVideo,
    Cell_MoreDealsHeading
} CellType;

@property(strong, nonatomic) PFObject *model;
@property(strong, nonatomic) NSArray *moreDealsModel;

@end

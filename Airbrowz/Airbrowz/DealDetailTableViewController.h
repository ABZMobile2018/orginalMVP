//
//  DealDetailTableViewController.h
//  Airbrowz

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface DealDetailTableViewController : UITableViewController

- (IBAction)onGoogleMapsButtonClick:(id)sender;


typedef enum {
    Cell_CompanyDetails,
    Cell_GoogleMaps,
    Cell_YoutubeVideo,
    Cell_MoreDealsHeading,
    Cell_MainDealImage,
} CellType;

@property(strong, nonatomic) PFObject *model;
@property(strong, nonatomic) NSArray *moreDealsModel;

@end

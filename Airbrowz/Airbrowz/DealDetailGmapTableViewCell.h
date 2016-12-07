//
//  DealDetailGmapTableViewCell.h
//  Airbrowz


#import <UIKit/UIKit.h>
@import GoogleMaps;
@interface DealDetailGmapTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;

@property (weak, nonatomic) IBOutlet GMSMapView *mapPlaceholder;

@end

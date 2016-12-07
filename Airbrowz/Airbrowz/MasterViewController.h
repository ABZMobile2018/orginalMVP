//
//  MasterViewController.h
//  Airbrowz

#import <UIKit/UIKit.h>

@interface MasterViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *proximityRangeLabel;
@property (weak, nonatomic) IBOutlet UISlider *proximitySlider;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryArrow;


- (IBAction)onProximitySelect:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;



@end

//
//  DealDetailDealTableViewCell.h
//  Airbrowz

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

@interface DealDetailDealTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *dealImageView;
@property (weak, nonatomic) IBOutlet UILabel *dealHeading;
@property (weak, nonatomic) IBOutlet UILabel *expiryLabel;

@end

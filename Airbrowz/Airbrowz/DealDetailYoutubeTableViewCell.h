//
//  DealDetailYoutubeTableViewCell.h
//  Airbrowz


#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface DealDetailYoutubeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet YTPlayerView *youtubePlaceholder;

@end

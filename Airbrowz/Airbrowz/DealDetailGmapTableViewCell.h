//
//  DealDetailGmapTableViewCell.h
//  Airbrowz
//
//  Created by Denny on 2015-11-01.
//  Copyright © 2015 Kiwi. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;
@interface DealDetailGmapTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;

@property (weak, nonatomic) IBOutlet GMSMapView *mapPlaceholder;

@end

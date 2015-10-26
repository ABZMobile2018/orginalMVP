//
//  DealTableViewCell.h
//  Airbrowz
//
//  Created by Denny on 2015-10-26.
//  Copyright © 2015 Kiwi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *dealHeadingLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealDistanceLabel;

@end
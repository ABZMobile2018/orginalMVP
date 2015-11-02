//
//  DealDetailDealTableViewCell.h
//  Airbrowz
//
//  Created by Denny on 2015-11-01.
//  Copyright © 2015 Kiwi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

@interface DealDetailDealTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *dealImageView;
@property (weak, nonatomic) IBOutlet UILabel *dealHeading;

@end

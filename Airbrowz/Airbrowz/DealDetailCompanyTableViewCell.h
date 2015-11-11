//
//  DealDetailCompanyTableViewCell.h
//  Airbrowz
//
//  Created by Denny on 2015-11-01.
//  Copyright © 2015 Kiwi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

@interface DealDetailCompanyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *companyLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyHoursLabel;
@property (weak, nonatomic) IBOutlet UIImageView *facebookLogo;

@property (strong, nonatomic) NSString *facebookId;

@end

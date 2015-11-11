//
//  DealDetailCompanyTableViewCell.m
//  Airbrowz
//
//  Created by Denny on 2015-11-01.
//  Copyright © 2015 Kiwi. All rights reserved.
//

#import "DealDetailCompanyTableViewCell.h"

@implementation DealDetailCompanyTableViewCell

- (void)awakeFromNib {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onFacebookLogoTab)];
    singleTap.numberOfTapsRequired = 1;
    [self.facebookLogo setUserInteractionEnabled:YES];
    [self.facebookLogo addGestureRecognizer:singleTap];
    

}

-(void)onFacebookLogoTab{
    NSString *urlString = [NSString stringWithFormat:@"fb://profile/%@", self.facebookId];
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
    if ([[UIApplication sharedApplication] canOpenURL:url]){
        // Facebook app exists
        [[UIApplication sharedApplication] openURL:url];
    }
    else {
        // Open with webbrowser
        urlString = [NSString stringWithFormat:@"http://www.facebook.com/%@", self.facebookId];
        url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

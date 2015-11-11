//
//  DealTableViewCell.m
//  Airbrowz
//
//  Created by Denny on 2015-10-26.
//  Copyright © 2015 Kiwi. All rights reserved.
//

#import "DealTableViewCell.h"

@implementation DealTableViewCell

- (void)awakeFromNib {
    // Initialization code


    
//    CALayer *divider = [CALayer layer];
//    int dividerX = self.dealDistanceLabel.frame.origin.x;
//    int dividerY = self.dealDistanceLabel.frame.origin.y;
//    int dividerW = self.dealDistanceLabel.frame.size.width;
//    int dividerH = 1;
//    divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
//
//    divider.backgroundColor = [UIColor blueColor].CGColor;
//    [self.layer addSublayer: divider];
    
//    self.dealDistanceLabel.layer.borderColor = [UIColor blackColor].CGColor;
//    self.dealDistanceLabel.layer.borderWidth = borderWidth;

    
    // Create the mask to cover the area of the view you want to **show**
    // Here, we create a mask that covers most of the view, except the left edge
    // The mask needs to be coloured in black, as black acts as transparent, whereas white is opaque in mask parlance
//    UIView* mask = [[UIView alloc] initWithFrame:CGRectMake(borderWidth, 0, view.frame.size.width - borderWidth, view.frame.size.height)];
//    mask.backgroundColor = [UIColor blackColor];
//    view.layer.mask = mask.layer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
